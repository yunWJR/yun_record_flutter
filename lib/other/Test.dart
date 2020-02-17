package other

class Test {
    List<Data> `data`;
    int code; // 200
    String errorMsg;
    String serverName;

    Test({this.`data`, this.code, this.errorMsg, this.serverName});

    factory Test.fromJson(Map<String, dynamic> json) {
        return Test(
            `data`: json['`data`'] != null ? (json['`data`'] as List).map((i) => Data.fromJson(i)).toList() : null, 
            code: json['code'], 
            errorMsg: json['errorMsg'], 
            serverName: json['serverName'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['errorMsg'] = this.errorMsg;
        data['serverName'] = this.serverName;
        if (this.`data` != null) {
            data['`data`'] = this.`data`.map((v) => v.toJson()).toList();
        }
        return data;
    }
}