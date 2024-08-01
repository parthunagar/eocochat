import 'package:rentors/model/home/HomeBean.dart';
import 'package:rentors/model/home/HomeModel.dart';

class Home {
  List<HomeSliderImage> homeSliderImage;
  List<dynamic> category;
  List<FeaturedProductElement> featuredProducts;
  List<HomeBean> products;
  List<FeaturedProductElement> near_by_search;
  List<dynamic> sliderImage;

  Home(this.homeSliderImage, this.category, this.featuredProducts, this.products, this.sliderImage,this.near_by_search);
}
