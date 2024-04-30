import 'dart:convert';

import 'package:equatable/equatable.dart';

class CurrenciesModel extends Equatable {
  final String title;
  final String code;
  final String cbPrice;
  final String buyPrice;
  final String sellPrice;
  final String date;

  const CurrenciesModel({
    required this.title,
    required this.code,
    required this.cbPrice,
    required this.buyPrice,
    required this.sellPrice,
    required this.date,
  });

  factory CurrenciesModel.fromJson(Map<String, dynamic> json) {
    return CurrenciesModel(
      title: json['title'] as String? ?? "",
      code: json['code'] as String? ?? "",
      cbPrice: json['cb_price'] as String? ?? "",
      buyPrice: json['nbu_buy_price'] as String? ?? "",
      sellPrice: json['nbu_cell_price'] as String? ?? "",
      date: json['date'] as String? ?? "",
    );
  }

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'code': code,
      'cb_price': cbPrice,
      'nbu_buy_price': buyPrice,
      'nbu_cell_price': sellPrice,
      'date': date,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        code,
        cbPrice,
        buyPrice,
        sellPrice,
        date,
      ];
}
