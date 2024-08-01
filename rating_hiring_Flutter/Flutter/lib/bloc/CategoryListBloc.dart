import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/CategoryDetailEvent.dart';
import 'package:rentors/event/CategoryListEvent.dart';
import 'package:rentors/event/ChangeSubCategory.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/SubCategoryDetailEvent.dart';
import 'package:rentors/event/SubCategoryEvent.dart';
import 'package:rentors/repo/CategoryRepo.dart' as categoryRepo;
import 'package:rentors/repo/SubscriptionRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CategoryDetailState.dart';
import 'package:rentors/state/CategoryListState.dart';
import 'package:rentors/state/ChangeSubCategoryState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SubCategoryDetailState.dart';
import 'package:rentors/state/SubCategoryListState.dart';

class CategoryListBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is CategoryListEvent) {
      yield LoadingState();
      var subscripeResponse = await checkSubscription();
      var response = await categoryRepo.getCategoryList();
      var userDetails = await categoryRepo.getUserDetail();
      yield CategoryListState(response, checkuser: subscripeResponse,userDetail: userDetails);
    } else if (event is CategoryDetailEvent) {
      yield LoadingState();
      var response = await categoryRepo.getCategoryDetails(event.id);
      yield CategoryDetailState(response);
    } else if (event is SubCategoryEvent) {
      yield LoadingState();
      await categoryRepo.getSubCategory();
      yield SubCategoryListState(event.category.subCategory);
    } else if (event is ChangeSubCategory) {
      yield LoadingState();
      await categoryRepo.getSubCategory();
      yield ChangeSubCategoryState(event.category);
    } else if (event is SubCategoryDetailEvent) {
      yield LoadingState();
      var res = await categoryRepo.getSubCategoryDetail(event.id, event.page);
      yield SubCategoryDetailState(res);
    }else if (event is CityEvent) {
      yield LoadingState();
      var res = await categoryRepo.getCity();
      yield CityState(res);
    }
  }
}
