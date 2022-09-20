class HomeModel {
  bool? status;

  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersData> banners = [];
  List<ProductModel> products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannersData {
  int? id;

  String? image;

  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;

  String? image;

  String? name;

  late bool infavorites;

  late bool Incart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    Incart = json['in_cart'];
  }
}