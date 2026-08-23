import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_home_data_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeCubit(this.getHomeDataUseCase) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    final result = await getHomeDataUseCase();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (homeData) => emit(HomeSuccess(homeData)),
    );
  }
}
