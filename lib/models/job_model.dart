class JobModel {
  int menuMainID;
  String menuMainName;
  int menuSubID;
  String menuSubName;
  String ownerName;

  JobModel(
      {this.menuMainID,
      this.menuMainName,
      this.menuSubID,
      this.menuSubName,
      this.ownerName});

  JobModel.fromJson(Map<String, dynamic> json) {
    menuMainID = json['MenuMain_ID'];
    menuMainName = json['MenuMain_Name'];
    menuSubID = json['MenuSub_ID'];
    menuSubName = json['MenuSub_Name'];
    ownerName = json['Owner_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MenuMain_ID'] = this.menuMainID;
    data['MenuMain_Name'] = this.menuMainName;
    data['MenuSub_ID'] = this.menuSubID;
    data['MenuSub_Name'] = this.menuSubName;
    data['Owner_Name'] = this.ownerName;
    return data;
  }
}
