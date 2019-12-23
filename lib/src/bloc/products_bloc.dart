
import 'package:siplah_jpmall/src/models/product_model.dart';
import 'package:siplah_jpmall/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class ProductBloc{
  final _productFetcher = PublishSubject<List<Products>>();
  final _repository = Repository();

  Observable<List<Products>> get allProducts => _productFetcher.stream;

  fetchAll() async {
    List<Products> products = await _repository.fetchProducts();
    _productFetcher.sink.add(products);
  }

  dispose() async {
    _productFetcher.close();
  }
}

final productBloc = ProductBloc();