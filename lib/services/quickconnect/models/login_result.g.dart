// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResultSuccessImpl _$$LoginResultSuccessImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResultSuccessImpl(
  sid: json['sid'] as String,
  availableAddress: json['availableAddress'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$LoginResultSuccessImplToJson(
  _$LoginResultSuccessImpl instance,
) => <String, dynamic>{
  'sid': instance.sid,
  'availableAddress': instance.availableAddress,
  'runtimeType': instance.$type,
};

_$LoginResultFailureImpl _$$LoginResultFailureImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResultFailureImpl(
  errorMessage: json['errorMessage'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$LoginResultFailureImplToJson(
  _$LoginResultFailureImpl instance,
) => <String, dynamic>{
  'errorMessage': instance.errorMessage,
  'runtimeType': instance.$type,
};

_$LoginResultRequireOTPImpl _$$LoginResultRequireOTPImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResultRequireOTPImpl(
  errorMessage: json['errorMessage'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$LoginResultRequireOTPImplToJson(
  _$LoginResultRequireOTPImpl instance,
) => <String, dynamic>{
  'errorMessage': instance.errorMessage,
  'runtimeType': instance.$type,
};

_$LoginResultRequireOTPWithAddressImpl
_$$LoginResultRequireOTPWithAddressImplFromJson(Map<String, dynamic> json) =>
    _$LoginResultRequireOTPWithAddressImpl(
      errorMessage: json['errorMessage'] as String,
      availableAddress: json['availableAddress'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoginResultRequireOTPWithAddressImplToJson(
  _$LoginResultRequireOTPWithAddressImpl instance,
) => <String, dynamic>{
  'errorMessage': instance.errorMessage,
  'availableAddress': instance.availableAddress,
  'runtimeType': instance.$type,
};
