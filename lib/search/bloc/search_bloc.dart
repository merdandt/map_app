import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:map_repository/map_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._mapRepository) : super(const SearchState()) {
    on<StreetSearched>(
      _onSearch,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SearchCleared>(_onSearchCleared);
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchResult: []));
  }

  Future<void> _onSearch(
    StreetSearched event,
    Emitter<SearchState> emit,
  ) async {
    if (event.desiredAddress.isEmpty) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loaading));
    try {
      final result = await _mapRepository.search(event.desiredAddress);
      if (result == null) {
        return emit(state.copyWith(status: SearchStatus.failure));
      }
      emit(state.copyWith(status: SearchStatus.success, searchResult: result));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  final MapRepository _mapRepository;
}
