class MasterDataResponse {
  List<MasterData>? masterDataList;
  bool? success;
  String? message;

  MasterDataResponse({this.masterDataList, this.success, this.message});

  MasterDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      masterDataList = <MasterData>[];
      json['data'].forEach((v) {
        masterDataList!.add(new MasterData.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.masterDataList != null) {
      data['data'] = this.masterDataList!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class MasterData {
  String? value;
  String? label;

  MasterData({this.value, this.label});

  MasterData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}
