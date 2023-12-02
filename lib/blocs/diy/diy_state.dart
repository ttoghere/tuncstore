part of 'diy_bloc.dart';

sealed class DiyState extends Equatable {
  const DiyState();

  @override
  List<Object> get props => [];
}

class DiyLoading extends DiyState {}

class DiyLoaded extends DiyState {
  final List<DIYModel> diyModel;

  const DiyLoaded({required this.diyModel});

  @override
  List<Object> get props => [diyModel];
}
