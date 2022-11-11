import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}

extension DateTimeFormat on DateTime {
  get toSimpleDateTime {
    final formatter = DateFormat('MMM d yyyy');
    return formatter.format(this);
  }
}