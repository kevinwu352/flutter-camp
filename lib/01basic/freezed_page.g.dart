// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample4 _$Sample4FromJson(Map<String, dynamic> json) => Sample4(
  const EpochDateTimeConverter().fromJson((json['value'] as num).toInt()),
);

Map<String, dynamic> _$Sample4ToJson(Sample4 instance) => <String, dynamic>{
  'value': const EpochDateTimeConverter().toJson(instance.value),
};

Usery _$UseryFromJson(Map<String, dynamic> json) => Usery(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  birthday: const EpochDateTimeConverter().fromJson(
    (json['birthday'] as num).toInt(),
  ),
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  book: Book.fromJson(json['book'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UseryToJson(Usery instance) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'birthday': const EpochDateTimeConverter().toJson(instance.birthday),
  'gender': _$GenderEnumMap[instance.gender]!,
  'book': instance.book,
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.unknown: 'unknown',
};

Book _$BookFromJson(Map<String, dynamic> json) =>
    Book(name: json['name'] as String);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'name': instance.name,
};
