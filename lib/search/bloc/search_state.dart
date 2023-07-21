part of 'search_bloc.dart';

enum SearchStatus { initial, loaading, success, failure, cleared }

final class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.searchResult = const <RetrievedAddress>[],
  });

  SearchState copyWith({
    SearchStatus? status,
    List<RetrievedAddress>? searchResult,
  }) {
    return SearchState(
      searchResult: searchResult ?? this.searchResult,
      status: status ?? this.status,
    );
  }

  final SearchStatus status;
  final List<RetrievedAddress> searchResult;
  @override
  List<Object> get props => [status, searchResult];
}
