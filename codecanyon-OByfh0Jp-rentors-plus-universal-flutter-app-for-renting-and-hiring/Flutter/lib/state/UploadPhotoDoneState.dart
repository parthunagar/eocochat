import 'package:rentors/model/UploadPicsModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/util/TypeEnum.dart';

class UploadPhotoDoneState extends BaseState {
  final UploadPicsModel home;
  final TypeEnum typeEnum;

  UploadPhotoDoneState(this.home, this.typeEnum);
}
