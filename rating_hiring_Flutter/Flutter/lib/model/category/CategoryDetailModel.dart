import 'package:rentors/model/home/HomeBean.dart';
import 'package:rentors/model/home/HomeModel.dart';

class CategoryDetailModel {
  CategoryDetailModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.subCategory,
    this.products,
    this.sliderImage,
  });

  List<SubCategory> subCategory;
  List<Product> products;
  List<SliderImage> sliderImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        sliderImage: List<SliderImage>.from(
            json["slider_image"].map((x) => SliderImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "slider_image": List<dynamic>.from(sliderImage.map((x) => x.toJson())),
      };
}

class Product extends HomeBean {
  Product({
    this.subCategoryName,
    this.subcategoryProducts,
  });

  String subCategoryName;
  List<FeaturedProductElement> subcategoryProducts;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        subCategoryName: json["sub_category_name"],
        subcategoryProducts: List<FeaturedProductElement>.from(
            json["subcategory_products"]
                .map((x) => FeaturedProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_category_name": subCategoryName,
        "subcategory_products":
            List<dynamic>.from(subcategoryProducts.map((x) => x.toJson())),
      };
}

class SliderImage {
  SliderImage({
    this.image,
  });

  String image;

  factory SliderImage.fromJson(Map<String, dynamic> json) => SliderImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class SubCategory {
  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.sliderImage,
    this.subcategoryIcon,
    this.formField,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String categoryId;
  String name;
  List<SliderImage> sliderImage;
  String subcategoryIcon;
  List<DynamicField> formField;
  String createdAt;
  String updatedAt;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        sliderImage: json["slider_image"] == null
            ? null
            : List<SliderImage>.from(
                json["slider_image"].map((x) => SliderImage.fromJson(x))),
        subcategoryIcon: json["subcategory_icon"],
        formField: List<DynamicField>.from(
            json["form_field"].map((x) => DynamicField.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "slider_image": sliderImage == null
            ? null
            : List<dynamic>.from(sliderImage.map((x) => x.toJson())),
        "subcategory_icon": subcategoryIcon,
        "form_field": List<dynamic>.from(formField.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class DynamicField {
  DynamicField({
    this.lable,
  });

  String lable;

  factory DynamicField.fromJson(Map<String, dynamic> json) => DynamicField(
        lable: json["lable"],
      );

  Map<String, dynamic> toJson() => {
        "lable": lable,
      };
}
