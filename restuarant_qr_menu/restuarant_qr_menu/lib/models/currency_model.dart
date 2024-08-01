class CurrencyModel {
  String? symbol;
  String? name;

  CurrencyModel({this.symbol, this.name});

  static List<CurrencyModel> getCurrencyList() {
    List<CurrencyModel> data = [];
    data.add(CurrencyModel(symbol: "₹", name: "Indian Rupee"));
    data.add(CurrencyModel(symbol: "\$", name: "Us Dollar"));
    data.add(CurrencyModel(symbol: "€", name: "Euro"));
    data.add(CurrencyModel(symbol: "£", name: "British Pound"));

    return data;
  }
}
