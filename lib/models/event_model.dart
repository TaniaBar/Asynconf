import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_electron_midali/pages/event_page.dart';

class Event {
  final String subject;
  final String speaker;
  final String avatar;
  final String type;
  final Timestamp timestamp;


  Event({
    required this.subject,
    required this.speaker,
    required this.avatar,
    required this.type,
    required this.timestamp,
  });

  factory Event.fromData(dynamic data) {
    return Event(
        subject: data['subject'],
        speaker: data['speaker'],
        avatar: data['avatar'].toString().toLowerCase(),
        type: data['type'],
        timestamp: data['date']
    );
  }
}