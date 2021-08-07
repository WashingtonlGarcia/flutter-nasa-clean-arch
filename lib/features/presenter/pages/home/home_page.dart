import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/http_client/http_client_impl.dart';
import '../../../data/datasources/nasa_datasource_impl.dart';
import '../../../data/repositories/space_media_repository_impl.dart';
import '../../../domain/usecases/get_space_media_from_date_use_case.dart';
import '../../controllers/home/home_bloc.dart';
import '../../theme/app_theme.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => HomeBloc(
          usecase: GetSpaceMediaFromDateUsecase(repository: SpaceMediaRepositoryImpl(datasource: NasaDatasourceImpl(httpClient: HttpClientImpl()))))
        ..add(HomeGetSpaceMediaFromDateEvent(dateTime: DateTime.now())),
      child: _HomePage());
}

class _HomePage extends StatelessWidget {
  Future<void> changeDate(BuildContext context) async {
    final result = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 30)), lastDate: DateTime.now());
    if (result != null) context.read<HomeBloc>().add(HomeGetSpaceMediaFromDateEvent(dateTime: result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: CustomAppBarWidget(onTap: () => changeDate(context)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccessState) {
            final entity = state.entity;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(padding: const EdgeInsets.all(16), child: Text(entity.title, style: AppTheme.textStyles.subtitle2)),
                Image.network(entity.mediaUrl),
                Padding(padding: const EdgeInsets.all(16.0), child: Text(entity.description, style: AppTheme.textStyles.body2)),
              ],
            );
          } else {
            return Center(
              child: Text('Error', style: AppTheme.textStyles.subtitle2),
            );
          }
        },
      ),
    );
  }
}
