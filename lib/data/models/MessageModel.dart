


class Message {
  int? messageId;
  String? message;
  String? created;
  int? authorId;
  int? userId;
  List<Document>? filesObjects = [];

  Message(this.messageId, this.message, this.created, this.authorId, this.userId, [this.filesObjects]);

  factory Message.fromJson(dynamic json){

    var docsJson = json['documents'] as List;
    if(docsJson.isNotEmpty){

      List<Document> docs = docsJson.map((tagJson) => Document.fromJson(tagJson)).toList();

      return Message(
          json['messageId'] as int,
          json['message'] as String,
          json['created'] as String,
          json['authorId'] as int,
          json['userId'] as int,
          docs
      );
    } else {
      return Message(
          json['messageId'] as int,
          json['message'] as String,
          json['created'] as String,
          json['authorId'] as int,
          json['userId'] as int,
          null
      );
    }
  }

  Message.from(Message mo): this(mo.messageId, mo.message, mo.created, mo.authorId, mo.userId);

}


class Document {
  String? downloadToken;
  String? name;
  int? messageId;

  Document(this.downloadToken, this.messageId, this.name);

  factory Document.fromJson(dynamic json){
    return Document(json['downloadToken'] as String, json['messageId'] as int, json['name'] as String);
  }

}
