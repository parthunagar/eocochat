import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/NearBySearchEvent.dart';
import 'package:rentors/event/SearchEvent.dart';
import 'package:rentors/repo/SearchRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SearchState.dart';

class SearchBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => ProgressDialogState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is SearchEvent) {
      yield LoadingState();
      try {
        var response = await searchResult(event.search);
        yield SearchState(response);
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    }else if (event is NearBySearchEvent) {
      yield LoadingState();
      try {
        var response = await nearBySearchResult(event.latLng);
        yield SearchState(response);
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    }
  }
}
