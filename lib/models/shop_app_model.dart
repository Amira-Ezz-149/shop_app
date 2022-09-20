class HomeModel {
  bool? status;

  HomeData? data;

  HomeModel.fromjsom(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromjsom(json['data']);
  }
}

class HomeData {
  List<BannersData> banners = [];
  List<ProductModel> products = [];

  HomeData.fromjsom(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromjsom(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromjsom(element));
    });
  }
}

class BannersData {
  int? id;

  String? image;

  BannersData.fromjsom(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;

  dynamic price;

  dynamic old_price;

  dynamic discount;

  String? image;

  String? name;

  late bool infavorites;

  late bool Incart;

  ProductModel.fromjsom(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    Incart = json['in_cart'];
  }
}