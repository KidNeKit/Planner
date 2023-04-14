import 'package:flutter/cupertino.dart';

enum EventStatus {
  pending(Color(0xFFEB5757), 'PENDING'),
  inProgress(Color(0xFFA880E3), 'IN PROGRESS'),
  completed(Color(0xFF27AE60), 'COMPLETED');

  final Color color;
  final String status;

  const EventStatus(this.color, this.status);
}
