import 'package:collection/collection.dart' show IterableExtension;
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String? name;

  /// the flag of the country
  final String? flagUri;

  /// the country code (IT,AF..)
  final String? code;

  /// the nationality id
  final String? nationalityId;

  CountryCode({
    this.name,
    this.flagUri,
    this.code,
    this.nationalityId,
  });

  @Deprecated('Use `fromCountryCode` instead.')
  factory CountryCode.fromCode(String isoCode) {
    return CountryCode.fromCountryCode(isoCode);
  }

  factory CountryCode.fromCountryCode(String countryCode) {
    final Map<String, String>? jsonCode = codes.firstWhereOrNull(
      (code) => code['code'] == countryCode,
    );
    return CountryCode.fromJson(jsonCode!);
  }

  factory CountryCode.fromNationalityId(String nationalityId) {
    final Map<String, String>? jsonCode = codes.firstWhereOrNull(
      (code) => code['nationality_id'] == nationalityId,
    );
    return CountryCode.fromJson(jsonCode!);
  }

  CountryCode localize(BuildContext context) {
    return this
      ..name =
          CountryLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      name: json['name'],
      code: json['code'],
      nationalityId: json['nationality_id'],
      flagUri: 'flags/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$nationalityId";

  String toLongString() => "$nationalityId ${toCountryStringOnly()}";

  String toCountryStringOnly() {
    return '$_cleanName';
  }

  String? get _cleanName {
    return name?.replaceAll(RegExp(r'[[\]]'), '').split(',').first;
  }
}
