class ApiUrls {
  static const String qaBaseUrl = '';

  static const String liveBaseUrl = 'https://api.proflowapps.com/';
  // static const String devBaseUrl = 'https://api.dev.proflowapps.com/api/v1/';
  static const String devBaseUrl = 'https://api-dev.proflowapps.com/';

  static const String stagingBaseUrl = '';
  static const String login = 'api/v1/login';
  static const String dashboardTrees = 'api/v1/tree/list';
  static const String downloadNetworkExcelFile =
      'api/v1/export-zip/excel/networkID';
  static const String downloadNetworkCSVFile =
      'api/v1/export-zip/csv/networkID';
  static const String resetPassword = 'api/v1/change-password';
  static const String uploadProfilePicture = 'api/v1/profile-picture';
  static const String register = 'api/v1/register';
  static const String createNetwork = 'api/v1/add/tree';
  static const String editTree = 'api/v1/update/tree';
  static const String deleteNetwork = 'api/v1/delete/tree/networkID';
  static const String networkTreeList = 'api/v1/tree/members/userID';
  static const String allowedParentList =
      'api/v1/allowed-parent/networkID/memberID';
  static const String editTreeMember = 'api/v1/update/member';
  static const String addMultipleMembers = 'api/v1/members/networkID';
  static const String saveUserInfoData = 'api/v1/save-details';
  static const String sendOtp = 'api/v1/send-otp';
  static const String verifyOTP = 'api/v1/verify-otp';
  static const String verifyPasswordOTP = 'api/v1/verify-pwd-otp';
  static const String getAllTrees = 'api/v1/tree/members/userID';
  static const String getTreeChild = 'api/v1/member/memberID/children';
  static const String uploadExcelFile = 'api/v1/upload-excel';
  static const String uploadCSVFile = 'api/v1/upload-csv';
  static const String insertSelectedMemberTree = 'api/v1/member/update-parent';
  static const String deleteMember = 'api/v1/delete/member/networkID/memberID';
  static const String updateMemberNodePosition = 'api/v1/update/position';
  static const String getProfileInfo = 'api/v1/user-profile';
  static const String updateProfileInfo = 'api/v1/update/user-details';
}

final List<String> noAuthPaths = [
  ApiUrls.login,
  ApiUrls.register,
  ApiUrls.sendOtp,
  ApiUrls.verifyOTP,
  ApiUrls.resetPassword,
];
