import 'package:mosafer1/model/mosafer_information_model.dart';

abstract class DrawerState{}

class InitialDrawerState extends DrawerState{}
class GetLoadingMosaferInformationStates extends DrawerState{}
class GetSuccessMosaferInformationStates extends DrawerState{}
class GetErrorMosaferInformationStates extends DrawerState{
  String error;
  GetErrorMosaferInformationStates(this.error);
}

class GetLoadingUserInformationStates extends DrawerState{}
class GetSuccessUserInformationStates extends DrawerState{
  MosafrInformationModel mosafrInformationModel;
  GetSuccessUserInformationStates(this.mosafrInformationModel);
}
class GetErrorUserInformationStates extends DrawerState{
  String error;
  GetErrorUserInformationStates(this.error);
}

class EditProfileLoadingStates extends DrawerState{}
class CustomerServiceGetImageState extends DrawerState{}
class EditProfileSuccessStates extends DrawerState{}
class EditProfileErrorStates extends DrawerState{
  String error;
  EditProfileErrorStates(this.error);
}

class GetErrorFreeServiceModelStates extends DrawerState{
  String error;
  GetErrorFreeServiceModelStates(this.error);
}
class GetSuccessFreeServiceModelStates extends DrawerState{}
class GetLoadingFreeServiceModelStates extends DrawerState{}
class AddIteOfInformFreeServiceState extends DrawerState{}

class CreateFreeServiceErrorStates extends DrawerState{
  String error;
  CreateFreeServiceErrorStates(this.error);
}
class CreateFreeServiceSuccessStates extends DrawerState{}
class CreateFreeServiceLoadingStates extends DrawerState{}
class CreateFreeServiceGetImageState extends DrawerState{}

class GetErrorDeleteFreeServiceStates extends DrawerState{
  String error;
  GetErrorDeleteFreeServiceStates(this.error);
}
class GetSuccessDeleteFreeServiceStates extends DrawerState{}
class GetLoadingDeleteFreeServiceStates extends DrawerState{}