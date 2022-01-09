import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'consols_record.g.dart';

abstract class ConsolsRecord
    implements Built<ConsolsRecord, ConsolsRecordBuilder> {
  static Serializer<ConsolsRecord> get serializer => _$consolsRecordSerializer;

  @nullable
  String get id;

  @nullable
  String get name;

  @nullable
  BuiltList<String> get gameList;

  @nullable
  String get image;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ConsolsRecordBuilder builder) => builder
    ..id = ''
    ..name = ''
    ..gameList = ListBuilder()
    ..image = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('consols');

  static Stream<ConsolsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ConsolsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ConsolsRecord._();
  factory ConsolsRecord([void Function(ConsolsRecordBuilder) updates]) =
      _$ConsolsRecord;

  static ConsolsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createConsolsRecordData({
  String id,
  String name,
  String image,
}) =>
    serializers.toFirestore(
        ConsolsRecord.serializer,
        ConsolsRecord((c) => c
          ..id = id
          ..name = name
          ..gameList = null
          ..image = image));
