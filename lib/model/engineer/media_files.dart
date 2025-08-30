class MediaFiles {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  String? createdAt;
  String? updatedAt;
  String? conversionsDisk;
  String? uuid;
  String? originalUrl;
  String? url;
  String? previewUrl;

  MediaFiles(
      {this.id,
      this.modelType,
      this.url,
      this.modelId,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.conversionsDisk,
      this.uuid,
      this.originalUrl,
      this.previewUrl});

  MediaFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];
    createdAt = json['created_at'];
    url = json['url'];
    updatedAt = json['updated_at'];
    conversionsDisk = json['conversions_disk'];
    uuid = json['uuid'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['size'] = this.size;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['conversions_disk'] = this.conversionsDisk;
    data['uuid'] = this.uuid;
    data['original_url'] = this.originalUrl;
    data['preview_url'] = this.previewUrl;
    return data;
  }
}
