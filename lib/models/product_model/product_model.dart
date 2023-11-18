import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isRecommended;
  @HiveField(6)
  final bool isPopular;
  @HiveField(7)
  final String? description;
  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.isRecommended,
      required this.isPopular,
      this.description});

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        id: snap.id,
        name: snap['name'],
        category: snap['category'],
        imageUrl: snap['imageUrl'],
        price: snap['price'],
        isRecommended: snap['isRecommended'],
        isPopular: snap['isPopular'],
        description: snap["description"]);
    return product;
  }

  static Product fromJson(Map<String, dynamic> json, [String? id]) {
    Product product = Product(
      id: id ?? json['id'],
      name: json['name'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      isRecommended: json['isRecommended'],
      isPopular: json['isPopular'],
      description: json['description'],
    );
    return product;
  }

  @override
  List<Object?> get props => [
        name,
        id,
        category,
        imageUrl,
        price,
        isRecommended,
        description,
        isPopular,
      ];

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'description': description,
    };
  }

  static List<Product> products = [
    const Product(
        id: "1",
        name: 'Soft Drink #1',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
        //https://unsplash.com/photos/dO9A6mhSZZY
        ,
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        description: ""),
    const Product(
        id: "2",
        name: 'Soft Drink #2',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
        //https://unsplash.com/photos/Viy_8zHEznk
        price: 2.99,
        isRecommended: false,
        isPopular: true,
        description: ""),
    const Product(
        id: "3",
        name: 'Soft Drink #3',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        description: ""),
    const Product(
        id: "14",
        name: 'Smoothies #1',
        category: 'Smoothies',
        imageUrl:
            'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/kcYXj4tBtes
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        description: ""),
    const Product(
        id: "16",
        name: 'Smoothies #2',
        category: 'Smoothies',
        imageUrl:
            'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80',
        price: 2.99,
        isRecommended: false,
        isPopular: false,
        description: ""),
    const Product(
        id: "17",
        name: 'Soft Drink #1',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        description: ""),
    const Product(
      id: "21",

      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false, description: "",
      isPopular: true,
    ),
    const Product(
      id: "234231",
      description: "",
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
      price: 2.99,
      isRecommended: true,
      isPopular: true,
    ),
  ];
}
