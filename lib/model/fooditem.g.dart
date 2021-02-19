// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fooditem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItemList _$FoodItemListFromJson(Map<String, dynamic> json) {
  return FoodItemList(
    foodItems: (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : FoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FoodItemListToJson(FoodItemList instance) =>
    <String, dynamic>{
      'foodItems': instance.foodItems,
    };

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return FoodItem(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num)?.toDouble(),
    category: (json['category'] as List)?.map((e) => e as String)?.toList(),
    weight: (json['weight'] as num)?.toDouble(),
    imgUrl: json['imgUrl'] as String,
    path: json['path'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'weight': instance.weight,
      'price': instance.price,
      'imgUrl': instance.imgUrl,
      'quantity': instance.quantity,
      'category': instance.category,
      'path': instance.path,
    };
