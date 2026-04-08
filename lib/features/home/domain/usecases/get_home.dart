import '../repositories/home_repository.dart';

class GetHome {
  final HomeRepository repository;

  GetHome(this.repository);

  Future<void> call() async {
    return repository.getHome();
  }
}
