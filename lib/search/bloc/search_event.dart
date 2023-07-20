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
