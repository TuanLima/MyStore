import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
      id: 1,
      title: "Caixa Experiências",
      description:
          "Bombons cobertos com chocolate branco, chocolate 35% cacau, 51% cacau, 60% cacau, e 70% cacau.",
      price: 63.00,
      category: ["Presentes"],
      weight: 240.0,
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/site_product_detail/uploads/images/chocolates_brasil_cacau_5fd14e832e31e1.03866395.png",
      path: "assets/store_item_imgs/bem_me_faz.png"),
  FoodItem(
      id: 2,
      title: "Caixa Momentos",
      description:
          "Bombom de chocolate branco com flocos de arroz, bombom de chocolate ao leite com crocante de castanha-de-caju, bombom com recheio sabor licor de marula coberto com chocolate ao leite e bombom com recheio sabor chocolate branco, coberto com chocolates ao leite e branco. Contém glúten.",
      price: 40.00,
      category: ["Presentes"],
      weight: 162.0,
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/resolve/site_product_detail/uploads/images/chocolates_brasil_cacau_5fce53a1845ee7.94235992.png",
      path: ""),
  FoodItem(
      id: 3,
      title: "Mini Divino Amendoim",
      description: "Bombom com recheio cremoso de amendoim.",
      price: 1.90,
      category: ["Pegue e leve"],
      weight: 12.5,
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/site_product_detail/uploads/images/chocolates_brasil_cacau_5fd1503e9df039.24950303.png",
      path: ""),
  FoodItem(
      id: 4,
      title: "Minitablete ao leite",
      description: "Minitablete de chocolate ao leite.",
      weight: 10.0,
      price: 1.90,
      category: ["Pegue e leve"],
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/site_product_detail/uploads/images/chocolates_brasil_cacau_5fce5825304a60.73174687.png",
      path: ""),
  FoodItem(
      id: 5,
      title: "Caixa Bem Me Faz",
      description:
          "Bombons de chocolate ao leite para dietas com restrição de lactose.",
      weight: 100.0,
      price: 37.90,
      category: ["Diet"],
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/site_product_detail/uploads/images/chocolates_brasil_cacau_5fdd550ca357b1.97802872.png",
      path: ""),
  FoodItem(
      id: 6,
      title: "Bombons Clássicos",
      description:
          "Bombons sortidos de chocolate ao leite, branco, amargo e ao leite com crocante de castanha-de-caju.",
      price: 41.50,
      category: ["Presentes"],
      weight: 250.0,
      imgUrl:
          "https://www.chocolatesbrasilcacau.com.br/media/cache/site_product_detail/uploads/images/chocolates_brasil_cacau_5fd12449effc31.94748015.png",
      path: ""),
]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

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

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
