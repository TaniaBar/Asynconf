import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'event_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asynconf 2022"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/logo.svg",
                colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
              ),
              const Text(
                "Asinconf 2022",
                style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins'
                ),
              ),
              const Text(
                "Salon virtuel de l'informatique. Du 27 au 29 octobre 2022",
                style: TextStyle(
                  fontSize: 24,
                ) ,
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              ElevatedButton.icon(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                    backgroundColor: WidgetStatePropertyAll(Colors.green)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const EventPage()
                    ),
                  );
                },
                label: const Text("Afficher le planning",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          )
      ),
    );
  }
}