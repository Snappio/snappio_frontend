class MsgData {
  Message? message;

  MsgData({this.message});

  MsgData.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }
}

class Message {
  String? data;
  String? user;
  String? time;
  bool? isme;

  Message({this.data, this.user, this.time, this.isme});

  Message.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    user = json['user'];
    time = json['time'];
    isme = json['isme'];
  }
}
