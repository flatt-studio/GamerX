import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'platforms_record.g.dart';

abstract class PlatformsRecord
    implements Built<PlatformsRecord, PlatformsRecordBuilder> {
  static Serializer<PlatformsRecord> get serializer =>
      _$platformsRecordSerializer;

  @nullable
  BuiltList<String> get platfotmsText;

  @nullable
  String get platform;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PlatformsRecordBuilder builder) => builder
    ..platfotmsText = ListBuilder()
    ..platform = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('platforms');

  static Stream<PlatformsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PlatformsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PlatformsRecord._();
  factory PlatformsRecord([void Function(PlatformsRecordBuilder) updates]) =
      _$PlatformsRecord;

  static PlatformsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPlatformsRecordData({
  String platform,
}) =>
    serializers.toFirestore(
        PlatformsRecord.serializer,
        PlatformsRecord((p) => p
          ..platfotmsText = null
          ..platform = platform));
