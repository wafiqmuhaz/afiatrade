import 'package:equatable/equatable.dart';

import '../../models/analysis_response.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => <Object?>[];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.messages);

  final List<Message> messages;

  @override
  List<Object?> get props => <Object?>[messages];
}

class DashboardError extends DashboardState {
  const DashboardError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
