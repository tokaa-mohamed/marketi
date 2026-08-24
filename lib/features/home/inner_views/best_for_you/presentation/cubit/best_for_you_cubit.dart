import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_best_for_you_use_case.dart';
import 'best_for_you_state.dart';

class BestForYouCubit extends Cubit<BestForYouState> {
  final GetBestForYouUseCase getBestForYouUseCase;

  BestForYouCubit(this.getBestForYouUseCase) : super(BestForYouInitial());

  Future<void> getBestForYouProducts() async {
    emit(BestForYouLoading());
    final result = await getBestForYouUseCase();
    result.fold(
      (failure) => emit(BestForYouError(failure.message)),
      (products) => emit(BestForYouSuccess(products)),
    );
  }
}
