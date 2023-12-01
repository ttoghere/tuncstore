// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'diy_bloc.dart';

sealed class DiyEvent extends Equatable {
  const DiyEvent();

  @override
  List<Object> get props => [];
}

class LoadDIY extends DiyEvent {}

class ShowDIY extends DiyEvent {
  final List<DIYModel> recipes;
  const ShowDIY({
    required this.recipes,
  });
  @override
  // TODO: implement props
  List<Object> get props => [recipes];
}
