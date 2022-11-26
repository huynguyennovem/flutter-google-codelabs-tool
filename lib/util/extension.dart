import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}

extension DateTimeFormat on DateTime {
  String get toSimpleDateTime {
    final formatter = DateFormat('MMM d yyyy');
    return formatter.format(this);
  }

  String get toFullDateTime {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(this);
  }
}

extension ListDataExtension<T> on List<T>? {
  bool get notNullOrEmpty => this?.isNotEmpty == true;

  bool get nullOrEmpty => this == null || this?.isEmpty == true;
}
