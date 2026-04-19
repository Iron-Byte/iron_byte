// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioModel {

 String get id;
/// Create a copy of PortfolioModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioModelCopyWith<PortfolioModel> get copyWith => _$PortfolioModelCopyWithImpl<PortfolioModel>(this as PortfolioModel, _$identity);

  /// Serializes this PortfolioModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioModel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PortfolioModel(id: $id)';
}


}

/// @nodoc
abstract mixin class $PortfolioModelCopyWith<$Res>  {
  factory $PortfolioModelCopyWith(PortfolioModel value, $Res Function(PortfolioModel) _then) = _$PortfolioModelCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$PortfolioModelCopyWithImpl<$Res>
    implements $PortfolioModelCopyWith<$Res> {
  _$PortfolioModelCopyWithImpl(this._self, this._then);

  final PortfolioModel _self;
  final $Res Function(PortfolioModel) _then;

/// Create a copy of PortfolioModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioModel].
extension PortfolioModelPatterns on PortfolioModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioModel value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioModel value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioModel() when $default != null:
return $default(_that.id);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _PortfolioModel():
return $default(_that.id);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioModel() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioModel implements PortfolioModel {
  const _PortfolioModel({required this.id});
  factory _PortfolioModel.fromJson(Map<String, dynamic> json) => _$PortfolioModelFromJson(json);

@override final  String id;

/// Create a copy of PortfolioModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioModelCopyWith<_PortfolioModel> get copyWith => __$PortfolioModelCopyWithImpl<_PortfolioModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioModel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PortfolioModel(id: $id)';
}


}

/// @nodoc
abstract mixin class _$PortfolioModelCopyWith<$Res> implements $PortfolioModelCopyWith<$Res> {
  factory _$PortfolioModelCopyWith(_PortfolioModel value, $Res Function(_PortfolioModel) _then) = __$PortfolioModelCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$PortfolioModelCopyWithImpl<$Res>
    implements _$PortfolioModelCopyWith<$Res> {
  __$PortfolioModelCopyWithImpl(this._self, this._then);

  final _PortfolioModel _self;
  final $Res Function(_PortfolioModel) _then;

/// Create a copy of PortfolioModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_PortfolioModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
