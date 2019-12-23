import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'package:siplah_jpmall/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProvinceBloc{
  final _repository = Repository();
  final _provinceFetcher = PublishSubject<Province>();

  Observable<Province> get allProvince => _provinceFetcher.stream;

  provinceFetchAll() async {
    Province province = await _repository.fetchProvince();
    _provinceFetcher.sink.add(province);
  }

  dispose()async {
    _provinceFetcher.close();
  }
}
final provinceBloc = ProvinceBloc();