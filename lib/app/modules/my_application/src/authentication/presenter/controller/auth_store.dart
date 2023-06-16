import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/use_cases_interfaces/auth_signup_user_case_contract.dart';

import '../../domain/use_cases_interfaces/auth_signin_user_case_contract.dart';
import '../../domain/use_cases_interfaces/auth_signout_user_case_contract.dart';
import '../../domain/user_credencial_entity.dart';

class AuthStore extends Store<UserCredentialApp?> {
  late final IAuthSignInUseCase _userSignIn;
  late final IAuthSignOutUseCase _userSignOut;
  late final IAuthSignUpUseCase _userSignUp;

  bool _isAuth = false;

  AuthStore({
    required IAuthSignInUseCase userSignIn,
    required IAuthSignOutUseCase userSignOut,
    required IAuthSignUpUseCase userSignUp,
  }) : super(null) {
    _userSignIn = userSignIn;
    _userSignOut = userSignOut;
    _userSignUp = userSignUp;
  }
  bool get isAuth => _isAuth;

  Future<void> userSignIn(
      {required String email, required String password}) async {
    setLoading(true);
    var result = await _userSignIn(email, password);
    //await Future.delayed(const Duration(seconds: 5), () {});
    result.fold(
      (error) => setError(error),
      (userCredential) {
        _isAuth = true;
        update(userCredential);
      },
    );
    setLoading(false);
  }

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String name}) async {
    setLoading(true);
    var result = await _userSignUp(email, password, name);
    //await Future.delayed(const Duration(seconds: 5), () {});
    result.fold(
      (error) => setError(error),
      (userCredential) {
        _isAuth = true;
        update(userCredential);
      },
    );
    setLoading(false);
  }

  Future<void> userSignOut() async {
    await _userSignOut.call();
    UserCredentialApp? signOut = null;
    _isAuth = false;
    update(signOut, force: true);
  }
}
