import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_message_keys.dart';
import '../../models/app_exceptions.dart';
import '../../repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

export 'dashboard_event.dart';
export 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.dashboardRepository})
    : super(const DashboardInitial()) {
    on<FetchAnalysis>(_onFetchAnalysis);
  }

  final DashboardRepository dashboardRepository;

  Future<void> _onFetchAnalysis(
    FetchAnalysis event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());

    try {
      final messages = await dashboardRepository.fetchAnalysis(
        timeframe: event.timeframe,
      );
      emit(DashboardLoaded(messages));
    } on NetworkException {
      emit(const DashboardError(AppMessageKeys.dashboardNetwork));
    } on ApiException {
      emit(const DashboardError(AppMessageKeys.dashboardApi));
    } on ParsingException {
      emit(const DashboardError(AppMessageKeys.dashboardParsing));
    } catch (_) {
      emit(const DashboardError(AppMessageKeys.dashboardGeneric));
    }
  }
}
