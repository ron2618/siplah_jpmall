
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class KecamatanBloc{
  final _repository = Repository();
  final _kecamatanFetcher = PublishSubject<Kecamatan>();

  Observable<Kecamatan> get allKecamatan => _kecamatanFetcher.stream;

  fetchKecamatan(kabId) async {
    Kecamatan kecamatan = await _repository.fetchKecamatan(kabId);
    _kecamatanFetcher.sink.add(kecamatan);
  }

  dispose() async{
    _kecamatanFetcher.close();
  }
}
final kecamatanBloc = KecamatanBloc();