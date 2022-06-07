

class TicketResponse {

  int? id;
  int? chatId;
  String? message;
  int? userId;
  int? accountantId;
  bool? isDeleted;
  String? created;
  int? zandeskId;
  int? zendeskProfileId;
  bool? isRead;
  int? ownerId;
  String? waitTime;

  TicketResponse(this.id, this.chatId, this.message, this.userId,
      this.accountantId, this.isDeleted, this.created,
      this.zandeskId, this.zendeskProfileId, this.isRead, this.ownerId,
      this.waitTime);


  factory TicketResponse.fromJson(dynamic json) {
    return TicketResponse(
        json['id'] as int,
        json['chatId'] as int,
        json['message'] as String,
        json['userId'] as int,
        json['accountantId'] as int,
        json['isDeleted'] as bool,
        json['created'] as String,
        json['zandeskId'] as int,
        json['zandeskProfileId'] as int,
        json['isRead'] as bool,
        json['ownerId'] as int,
        json['waitTime'] as String
    );
  }
}