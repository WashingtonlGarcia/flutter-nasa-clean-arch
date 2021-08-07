import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/http_client/http_client_impl.dart';
import '../../../data/datasources/nasa_datasource_impl.dart';

import '../../../data/repositories/space_media_repository_impl.dart';

import '../../../domain/usecases/get_space_media_from_date_use_case.dart';
import '../../controllers/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => HomeBloc(
          usecase: GetSpaceMediaFromDateUsecase(repository: SpaceMediaRepositoryImpl(datasource: NasaDatasourceImpl(httpClient: HttpClientImpl()))))
        ..add(HomeGetSpaceMediaFromDateEvent(dateTime: DateTime.now())),
      child: _HomePage());
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe4ddd9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40, width: 40, child: Image.asset('lib/features/presenter/assets/images/nasa.png', fit: BoxFit.cover)),
            const SizedBox(width: 4),
            const Text('APOD')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (result != null) context.read<HomeBloc>().add(HomeGetSpaceMediaFromDateEvent(dateTime: result));
              },
              icon: const Icon(Icons.calendar_today))
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccessState) {
            final entity = state.entity;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    entity.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
                  ),
                ),
                Image.network(entity.mediaUrl),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(entity.description, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF333333))),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Error',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
              ),
            );
          }
        },
      ),
    );
  }
}
