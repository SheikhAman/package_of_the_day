import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String role;

  const User({required this.name, required this.role});

  @override
  List<Object> get props => [name, role];
}
