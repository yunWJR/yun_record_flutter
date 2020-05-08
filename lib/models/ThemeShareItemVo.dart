class ThemeShareItemVo {
  int businessId; // 2
  String businessName; // a
  int businessType; // 1
  int id; // 14
  String remark; // null
  int themeId; // 1
  String themeName; // 我的主题

  ThemeShareItemVo(
      {this.businessId, this.businessName, this.businessType, this.id, this.remark, this.themeId, this.themeName});

  factory ThemeShareItemVo.fromJson(Map<String, dynamic> json) {
    return ThemeShareItemVo(
      businessId: json['businessId'],
      businessName: json['businessName'],
      businessType: json['businessType'],
      id: json['id'],
      remark: json['remark'],
      themeId: json['themeId'],
      themeName: json['themeName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessId'] = this.businessId;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['id'] = this.id;
    data['themeId'] = this.themeId;
    data['themeName'] = this.themeName;
    data['remark'] = this.remark;

    return data;
  }
}
