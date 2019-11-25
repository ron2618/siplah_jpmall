import 'package:siplah_jpmall/src/models/Blog.dart';
import 'package:siplah_jpmall/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class BlogBloc{
  final _blogFetcher = PublishSubject<List<Blog>>();
  final _repository = Repository();

  Observable<List<Blog>> get allBlog => _blogFetcher.stream;

  fetchAll() async {
    List<Blog> blog = await _repository.fetchBlog();
    _blogFetcher.sink.add(blog);
  }

  dispose() async {
    _blogFetcher.close();
  }
}

final blogBloc = BlogBloc();