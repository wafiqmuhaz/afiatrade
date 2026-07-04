import 'package:afiatrade/controllers/dashboard/dashboard_bloc.dart';
import 'package:afiatrade/l10n/app_message_keys.dart';
import 'package:afiatrade/models/analysis_response.dart';
import 'package:afiatrade/models/app_exceptions.dart';
import 'package:afiatrade/repositories/dashboard_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  group('DashboardBloc', () {
    late MockDashboardRepository dashboardRepository;
    late List<Message> messages;

    setUp(() {
      dashboardRepository = MockDashboardRepository();
      messages = <Message>[];
    });

    blocTest<DashboardBloc, DashboardState>(
      'emits loading then loaded when data is fetched',
      build: () {
        when(
          () => dashboardRepository.fetchAnalysis(
            timeframe: any(named: 'timeframe'),
          ),
        ).thenAnswer((_) async => messages);
        return DashboardBloc(dashboardRepository: dashboardRepository);
      },
      act: (DashboardBloc bloc) => bloc.add(const FetchAnalysis()),
      expect: () => <Matcher>[
        equals(const DashboardLoading()),
        isA<DashboardLoaded>().having(
          (DashboardLoaded state) => state.messages,
          'messages',
          messages,
        ),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits a readable error when the network is unavailable',
      build: () {
        when(
          () => dashboardRepository.fetchAnalysis(
            timeframe: any(named: 'timeframe'),
          ),
        ).thenThrow(NetworkException());
        return DashboardBloc(dashboardRepository: dashboardRepository);
      },
      act: (DashboardBloc bloc) => bloc.add(const FetchAnalysis()),
      expect: () => <DashboardState>[
        const DashboardLoading(),
        const DashboardError(AppMessageKeys.dashboardNetwork),
      ],
    );
  });
}
