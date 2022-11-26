import 'package:equatable/equatable.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/order_type.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sort_type.dart';

class Sorter extends Equatable {
  final SortType sortType;
  final OrderType orderType;

  const Sorter({required this.sortType, required this.orderType});

  const Sorter.init()
      : this(
    sortType: SortType.submittedTime,
    orderType: OrderType.desc,
  );

  const Sorter.def()
      : this(
          sortType: SortType.submittedTime,
          orderType: OrderType.none,
        );

  Sorter copyWith({
    SortType? sortType,
    OrderType? orderType,
  }) {
    return Sorter(
      sortType: sortType ?? this.sortType,
      orderType: orderType ?? this.orderType,
    );
  }

  @override
  List<Object> get props => [sortType, orderType];
}
