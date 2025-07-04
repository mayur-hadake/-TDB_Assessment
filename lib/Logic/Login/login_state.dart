abstract class LoginState{

}
class LoginLoadingState extends LoginState{

}
class LoginLoadedState extends LoginState{

}
class LoginErrorState extends LoginState{
  String error;
  LoginErrorState(this.error);
}