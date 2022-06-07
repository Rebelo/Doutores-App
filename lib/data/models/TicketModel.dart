

List<Ticket>? listTicket;

class Ticket {
  int? id;
  String? subject;
  bool? isDeleted;
  String? created;
  String? updated;
  String? responsable;
  bool? isClosed;
  int? unread;

  Ticket(this.id, this.subject, this.isDeleted, this.created,
      this.updated, this.responsable, this.isClosed, this.unread);

  factory Ticket.fromJson(dynamic json) {
    return Ticket(
        json['id'] as int,
        json['subject'] as String,
        json['isDeleted'] as bool,
        json['created'] as String,
        json['updated'] as String,
        json['responsable'] as String,
        json['isClosed'] as bool,
        json['unread'] as int,
    );
  }

}