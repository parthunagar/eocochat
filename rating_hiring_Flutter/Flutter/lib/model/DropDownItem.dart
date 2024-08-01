import 'package:equatable/equatable.dart';

class DropDownItem extends Equatable {
  final dynamic key;
  final String value;

  DropDownItem(this.key, this.value);

  @override
  // TODO: implement props
  List<Object> get props => [key, value];
}
