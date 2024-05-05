class ApiEndpoints {
  static final String baseUrl = 'https://pinn-fx-api.onrender.com/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  static _AccountEndPoints accountEndPoints = _AccountEndPoints();
}

class _AuthEndPoints {
  final String register = 'auth/create';
  final String login = 'auth/authenticate';
  final String forgotPassword = 'auth/forgotPassword';
  final String verifyCode = 'auth/verifyCode';
}

class _AccountEndPoints {
  final String update = 'account/update';
  final String userData = 'account/details';
  final String linkedAccounts = 'linked/get';
  final String deposit = 'transaction/deposit';
  final String withdraw = 'transaction/withdraw';
  final String invest = 'transaction/invest';
  final String history = 'transaction/history';
  final String investmentHistory = 'get/investments';
}
