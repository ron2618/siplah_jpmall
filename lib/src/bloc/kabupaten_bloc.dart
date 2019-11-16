import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class KabupatenBloc{
  final _repository = Repository();
  final _kabupatenFetcher = PublishSubject<Kabupaten>();

  Observable<Kabupaten> get allKabupaten => _kabupatenFetcher.stream;

  fetchKabupaten(provId) async {
    Kabupaten kabupaten = await _repository.fetchKabupaten(provId);
    _kabupatenFetcher.sink.add(kabupaten);
  }

  dispose() async{
    _kabupatenFetcher.close();
  }
}
final kabupatenBloc = KabupatenBloc();