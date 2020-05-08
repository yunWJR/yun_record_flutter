class IdsDto {
  List<int> ids;

  IdsDto({this.ids});

  factory IdsDto.fromJson(Map<String, dynamic> json) {
    return IdsDto(
      ids: json['ids'] != null ? new List<int>.from(json['ids']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ids != null) {
      data['ids'] = this.ids;
    }
    return data;
  }
}
