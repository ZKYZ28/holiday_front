import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/weather.png"),
            const Text(
              "Welcome to Holiday",
              style: TextStyle(
                  fontSize: 36,
                  color: Color(0xFF1E3A8A)
              ),
            ),
            const Text(
              "Salut à tous",
              style: TextStyle(
                  fontSize: 24
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Couleur de fond lorsque le bouton est enfoncé
                      return Color(0xFF1E3A8A); // Par exemple, la même couleur que la normale
                    }
                    // Couleur de fond lorsque le bouton est en état normal
                    return Color(0xFF1E3A8A);
                  },
                ),
              ),
              onPressed: () => {

              },
              label: Text(
                "Voir les vacances",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              icon: Icon(Icons.remove_red_eye_sharp),
            )
          ],
        )
    );
  }
}