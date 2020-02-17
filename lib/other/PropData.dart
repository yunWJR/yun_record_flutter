package other

class PropData {
    bool hasData; // true
    Prop prop;
    PropDataX propData;

    PropData({this.hasData, this.prop, this.propData});

    factory PropData.fromJson(Map<String, dynamic> json) {
        return PropData(
            hasData: json['hasData'], 
            prop: json['prop'] != null ? Prop.fromJson(json['prop']) : null, 
            propData: json['propData'] != null ? PropDataX.fromJson(json['propData']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['hasData'] = this.hasData;
        if (this.prop != null) {
            data['prop'] = this.prop.toJson();
        }
        if (this.propData != null) {
            data['propData'] = this.propData.toJson();
        }
        return data;
    }
}