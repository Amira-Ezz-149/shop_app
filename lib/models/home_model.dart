//
//
// class HomeModel {
//    bool? status;
//    ProductModel? data;
//
//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = (json['data'] != null ?  ProductModel.fromJson(json['data']) : null)!;
//   }
// }
//
// class HomeDataModel {
//
//   List<BannerModel>? banners;
//   List<ProductModel>? products;
//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element){
//       banners!.add(element);
//     });
//     json['products'].forEach((element){
//       products!.add(element);
//     });
//   }
// }
//
//
//
// class BannerModel{
//   int? id;
//   String? image;
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
//
// }
//
//
//
//
//
// class ProductModel {
//    int? id;
//    dynamic price;
//    dynamic oldPrice;
//    int? discount;
//    String? image;
//    String? name;
//    String? description;
//    bool? inFavorites;
//    bool? inCart;
//   List<String> images = [];
//
//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//     images = json['images'].cast<String>();
//   }
// }