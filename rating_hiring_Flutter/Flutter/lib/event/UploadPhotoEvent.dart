import 'package:image_picker/image_picker.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/util/TypeEnum.dart';

class UploadPhotoEvent extends BaseEvent {
  final PickedFile file;
  final TypeEnum typeEnum;
  UploadPhotoEvent(this.file, this.typeEnum);
}
