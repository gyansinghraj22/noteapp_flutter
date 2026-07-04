class ApiUrls {
  static const String qaBaseUrl = '';

  // static const String liveBaseUrl = 'http://localhost:8080';

  // static const String devBaseUrl = 'https://api.dev.proflowapps.com/api/v1/';
  static const String devBaseUrl = 'http://192.168.1.12:8080/';

  // For Android Emulator use:
  // static const String devBaseUrl = 'http://10.0.2.2:8080/';

  static const String stagingBaseUrl = '';
  static const String login = 'api/auth/login';
  static const String loginOtp = 'api/auth/login/otp';
  static const String loginhBackUpCode = 'api/auth/login/backup-code';
  static const String enable2FA = 'api/auth/2fa/enable';
  static const String enableVerify = 'api/auth/2fa/enable/verify';
  static const String disable2FA = 'api/auth/2fa/disable';
  static const String refreshToken = 'api/auth/refresh';
  static const String logout = 'api/auth/logout';

  static const String register = "api/auth/register";
  static const String signUpOtp = "api/auth/register/otp/send";
  static const String captchaChallenge = '/api/auth/captcha/challenge';

  static const String getUserProfile = 'api/v1/user-profile';
  static const String updateUserProfile = 'api/v1/update/user-details';

  static const String notes = "api/notes";

  static const String downloadNetworkExcelFile =
      'api/v1/export-zip/excel/networkID';
  static const String downloadNetworkCSVFile =
      'api/v1/export-zip/csv/networkID';
  static const String resetPassword = 'api/v1/change-password';
  static const String uploadProfilePicture = 'api/v1/profile-picture';
  // static const String register = 'api/v1/register';

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
