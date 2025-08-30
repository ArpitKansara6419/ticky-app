class CommonMetaDataResponse {
  List<CommonMetaData>? metaData;
  String? message;

  CommonMetaDataResponse({this.metaData, this.message});

  CommonMetaDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      metaData = <CommonMetaData>[];
      json['data'].forEach((v) {
        metaData!.add(new CommonMetaData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaData != null) {
      data['data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CommonMetaData {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CommonMetaData({this.id, this.name, this.createdAt, this.updatedAt});

  CommonMetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
