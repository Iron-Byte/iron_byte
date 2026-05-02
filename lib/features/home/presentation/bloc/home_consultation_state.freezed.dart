// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_consultation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeConsultationState {

 String get email; String get message; String? get emailValidationError; bool get isSending; String? get sendError; DateTime? get preferredConsultationSlotUtc; ConsultationAttachment? get attachment; String? get attachmentErrorKey;
/// Create a copy of HomeConsultationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConsultationStateCopyWith<HomeConsultationState> get copyWith => _$HomeConsultationStateCopyWithImpl<HomeConsultationState>(this as HomeConsultationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConsultationState&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.emailValidationError, emailValidationError) || other.emailValidationError == emailValidationError)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.sendError, sendError) || other.sendError == sendError)&&(identical(other.preferredConsultationSlotUtc, preferredConsultationSlotUtc) || other.preferredConsultationSlotUtc == preferredConsultationSlotUtc)&&(identical(other.attachment, attachment) || other.attachment == attachment)&&(identical(other.attachmentErrorKey, attachmentErrorKey) || other.attachmentErrorKey == attachmentErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,email,message,emailValidationError,isSending,sendError,preferredConsultationSlotUtc,attachment,attachmentErrorKey);

@override
String toString() {
  return 'HomeConsultationState(email: $email, message: $message, emailValidationError: $emailValidationError, isSending: $isSending, sendError: $sendError, preferredConsultationSlotUtc: $preferredConsultationSlotUtc, attachment: $attachment, attachmentErrorKey: $attachmentErrorKey)';
}


}

/// @nodoc
abstract mixin class $HomeConsultationStateCopyWith<$Res>  {
  factory $HomeConsultationStateCopyWith(HomeConsultationState value, $Res Function(HomeConsultationState) _then) = _$HomeConsultationStateCopyWithImpl;
@useResult
$Res call({
 String email, String message, String? emailValidationError, bool isSending, String? sendError, DateTime? preferredConsultationSlotUtc, ConsultationAttachment? attachment, String? attachmentErrorKey
});




}
/// @nodoc
class _$HomeConsultationStateCopyWithImpl<$Res>
    implements $HomeConsultationStateCopyWith<$Res> {
  _$HomeConsultationStateCopyWithImpl(this._self, this._then);

  final HomeConsultationState _self;
  final $Res Function(HomeConsultationState) _then;

/// Create a copy of HomeConsultationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? message = null,Object? emailValidationError = freezed,Object? isSending = null,Object? sendError = freezed,Object? preferredConsultationSlotUtc = freezed,Object? attachment = freezed,Object? attachmentErrorKey = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,emailValidationError: freezed == emailValidationError ? _self.emailValidationError : emailValidationError // ignore: cast_nullable_to_non_nullable
as String?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,sendError: freezed == sendError ? _self.sendError : sendError // ignore: cast_nullable_to_non_nullable
as String?,preferredConsultationSlotUtc: freezed == preferredConsultationSlotUtc ? _self.preferredConsultationSlotUtc : preferredConsultationSlotUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,attachment: freezed == attachment ? _self.attachment : attachment // ignore: cast_nullable_to_non_nullable
as ConsultationAttachment?,attachmentErrorKey: freezed == attachmentErrorKey ? _self.attachmentErrorKey : attachmentErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeConsultationState].
extension HomeConsultationStatePatterns on HomeConsultationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeConsultationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeConsultationState value)  $default,){
final _that = this;
switch (_that) {
case _HomeConsultationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeConsultationState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String message,  String? emailValidationError,  bool isSending,  String? sendError,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
return $default(_that.email,_that.message,_that.emailValidationError,_that.isSending,_that.sendError,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String message,  String? emailValidationError,  bool isSending,  String? sendError,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)  $default,) {final _that = this;
switch (_that) {
case _HomeConsultationState():
return $default(_that.email,_that.message,_that.emailValidationError,_that.isSending,_that.sendError,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String message,  String? emailValidationError,  bool isSending,  String? sendError,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)?  $default,) {final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
return $default(_that.email,_that.message,_that.emailValidationError,_that.isSending,_that.sendError,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
  return null;

}
}

}

/// @nodoc


class _HomeConsultationState implements HomeConsultationState {
  const _HomeConsultationState({this.email = '', this.message = '', this.emailValidationError, this.isSending = false, this.sendError, this.preferredConsultationSlotUtc, this.attachment, this.attachmentErrorKey});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String message;
@override final  String? emailValidationError;
@override@JsonKey() final  bool isSending;
@override final  String? sendError;
@override final  DateTime? preferredConsultationSlotUtc;
@override final  ConsultationAttachment? attachment;
@override final  String? attachmentErrorKey;

/// Create a copy of HomeConsultationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeConsultationStateCopyWith<_HomeConsultationState> get copyWith => __$HomeConsultationStateCopyWithImpl<_HomeConsultationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConsultationState&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.emailValidationError, emailValidationError) || other.emailValidationError == emailValidationError)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.sendError, sendError) || other.sendError == sendError)&&(identical(other.preferredConsultationSlotUtc, preferredConsultationSlotUtc) || other.preferredConsultationSlotUtc == preferredConsultationSlotUtc)&&(identical(other.attachment, attachment) || other.attachment == attachment)&&(identical(other.attachmentErrorKey, attachmentErrorKey) || other.attachmentErrorKey == attachmentErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,email,message,emailValidationError,isSending,sendError,preferredConsultationSlotUtc,attachment,attachmentErrorKey);

@override
String toString() {
  return 'HomeConsultationState(email: $email, message: $message, emailValidationError: $emailValidationError, isSending: $isSending, sendError: $sendError, preferredConsultationSlotUtc: $preferredConsultationSlotUtc, attachment: $attachment, attachmentErrorKey: $attachmentErrorKey)';
}


}

/// @nodoc
abstract mixin class _$HomeConsultationStateCopyWith<$Res> implements $HomeConsultationStateCopyWith<$Res> {
  factory _$HomeConsultationStateCopyWith(_HomeConsultationState value, $Res Function(_HomeConsultationState) _then) = __$HomeConsultationStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String message, String? emailValidationError, bool isSending, String? sendError, DateTime? preferredConsultationSlotUtc, ConsultationAttachment? attachment, String? attachmentErrorKey
});




}
/// @nodoc
class __$HomeConsultationStateCopyWithImpl<$Res>
    implements _$HomeConsultationStateCopyWith<$Res> {
  __$HomeConsultationStateCopyWithImpl(this._self, this._then);

  final _HomeConsultationState _self;
  final $Res Function(_HomeConsultationState) _then;

/// Create a copy of HomeConsultationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? message = null,Object? emailValidationError = freezed,Object? isSending = null,Object? sendError = freezed,Object? preferredConsultationSlotUtc = freezed,Object? attachment = freezed,Object? attachmentErrorKey = freezed,}) {
  return _then(_HomeConsultationState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,emailValidationError: freezed == emailValidationError ? _self.emailValidationError : emailValidationError // ignore: cast_nullable_to_non_nullable
as String?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,sendError: freezed == sendError ? _self.sendError : sendError // ignore: cast_nullable_to_non_nullable
as String?,preferredConsultationSlotUtc: freezed == preferredConsultationSlotUtc ? _self.preferredConsultationSlotUtc : preferredConsultationSlotUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,attachment: freezed == attachment ? _self.attachment : attachment // ignore: cast_nullable_to_non_nullable
as ConsultationAttachment?,attachmentErrorKey: freezed == attachmentErrorKey ? _self.attachmentErrorKey : attachmentErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
