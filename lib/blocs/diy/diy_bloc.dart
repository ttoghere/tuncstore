import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuncstore/models/diy_model.dart';
import 'package:tuncstore/repositories/diy/diy_repository.dart';

part 'diy_event.dart';
part 'diy_state.dart';

class DiyBloc extends Bloc<DiyEvent, DiyState> {
  final DIYRepository _diyRepository;
  StreamSubscription? diySubscription;
  DiyBloc({required DIYRepository diyRepository})
      : _diyRepository = diyRepository,
        super(DiyLoading()) {
    on<LoadDIY>(_onLoadRecipes);
    on<ShowDIY>(_onShowDIY);
  }

  void _onLoadRecipes(
    LoadDIY event,
    Emitter<DiyState> emit,
  ) {
    diySubscription?.cancel();
    diySubscription = _diyRepository.getDIYitems().listen(
          (recipes) => add(ShowDIY(recipes: recipes)),
        );
  }

  void _onShowDIY(ShowDIY event, Emitter<DiyState> emit) {
    emit(
      DiyLoaded(diyModel: event.recipes),
    );
  }
}
