// ignore_for_file: public_member_api_docs, sort_constructors_first
class FilterModel {
  String? carBrand;
  String? carYOM;
  String? carModel;
  String? carStartPrice;
  String? carEndPrice;
  List<String>? carCategories;

  FilterModel({
    this.carBrand,
    this.carYOM,
    this.carModel,
    this.carStartPrice,
    this.carEndPrice,
    this.carCategories,
  });
  @override
  String toString() {
    return "Brand: $carBrand, YOM: $carYOM, Model: $carModel, startPrice: $carStartPrice, endPrice: $carEndPrice, categories: $carCategories";
  }
}
