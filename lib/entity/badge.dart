import 'package:equatable/equatable.dart';

class Badge extends Equatable {
  final String owner;
  final String name;
  final DateTime earnedTime;

  const Badge(this.owner, this.name, this.earnedTime);

  @override
  List<Object> get props => [owner, name, earnedTime];
}