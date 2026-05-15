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

 String get name; String get email; String get message; String? get nameValidationError; String? get emailValidationError;/// `null` while the initial health check is in progress.
 bool? get isServerOnline; bool get isLoadingBookedSlots; String? get bookedSlotsErrorKey; List<DateTime> get bookedSlotsUtc; ConsultationBookingStatus get bookingStatus; String? get bookingErrorMessage; DateTime? get preferredConsultationSlotUtc; ConsultationAttachment? get attachment; String? get attachmentErrorKey;
/// Create a copy of HomeConsultationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConsultationStateCopyWith<HomeConsultationState> get copyWith => _$HomeConsultationStateCopyWithImpl<HomeConsultationState>(this as HomeConsultationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConsultationState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.nameValidationError, nameValidationError) || other.nameValidationError == nameValidationError)&&(identical(other.emailValidationError, emailValidationError) || other.emailValidationError == emailValidationError)&&(identical(other.isServerOnline, isServerOnline) || other.isServerOnline == isServerOnline)&&(identical(other.isLoadingBookedSlots, isLoadingBookedSlots) || other.isLoadingBookedSlots == isLoadingBookedSlots)&&(identical(other.bookedSlotsErrorKey, bookedSlotsErrorKey) || other.bookedSlotsErrorKey == bookedSlotsErrorKey)&&const DeepCollectionEquality().equals(other.bookedSlotsUtc, bookedSlotsUtc)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookingErrorMessage, bookingErrorMessage) || other.bookingErrorMessage == bookingErrorMessage)&&(identical(other.preferredConsultationSlotUtc, preferredConsultationSlotUtc) || other.preferredConsultationSlotUtc == preferredConsultationSlotUtc)&&(identical(other.attachment, attachment) || other.attachment == attachment)&&(identical(other.attachmentErrorKey, attachmentErrorKey) || other.attachmentErrorKey == attachmentErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,message,nameValidationError,emailValidationError,isServerOnline,isLoadingBookedSlots,bookedSlotsErrorKey,const DeepCollectionEquality().hash(bookedSlotsUtc),bookingStatus,bookingErrorMessage,preferredConsultationSlotUtc,attachment,attachmentErrorKey);

@override
String toString() {
  return 'HomeConsultationState(name: $name, email: $email, message: $message, nameValidationError: $nameValidationError, emailValidationError: $emailValidationError, isServerOnline: $isServerOnline, isLoadingBookedSlots: $isLoadingBookedSlots, bookedSlotsErrorKey: $bookedSlotsErrorKey, bookedSlotsUtc: $bookedSlotsUtc, bookingStatus: $bookingStatus, bookingErrorMessage: $bookingErrorMessage, preferredConsultationSlotUtc: $preferredConsultationSlotUtc, attachment: $attachment, attachmentErrorKey: $attachmentErrorKey)';
}


}

