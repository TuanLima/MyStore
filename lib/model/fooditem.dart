import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'fooditem.g.dart';

@JsonSerializable()
class FoodItemList {
  List<FoodItem> foodItems;

  FoodItemList({@required this.foodItems});

  factory FoodItemList.fromJson(Map<String, dynamic> json) =>
      _$FoodItemListFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemListToJson(this);
}

FoodItemList fooditemList = FoodItemList(foodItems: [
  FoodItem(
      id: 1,
      title: "Caixa Experiências",
      description:
          "Bombons cobertos com chocolate branco, chocolate 35% cacau, 51% cacau, 60% cacau, e 70% cacau.",
      price: 63.00,
      category: ["Presentes"],
      weight: 240.0,
      imgUrl: "https://cdn.awsli.com.br",
      path: "/600x450/1310/1310814/produto/53063554/a1c4cc5b60.jpg"),
  FoodItem(
      id: 2,
      title: "Caixa Momentos",
      description:
          "Bombom de chocolate branco com flocos de arroz, bombom de chocolate ao leite com crocante de castanha-de-caju, bombom com recheio sabor licor de marula coberto com chocolate ao leite e bombom com recheio sabor chocolate branco, coberto com chocolates ao leite e branco. Contém glúten.",
      price: 40.00,
      category: ["Presentes"],
      weight: 162.0,
      imgUrl: "https://d26lpennugtm8s.cloudfront.net",
      path:
          "/stores/001/378/663/products/caixa-momentos-162g1-fea8df34136858cbb316027893801667-640-0.png"),
  FoodItem(
      id: 3,
      title: "Mini Divino Amendoim",
      description: "Bombom com recheio cremoso de amendoim.",
      price: 1.90,
      category: ["Pegue e leve"],
      weight: 12.5,
      imgUrl: "https://s.cornershopapp.com",
      path: "/product-images/1955683.png"),
  FoodItem(
      id: 4,
      title: "Minitablete ao leite",
      description: "Minitablete de chocolate ao leite.",
      weight: 10.0,
      price: 1.90,
      category: ["Pegue e leve"],
      imgUrl: "data:image/jpeg;base64,",
      path:
          "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"),
  FoodItem(
      id: 5,
      title: "Caixa Bem Me Faz",
      description:
          "Bombons de chocolate ao leite para dietas com restrição de lactose.",
      weight: 100.0,
      price: 37.90,
      category: ["Diet"],
      imgUrl: "https://brasilcacau.vteximg.com.br",
      path: "/arquivos/ids/155679-500-500/1202022401_1.png"),
  FoodItem(
      id: 6,
      title: "Bombons Clássicos",
      description:
          "Bombons sortidos de chocolate ao leite, branco, amargo e ao leite com crocante de castanha-de-caju.",
      price: 41.50,
      category: ["Presentes"],
      weight: 250.0,
      imgUrl: "https://i.pinimg.com",
      path: "/originals/84/c6/02/84c602a22cb52786c717eb5181e905e7.png"),
]);

@JsonSerializable()
class FoodItem {
  int id;
  String title;
  String description;
  double weight;
  double price;
  String imgUrl;
  int quantity;
  List<String> category;
  String path;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.category,
    this.weight,
    this.imgUrl,
    this.path,
    this.quantity = 1,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
