abstract class LoginStates{}

class InitialLoginStates extends LoginStates{}

class LoginSuccessState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{
  String error;
  LoginErrorState(this.error);
}
class RegisterGetImageState extends LoginStates{}