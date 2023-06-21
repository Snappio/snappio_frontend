/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class PostsModel {
  int? id;
  String? user;
  String? content;
  String? timestamp;
  String? image;

  PostsModel({
    this.id,
    this.user,
    this.content,
    this.timestamp,
    this.image,
  }); 

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    content = json['content'];
    timestamp = json['timestamp'];
    image = json['image'];
  }
}
