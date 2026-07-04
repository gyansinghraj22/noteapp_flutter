import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/navigation_service/navigation_service.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/features/note/bloc/note_bloc.dart';

class ListNoteScreen extends StatefulWidget {
  const ListNoteScreen({super.key});

  @override
  State<ListNoteScreen> createState() => ListNoteScreenState();
}

class ListNoteScreenState extends State<ListNoteScreen> {
  Map<String, dynamic> formData = {};

  List<CustomFormFieldConfig> formFields = [];

  bool isFetchingNotes = false;

  String selectedCategory = "All";

  final List<String> categories = ["All"];

  @override
  void initState() {
    super.initState();
    getInitialData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      context.read<NoteBloc>().add(NoteGetEvent(formData: {}));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "search",
        label: "Search notes...",
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  List<Map<String, dynamic>> _extractNotes(dynamic response) {
    if (response is List) {
      return response.whereType<Map<String, dynamic>>().toList();
    }

    if (response is Map<String, dynamic>) {
      final potentialLists = [
        response['data'],
        response['notes'],
        response['items'],
        response['results'],
      ];

      for (final entry in potentialLists) {
        if (entry is List) {
          return entry.whereType<Map<String, dynamic>>().toList();
        }

        if (entry is Map<String, dynamic>) {
          final nestedList = [
            entry['data'],
            entry['notes'],
            entry['items'],
            entry['results'],
          ];

          for (final nestedEntry in nestedList) {
            if (nestedEntry is List) {
              return nestedEntry.whereType<Map<String, dynamic>>().toList();
            }
          }
        }
      }
    }

    return [];
  }

  String _readStringField(Map<String, dynamic> note, List<String> keys) {
    for (final key in keys) {
      final value = note[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }

    return '';
  }

  String _formatNoteTime(Map<String, dynamic> note) {
    final rawValue = _readStringField(note, ['time', 'createdAt', 'updatedAt']);
    if (rawValue.isEmpty) {
      return 'Just now';
    }

    return rawValue;
  }

  String _normalizeCategory(Map<String, dynamic> note) {
    final category = _readStringField(note, ['category', 'tag', 'tags']);
    if (category.isEmpty) {
      return 'General';
    }

    return category;
  }

  List<String> _noteCategories(List<Map<String, dynamic>> notes) {
    final categories =
        notes
            .map((note) => _normalizeCategory(note))
            .where((category) => category.isNotEmpty)
            .toSet()
            .toList();
    categories.sort();
    return ['All', ...categories];
  }

  List<Map<String, dynamic>> _filterNotes(List<Map<String, dynamic>> notes) {
    final searchText = (formData['search'] ?? '').toString().toLowerCase();

    return notes.where((note) {
      final category = _normalizeCategory(note);
      final title = _readStringField(note, ['title', 'name', 'subject']);
      final description = _readStringField(note, [
        'desc',
        'description',
        'content',
        'body',
      ]);

      final matchesCategory =
          selectedCategory == 'All' || category == selectedCategory;
      final matchesSearch =
          searchText.isEmpty ||
          title.toLowerCase().contains(searchText) ||
          description.toLowerCase().contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadingState) {
          isFetchingNotes = true;
        } else {
          isFetchingNotes = false;
        }

        final notes =
            state is NoteGetSuccessState
                ? _extractNotes(state.response)
                : const <Map<String, dynamic>>[];
        final visibleNotes = _filterNotes(notes);
        final noteCategories = _noteCategories(notes);

        if (!noteCategories.contains(selectedCategory)) {
          selectedCategory = 'All';
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (!mounted) {
              return;
            }

            context.read<NoteBloc>().add(NoteGetEvent(formData: {}));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          NavigationService.navigatorKey.currentState
                              ?.pushNamed(
                                RoutePaths.searchScreen,
                                arguments: {
                                  'searchItems':
                                      notes
                                          .map(
                                            (note) => _readStringField(note, [
                                              'title',
                                              'name',
                                              'subject',
                                            ]),
                                          )
                                          .where((title) => title.isNotEmpty)
                                          .toList(),
                                  'onItemSelected': (selectedItem) {
                                    // ignore: avoid_print
                                    print('Selected: $selectedItem');
                                  },
                                },
                              );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // Filter Chips Section
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                sliver: SliverToBoxAdapter(
                  child: _horizontalFilterSection(noteCategories),
                ),
              ),

              if (state is NoteGetErrorState)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      state.errorModel.message ?? 'Failed to load notes',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else if (isFetchingNotes)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              else if (visibleNotes.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No notes found',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final note = visibleNotes[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: _buildNoteCard(note),
                      );
                    }, childCount: visibleNotes.length),
                  ),
                ),

              // Bottom padding
              SliverPadding(
                padding: EdgeInsets.only(bottom: 24.h),
                sliver: const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _horizontalFilterSection(List<String> filterCategories) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filterCategories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = filterCategories[index];
          final isSelected = category == selectedCategory;
          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                selectedCategory = category;
              });
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoteCard(Map<String, dynamic> note) {
    final title = _readStringField(note, ['title', 'name', 'subject']);
    final description = _readStringField(note, [
      'desc',
      'description',
      'content',
      'body',
    ]);
    final category = _normalizeCategory(note);
    final time = _formatNoteTime(note);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title.isEmpty ? 'Untitled note' : title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Description
          Text(
            description.isEmpty ? 'No description available' : description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),

          SizedBox(height: 8.h),

          // Category Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColor.brightSkyMain.withAlpha(30),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              category,
              style: TextStyle(color: AppColor.brightSkyMain, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
