import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/di.dart';
import '../../domain/entities/home_dummy_data.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_body.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeData(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeSuccess) {
                final homeData =
                    state is HomeSuccess ? state.homeData : HomeDummyData.homeData;
                return Skeletonizer(
                  enabled: state is HomeLoading,
                  child: RefreshIndicator(
                    onRefresh: () => context.read<HomeCubit>().getHomeData(),
                    child: HomeBody(homeData: homeData),
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.read<HomeCubit>().getHomeData(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
