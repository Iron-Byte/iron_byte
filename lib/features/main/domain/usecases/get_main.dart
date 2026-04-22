import '../repositories/main_repository.dart';

class GetMain {
  final MainRepository repository;

  GetMain(this.repository);

  Future<void> call() async {
    return repository.getMain();
  }
}