/// @nodoc
abstract mixin class $HomeConsultationStateCopyWith<$Res>  {
  factory $HomeConsultationStateCopyWith(HomeConsultationState value, $Res Function(HomeConsultationState) _then) = _$HomeConsultationStateCopyWithImpl;
@useResult
$Res call({
 String name, String email, String message, String? nameValidationError, String? emailValidationError, bool? isServerOnline, bool isLoadingBookedSlots, String? bookedSlotsErrorKey, List<DateTime> bookedSlotsUtc, ConsultationBookingStatus bookingStatus, String? bookingErrorMessage, DateTime? preferredConsultationSlotUtc, ConsultationAttachment? attachment, String? attachmentErrorKey
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
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? message = null,Object? nameValidationError = freezed,Object? emailValidationError = freezed,Object? isServerOnline = freezed,Object? isLoadingBookedSlots = null,Object? bookedSlotsErrorKey = freezed,Object? bookedSlotsUtc = null,Object? bookingStatus = null,Object? bookingErrorMessage = freezed,Object? preferredConsultationSlotUtc = freezed,Object? attachment = freezed,Object? attachmentErrorKey = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,nameValidationError: freezed == nameValidationError ? _self.nameValidationError : nameValidationError // ignore: cast_nullable_to_non_nullable
as String?,emailValidationError: freezed == emailValidationError ? _self.emailValidationError : emailValidationError // ignore: cast_nullable_to_non_nullable
as String?,isServerOnline: freezed == isServerOnline ? _self.isServerOnline : isServerOnline // ignore: cast_nullable_to_non_nullable
as bool?,isLoadingBookedSlots: null == isLoadingBookedSlots ? _self.isLoadingBookedSlots : isLoadingBookedSlots // ignore: cast_nullable_to_non_nullable
as bool,bookedSlotsErrorKey: freezed == bookedSlotsErrorKey ? _self.bookedSlotsErrorKey : bookedSlotsErrorKey // ignore: cast_nullable_to_non_nullable
as String?,bookedSlotsUtc: null == bookedSlotsUtc ? _self.bookedSlotsUtc : bookedSlotsUtc // ignore: cast_nullable_to_non_nullable
as List<DateTime>,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as ConsultationBookingStatus,bookingErrorMessage: freezed == bookingErrorMessage ? _self.bookingErrorMessage : bookingErrorMessage // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String message,  String? nameValidationError,  String? emailValidationError,  bool? isServerOnline,  bool isLoadingBookedSlots,  String? bookedSlotsErrorKey,  List<DateTime> bookedSlotsUtc,  ConsultationBookingStatus bookingStatus,  String? bookingErrorMessage,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
return $default(_that.name,_that.email,_that.message,_that.nameValidationError,_that.emailValidationError,_that.isServerOnline,_that.isLoadingBookedSlots,_that.bookedSlotsErrorKey,_that.bookedSlotsUtc,_that.bookingStatus,_that.bookingErrorMessage,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String message,  String? nameValidationError,  String? emailValidationError,  bool? isServerOnline,  bool isLoadingBookedSlots,  String? bookedSlotsErrorKey,  List<DateTime> bookedSlotsUtc,  ConsultationBookingStatus bookingStatus,  String? bookingErrorMessage,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)  $default,) {final _that = this;
switch (_that) {
case _HomeConsultationState():
return $default(_that.name,_that.email,_that.message,_that.nameValidationError,_that.emailValidationError,_that.isServerOnline,_that.isLoadingBookedSlots,_that.bookedSlotsErrorKey,_that.bookedSlotsUtc,_that.bookingStatus,_that.bookingErrorMessage,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String message,  String? nameValidationError,  String? emailValidationError,  bool? isServerOnline,  bool isLoadingBookedSlots,  String? bookedSlotsErrorKey,  List<DateTime> bookedSlotsUtc,  ConsultationBookingStatus bookingStatus,  String? bookingErrorMessage,  DateTime? preferredConsultationSlotUtc,  ConsultationAttachment? attachment,  String? attachmentErrorKey)?  $default,) {final _that = this;
switch (_that) {
case _HomeConsultationState() when $default != null:
return $default(_that.name,_that.email,_that.message,_that.nameValidationError,_that.emailValidationError,_that.isServerOnline,_that.isLoadingBookedSlots,_that.bookedSlotsErrorKey,_that.bookedSlotsUtc,_that.bookingStatus,_that.bookingErrorMessage,_that.preferredConsultationSlotUtc,_that.attachment,_that.attachmentErrorKey);case _:
  return null;

}
}

}

/// @nodoc


class _HomeConsultationState implements HomeConsultationState {
  const _HomeConsultationState({this.name = '', this.email = '', this.message = '', this.nameValidationError, this.emailValidationError, this.isServerOnline, this.isLoadingBookedSlots = false, this.bookedSlotsErrorKey, final  List<DateTime> bookedSlotsUtc = const <DateTime>[], this.bookingStatus = ConsultationBookingStatus.idle, this.bookingErrorMessage, this.preferredConsultationSlotUtc, this.attachment, this.attachmentErrorKey}): _bookedSlotsUtc = bookedSlotsUtc;
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String email;
@override@JsonKey() final  String message;
@override final  String? nameValidationError;
@override final  String? emailValidationError;
/// `null` while the initial health check is in progress.
@override final  bool? isServerOnline;
@override@JsonKey() final  bool isLoadingBookedSlots;
@override final  String? bookedSlotsErrorKey;
 final  List<DateTime> _bookedSlotsUtc;
@override@JsonKey() List<DateTime> get bookedSlotsUtc {
  if (_bookedSlotsUtc is EqualUnmodifiableListView) return _bookedSlotsUtc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedSlotsUtc);
}

@override@JsonKey() final  ConsultationBookingStatus bookingStatus;
@override final  String? bookingErrorMessage;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConsultationState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.nameValidationError, nameValidationError) || other.nameValidationError == nameValidationError)&&(identical(other.emailValidationError, emailValidationError) || other.emailValidationError == emailValidationError)&&(identical(other.isServerOnline, isServerOnline) || other.isServerOnline == isServerOnline)&&(identical(other.isLoadingBookedSlots, isLoadingBookedSlots) || other.isLoadingBookedSlots == isLoadingBookedSlots)&&(identical(other.bookedSlotsErrorKey, bookedSlotsErrorKey) || other.bookedSlotsErrorKey == bookedSlotsErrorKey)&&const DeepCollectionEquality().equals(other._bookedSlotsUtc, _bookedSlotsUtc)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookingErrorMessage, bookingErrorMessage) || other.bookingErrorMessage == bookingErrorMessage)&&(identical(other.preferredConsultationSlotUtc, preferredConsultationSlotUtc) || other.preferredConsultationSlotUtc == preferredConsultationSlotUtc)&&(identical(other.attachment, attachment) || other.attachment == attachment)&&(identical(other.attachmentErrorKey, attachmentErrorKey) || other.attachmentErrorKey == attachmentErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,message,nameValidationError,emailValidationError,isServerOnline,isLoadingBookedSlots,bookedSlotsErrorKey,const DeepCollectionEquality().hash(_bookedSlotsUtc),bookingStatus,bookingErrorMessage,preferredConsultationSlotUtc,attachment,attachmentErrorKey);

