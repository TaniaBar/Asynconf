import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_electron_midali/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  final events = [];

  @override
  Widget build(BuildContext context) {

    // pop up au click sur l'icon info
    Future<void> showEventDetailsDialog(Event eventData) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conférence '),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset("assets/images/${eventData.avatar}.jpg", height: 100,),
                  Text('Titre: ${eventData.subject}'),
                  Text('Speaker: ${eventData.speaker}'),
                  Text('Date de la conf: ${DateFormat.yMd().add_jm().format(eventData.timestamp.toDate())}'),

                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ajouter au calendrier')
              ),
              SizedBox(width: 20),
              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Events").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData){
            return const Text('Aucune conférence');
          }

          List<Event> events = [];
          snapshot.data!.docs.forEach((data) {
            events.add(Event.fromData(data));
          });

          return ListView.builder(
            itemCount: events.length ,
            itemBuilder: (context, index) {
              final event = events[index];
              final avatar = event.avatar;
              final speaker = event.speaker;
              final Timestamp timestamp = event.timestamp;
              final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());
              final subject = event.subject;


              return Card(
                child: ListTile(
                  leading: Image.asset("assets/images/$avatar.jpg"),
                  title: Text("$speaker ($date)"),
                  subtitle: Text("$subject"),
                  trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () { showEventDetailsDialog(event); },
                  ),
                ),
              );
            },
          );
        } ,
      )
    );
  }
}
