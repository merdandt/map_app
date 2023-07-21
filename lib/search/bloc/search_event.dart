part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class StreetSearched extends SearchEvent {
  const StreetSearched(this.desiredAddress);
  final String desiredAddress;
  @override
  List<Object> get props => [desiredAddress];
}

final class SearchCleared extends SearchEvent {
  const SearchCleared();
  @override
  List<Object?> get props => [];
}

final class SearchMoved extends SearchEvent {
  const SearchMoved({required this.isMoving});
  final bool isMoving;
  @override
  List<Object?> get props => [isMoving];
}
