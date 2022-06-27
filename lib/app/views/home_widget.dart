import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';

class HomePage extends StatefulWidget {
  final String titulo;

  const HomePage({super.key, required this.titulo});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String key = '';

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/foods.png',
            height: 150.0,
            width: 150.0,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  'INSIRA A SUA CHAVE:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              )),
              TextField(
                onChanged: (value) => {key = value},
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Sua Chave',
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
              ElevatedButton(
                  onPressed: () => {
                        if (key.isNotEmpty)
                          {
                            Navigator.of(context)
                                .pushReplacementNamed('/screen'),
                          }
                      },
                  child: const SizedBox(
                    child: Center(child: Text("Carregar Cardápio")),
                  )),
            ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return Scaffold(
            body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(children: [_body()])),
              ],
            ),
          ),
        ));
      },
    );
  }
}

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: AppController.instance.isDarkTheme,
        onChanged: (value) {
          AppController.instance.changeTheme();
        });
  }
}