@override
String toString() {
  return 'HomeConsultationState(name: $name, email: $email, message: $message, nameValidationError: $nameValidationError, emailValidationError: $emailValidationError, isServerOnline: $isServerOnline, isLoadingBookedSlots: $isLoadingBookedSlots, bookedSlotsErrorKey: $bookedSlotsErrorKey, bookedSlotsUtc: $bookedSlotsUtc, bookingStatus: $bookingStatus, bookingErrorMessage: $bookingErrorMessage, preferredConsultationSlotUtc: $preferredConsultationSlotUtc, attachment: $attachment, attachmentErrorKey: $attachmentErrorKey)';
}


}

/// @nodoc
abstract mixin class _$HomeConsultationStateCopyWith<$Res> implements $HomeConsultationStateCopyWith<$Res> {
  factory _$HomeConsultationStateCopyWith(_HomeConsultationState value, $Res Function(_HomeConsultationState) _then) = __$HomeConsultationStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String message, String? nameValidationError, String? emailValidationError, bool? isServerOnline, bool isLoadingBookedSlots, String? bookedSlotsErrorKey, List<DateTime> bookedSlotsUtc, ConsultationBookingStatus bookingStatus, String? bookingErrorMessage, DateTime? preferredConsultationSlotUtc, ConsultationAttachment? attachment, String? attachmentErrorKey
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? message = null,Object? nameValidationError = freezed,Object? emailValidationError = freezed,Object? isServerOnline = freezed,Object? isLoadingBookedSlots = null,Object? bookedSlotsErrorKey = freezed,Object? bookedSlotsUtc = null,Object? bookingStatus = null,Object? bookingErrorMessage = freezed,Object? preferredConsultationSlotUtc = freezed,Object? attachment = freezed,Object? attachmentErrorKey = freezed,}) {
  return _then(_HomeConsultationState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,nameValidationError: freezed == nameValidationError ? _self.nameValidationError : nameValidationError // ignore: cast_nullable_to_non_nullable
as String?,emailValidationError: freezed == emailValidationError ? _self.emailValidationError : emailValidationError // ignore: cast_nullable_to_non_nullable
as String?,isServerOnline: freezed == isServerOnline ? _self.isServerOnline : isServerOnline // ignore: cast_nullable_to_non_nullable
as bool?,isLoadingBookedSlots: null == isLoadingBookedSlots ? _self.isLoadingBookedSlots : isLoadingBookedSlots // ignore: cast_nullable_to_non_nullable
as bool,bookedSlotsErrorKey: freezed == bookedSlotsErrorKey ? _self.bookedSlotsErrorKey : bookedSlotsErrorKey // ignore: cast_nullable_to_non_nullable
as String?,bookedSlotsUtc: null == bookedSlotsUtc ? _self._bookedSlotsUtc : bookedSlotsUtc // ignore: cast_nullable_to_non_nullable
as List<DateTime>,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as ConsultationBookingStatus,bookingErrorMessage: freezed == bookingErrorMessage ? _self.bookingErrorMessage : bookingErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,preferredConsultationSlotUtc: freezed == preferredConsultationSlotUtc ? _self.preferredConsultationSlotUtc : preferredConsultationSlotUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,attachment: freezed == attachment ? _self.attachment : attachment // ignore: cast_nullable_to_non_nullable
as ConsultationAttachment?,attachmentErrorKey: freezed == attachmentErrorKey ? _self.attachmentErrorKey : attachmentErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
