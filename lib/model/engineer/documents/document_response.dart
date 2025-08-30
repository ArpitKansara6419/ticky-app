import 'package:ticky/model/engineer/documents/document_data.dart';

class DocumentResponse {
  List<DocumentData>? documentData;
  String? message;

  DocumentResponse({this.documentData, this.message});

  DocumentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      documentData = <DocumentData>[];
      json['data'].forEach((v) {
        documentData!.add(new DocumentData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documentData != null) {
      data['data'] = this.documentData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
