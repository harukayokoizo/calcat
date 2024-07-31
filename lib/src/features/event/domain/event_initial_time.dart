import 'package:equatable/equatable.dart';

class EventInitialTime extends Equatable{
  final Map<String, int> initialTime;

  const EventInitialTime(this.initialTime);

  @override
  List<Object> get props => [initialTime];
}