import 'package:rentors/model/subscription/CheckSubscriptionModel.dart';
import 'package:rentors/state/BaseState.dart';

class CheckUserState extends BaseState {
  final CheckSubscriptionModel mModel;

  CheckUserState(this.mModel);
}
