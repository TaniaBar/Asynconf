import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  final events = [
    {
      "speaker": "Test du test",
      "date": "13h à 13h30",
      "subject": "Le code legacy",
      "avatar": "chairs"
    },
    {
      "speaker": "Nana Cho",
      "date": "17h30 à 18h",
      "subject": "Git blame --no-defense ",
      "avatar": "conference-room"
    },
    {
      "speaker": "Pinuccio Chat",
      "date": "18h à 18h30",
      "subject": "A la découvert des IA",
      "avatar": "international-conference"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning du salon"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: events.length ,
          itemBuilder: (context, index) {
            final event = events[index];
            final avatar = event['avatar'];
            final speaker = event['speaker'];
            final date = event['date'];
            final subject = event['subject'];

            return Card(
              child: ListTile(
                leading: Image.asset("assets/images/$avatar.jpg"),
                title: Text("$speaker ($date)"),
                subtitle: Text("$subject"),
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        ),
      ),
    );
  }
}
