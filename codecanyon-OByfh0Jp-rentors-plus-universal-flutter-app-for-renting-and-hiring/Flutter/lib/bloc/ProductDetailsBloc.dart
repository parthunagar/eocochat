import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/AllProductEvent.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ProductDetailsEvent.dart';
import 'package:rentors/repo/ProductDetailRepo.dart' as product;
import 'package:rentors/state/AllProductState.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/ProductDetailsState.dart';

class ProductDetailsBloc extends Bloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ProductDetailsEvent) {
      yield LoadingState();
      var response = await product.getProductDetails(event.id);
      yield ProductDetailsState(response);
    } else if (event is AllProductEvent) {
      yield LoadingState();
      var response = await product.getAllProduct(event.id, event.page);
      yield AllProductState(response);
    }
  }
}
