import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/main.dart';

part 'main_model.freezed.dart';
part 'main_model.g.dart';

@freezed
class MainModel with _$MainModel {
  const factory MainModel({
    required String id,
  }) = _MainModel;

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);
      
        @override
        // TODO: implement id
        String get id => throw UnimplementedError();
      
        @override
        Map<String, dynamic> toJson() {
          // TODO: implement toJson
          throw UnimplementedError();
        }
}

extension MainMapper on MainModel {
  Main toEntity() {
    return Main(id: id);
  }
}
