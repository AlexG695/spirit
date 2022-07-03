import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  String id;
  String idUser;
  String image1;
  String image2;
  String titleorname;
  String textDescription;
  List<Report> toList = [];

  Report({
    this.id,
    this.idUser,
    this.image1,
    this.image2,
    this.titleorname,
    this.textDescription,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        idUser: json["id_user"],
        image1: json["image1"],
        image2: json['image2'],
        titleorname: json["titleorname"],
        textDescription: json["text_description"],
      );

  Report.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Report report = Report.fromJson(item);
      toList.add(report);
    });
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "image1": image1,
        "image2": image2,
        "titleorname": titleorname,
        "text_description": textDescription,
      };
}
