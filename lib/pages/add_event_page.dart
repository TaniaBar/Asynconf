import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formKey = GlobalKey<FormState>();

  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();
  String selectedConfType = 'talk';
  DateTime? selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    speakerNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nom conférence',
                      hintText: 'Entre le nom de la conférence',
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tu dois completer ce texte";
                    }
                    return null;
                  },
                  controller: confNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nom du speaker',
                      hintText: 'Entre le nom du speaker',
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tu dois completer ce texte";
                    }
                    return null;
                  },
                  controller: speakerNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(value: 'talk', child: Text("Talk show")),
                      DropdownMenuItem(value: 'demo', child: Text("Demo code")),
                      DropdownMenuItem(value: 'partner', child: Text("Partner"))
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder()
                    ),
                    value: selectedConfType,
                    onChanged: (value) {
                      setState(() {
                        selectedConfType = value!;
                      });
                    }
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                   hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Choisir une date',
                  ),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        final confName = confNameController.text;
                        final speakerName = speakerNameController.text;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Envoi en cours..."))
                        );
                        FocusScope.of(context).requestFocus(FocusNode());

                        //ajout dans la base de données
                        CollectionReference eventsRef = FirebaseFirestore.instance.collection("Events");
                          try {
                            eventsRef.add({
                              'speaker': speakerName,
                              'date': selectedDate,
                              'subject': confName,
                              'type': selectedConfType,
                              'avatar': 'chairs'
                            });
                            print('add data ok on Firestore!');
                          } catch (e) {
                            print('error add data on firestore!');
                          }
                      }

                    },
                    child: const Text('Envoyer')
                ),
              )
            ],
          )
      ),
    );
  }
}

