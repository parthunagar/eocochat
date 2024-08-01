import 'package:equatable/equatable.dart';

class ImagePicked extends Equatable {
  final String imageUrl;

  ImagePicked(this.imageUrl);

  @override
  // TODO: implement props
  List<Object> get props => [imageUrl];
}
