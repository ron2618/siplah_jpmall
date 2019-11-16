import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/product_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'package:siplah_jpmall/src/resources/kabupaten_provider.dart';
import 'package:siplah_jpmall/src/resources/kecamatan_provider.dart';
import 'package:siplah_jpmall/src/resources/products_provider.dart';
import 'package:siplah_jpmall/src/resources/provinsi_provider.dart';

class Repository {
//  final title = '';
  final todoApiProvider = ProductProvider();
  final provinceProvider = ProvinceProvider();
  final kabupatenProvider = KabupatenProvider();
  final kecamatanProvider = KecamatanProvider();

  Future<List<Products>> fetchProducts() => todoApiProvider.fetchProducts();
  Future<Province> fetchProvince() => provinceProvider.province();
  Future<Kabupaten> fetchKabupaten(provId) => kabupatenProvider.kabupaten(provId);
  Future<Kecamatan> fetchKecamatan(kabId) => kecamatanProvider.kecamatan(kabId);
}