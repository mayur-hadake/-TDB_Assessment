import 'package:time_dignitor_task/Data/Model/profile_response.dart';

abstract class ProfileState{

}

class ProfileLoadingState extends ProfileState{

}

class ProfileLoadedState extends ProfileState{
  ProfileResponse response;
  ProfileLoadedState (this.response);
}

class ProfileErrorState extends ProfileState{
  String error;
  ProfileErrorState(this.error);
}
