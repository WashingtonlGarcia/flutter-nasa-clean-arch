import '../../domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  const SpaceMediaModel({required String description, required String mediaType, required String title, required String mediaUrl})
      : super(title: title, description: description, mediaType: mediaType, mediaUrl: mediaUrl);

  factory SpaceMediaModel.fromMap({required Map<String, dynamic> map}) => SpaceMediaModel(
      description: map['explanation'] as String,
      mediaType: map['media_type'] as String,
      title: map['title'] as String,
      mediaUrl: map['url'] as String);

  Map<String, dynamic> toMap() => {'explanation': description, 'title': title, 'media_type': mediaType, 'url': mediaUrl};
}
