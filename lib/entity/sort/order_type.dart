enum OrderType { desc, asc, none }

extension OrderTypeExtensiton on OrderType {
  get switchOrderType {
    if (this == OrderType.none) {
      return OrderType.desc;
    }
    return this == OrderType.desc ? OrderType.asc : OrderType.desc;
  }
}
