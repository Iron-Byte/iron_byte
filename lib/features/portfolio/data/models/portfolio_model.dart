import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/portfolio.dart';

part 'portfolio_model.freezed.dart';
part 'portfolio_model.g.dart';

@freezed
class PortfolioModel with _$PortfolioModel {
  const factory PortfolioModel({
    required String id,
  }) = _PortfolioModel;

  factory PortfolioModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioModelFromJson(json);
      
        @override
        // TODO: implement id
        String get id => throw UnimplementedError();
      
        @override
        Map<String, dynamic> toJson() {
          // TODO: implement toJson
          throw UnimplementedError();
        }
}

extension PortfolioMapper on PortfolioModel {
  Portfolio toEntity() {
    return Portfolio(id: id);
  }
}
