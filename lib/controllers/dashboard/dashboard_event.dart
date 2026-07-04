import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class FetchAnalysis extends DashboardEvent {
  const FetchAnalysis({this.timeframe = 'H1'});

  final String timeframe;

  @override
  List<Object?> get props => <Object?>[timeframe];
}
