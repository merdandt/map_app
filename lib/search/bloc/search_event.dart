part of 'search_bloc.dart';

final class SearchEvent extends Equatable {
  const SearchEvent(this.desiredAddress);
  final String desiredAddress;
  @override
  List<Object?> get props => [desiredAddress];
}
