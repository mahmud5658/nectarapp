import '../infrastructure.dart';

abstract class IProductDatabase {
  const IProductDatabase();

  Future<ProductState> getProducts(ProductParam param);
  Future<ProductModel> addOnSaved(ProductModel model);
  Future<ProductModel> removeFromSaved(ProductModel model);

  Future<ProductModel> addToCart(ProductModel model);
}
