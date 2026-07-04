# CAPTCHA Feature - Implementation Guide

## Overview
The CAPTCHA feature handles math-based verification questions from your backend. It includes:
- **Service Layer**: Fetches and validates CAPTCHA
- **BLoC**: State management for CAPTCHA operations
- **Widget**: UI component for displaying and inputting CAPTCHA

## Backend Response Format
```json
{
  "captchaId": "17b1e8ec-58e3-47f9-91dd-3f1d8adfd627",
  "question": "7 + 8 = ?",
  "expiresInSeconds": 300
}
```

## Setup

The CAPTCHA service is already registered in `lib/core/di/injector.dart`. No additional setup needed!

### Use in Your App
Simply provide the BLoC in your widget tree:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/features/captcha/screens/captcha_widget.dart';
import 'package:noteapp/features/captcha/captcha_setup.dart';

BlocProvider(
  create: (context) => getCaptchaBloc(),
  child: const CaptchaWidget(
    onSuccess: _handleCaptchaSuccess,
    onError: _handleCaptchaError,
  ),
)
```

## Widget Usage

### Basic Usage
```dart
CaptchaWidget(
  onSuccess: () {
    print('CAPTCHA verified!');
  },
  onError: (errorMessage) {
    print('CAPTCHA error: $errorMessage');
  },
)
```

### Custom Setup
```dart
CaptchaWidget(
  autoFetch: false, // Don't auto-load CAPTCHA
  onSuccess: _handleSuccess,
  onError: _handleError,
)
```

## API Reference

### CaptchaService Methods

#### `fetchCaptcha()`
Fetches a new CAPTCHA from the backend.
```dart
final result = await captchaService.fetchCaptcha();
result.fold(
  (captcha) {
    // Success: Use captcha.captchaId, captcha.question, captcha.expiresInSeconds
  },
  (error) {
    // Error: error.message, error.code
  },
);
```

#### `validateCaptcha()`
Submits the user's answer for validation.
```dart
final result = await captchaService.validateCaptcha(
  captchaId: '17b1e8ec-58e3-47f9-91dd-3f1d8adfd627',
  answer: '15',
);
result.fold(
  (isValid) {
    if (isValid) {
      // CAPTCHA verified
    }
  },
  (error) {
    // Handle error
  },
);
```

#### `isCaptchaExpired()`
Checks if a CAPTCHA has expired.
```dart
bool isExpired = captchaService.isCaptchaExpired(
  fetchedTime,
  expiresInSeconds,
);
```

### BLoC Events

1. **FetchCaptchaEvent** - Load a new CAPTCHA
   ```dart
   context.read<CaptchaBloc>().add(const FetchCaptchaEvent());
   ```

2. **SubmitCaptchaAnswerEvent** - Submit answer
   ```dart
   context.read<CaptchaBloc>().add(
         SubmitCaptchaAnswerEvent(
           captchaId: 'id',
           answer: 'user_answer',
         ),
       );
   ```

3. **RefreshCaptchaEvent** - Get a new CAPTCHA
   ```dart
   context.read<CaptchaBloc>().add(const RefreshCaptchaEvent());
   ```

4. **ResetCaptchaEvent** - Reset to initial state
   ```dart
   context.read<CaptchaBloc>().add(const ResetCaptchaEvent());
   ```

### BLoC States

- **CaptchaInitial** - Initial state
- **CaptchaLoading** - Fetching CAPTCHA
- **CaptchaLoaded** - CAPTCHA ready for input
- **CaptchaValidating** - Validating user's answer
- **CaptchaValidationSuccess** - Answer is correct
- **CaptchaValidationFailure** - Answer is incorrect
- **CaptchaExpired** - CAPTCHA expired
- **CaptchaError** - Network or other error

## Features

✅ Auto-fetch CAPTCHA on widget initialization  
✅ Automatic expiration detection  
✅ Retry mechanism  
✅ Error handling  
✅ Loading states  
✅ Responsive UI  
✅ Customizable callbacks  

## Example Integration

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your login form fields...
              const SizedBox(height: 24),
              BlocProvider(
                create: (context) => getCaptchaBloc(),
                child: CaptchaWidget(
                  onSuccess: () {
                    // Proceed with login
                    _performLogin();
                  },
                  onError: (error) {
                    // Show error message
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Testing

The CAPTCHA service follows the same pattern as other services in the app, using `Either<T, ErrorModel>` for error handling.

## Troubleshooting

### CAPTCHA not loading
- Check if the endpoint is correctly set in `lib/constants/api_urls.dart`
- Verify DioClient is properly configured with authentication headers if needed
- Check network connectivity
- Ensure backend is responding with the correct JSON format

### Validation always fails
- Ensure backend validation endpoint is working correctly
- Check if the answer format matches what backend expects
- Verify captchaId is being sent correctly
- Check ErrorModel in the response has correct fields

### Expiration not working
- Ensure `expiresInSeconds` from backend is an integer
- Check system time is synchronized

## Backend API Contract

The CAPTCHA service uses the endpoint: `ApiUrls.captchaChallenge` (defined in `lib/constants/api_urls.dart`)

### Fetch CAPTCHA
**Method:** GET  
**Endpoint:** `/api/auth/captcha/challenge`

**Response (Success - 200/201):**
```json
{
  "captchaId": "17b1e8ec-58e3-47f9-91dd-3f1d8adfd627",
  "question": "7 + 8 = ?",
  "expiresInSeconds": 300
}
```

### Validate CAPTCHA
**Method:** POST  
**Endpoint:** `/api/auth/captcha/challenge`

**Request Body:**
```json
{
  "captchaId": "17b1e8ec-58e3-47f9-91dd-3f1d8adfd627",
  "answer": "15"
}
```

**Response (Success - 200/201):**
```json
{
  "isValid": true
}
```

**Error Response (Any error code):**
```json
{
  "message": "Error message here",
  "status": 400
}
```

## Files Structure

```
lib/features/captcha/
├── bloc/
│   ├── catpcha_bloc.dart       (State management)
│   ├── captcha_event.dart      (Events)
│   └── captcha_state.dart      (States)
├── models/
│   └── captcha_model.dart      (Data model)
├── service/
│   └── captcha_service.dart    (Business logic)
├── screens/
│   └── captcha_widget.dart     (UI component)
├── captcha_setup.dart          (Helper functions)
└── CAPTCHA_README.md           (This file)
```

## Architecture

The CAPTCHA feature follows the clean architecture pattern used throughout the app:

- **Service Layer** (`captcha_service.dart`): Handles API communication using `DioClient` and `Either<T, ErrorModel>` for functional error handling
- **BLoC Layer** (`catpcha_bloc.dart`): Manages state and business logic
- **UI Layer** (`captcha_widget.dart`): Displays CAPTCHA and handles user input
- **Models** (`captcha_model.dart`): Data classes with JSON serialization

All services are registered in `lib/core/di/injector.dart` following the existing DI pattern.
