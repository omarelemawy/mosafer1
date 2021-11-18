abstract class DrawerState{}

class InitialDrawerState extends DrawerState{}
class GetLoadingMosaferInformationStates extends DrawerState{}
class GetSuccessMosaferInformationStates extends DrawerState{}
class GetErrorMosaferInformationStates extends DrawerState{
  String error;
  GetErrorMosaferInformationStates(this.error);
}
class EditProfileLoadingStates extends DrawerState{}
class EditProfileSuccessStates extends DrawerState{}
class EditProfileErrorStates extends DrawerState{
  String error;
  EditProfileErrorStates(this.error);
}

