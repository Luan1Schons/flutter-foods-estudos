import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ScreenWidget extends StatefulWidget {
  const ScreenWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScreenWidgetState();
  }
}

Future<RestaurantMenu> fetch() async {
  var response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));
  var json = jsonDecode(response.body);
  var restaurantMenu = RestaurantMenu.fromJson(json);

  return restaurantMenu;
}

class ScreenWidgetState extends State<ScreenWidget> {
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  final Future<String> _loadingCardapio = Future<String>.delayed(
    const Duration(seconds: 5),
    () => 'Cardápio Carregado',
  );

  @override
  Widget build(BuildContext context) {
    //enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map objItems = {
      "items": {
        {
          "icon": "https://i.imgur.com/LMf0JBC.png",
          "image": "https://i.imgur.com/lbVpirN.jpg",
          "title": "Pizza Calabresa",
          "value": "Valor: 50.0"
        },
        {
          "icon": "https://i.imgur.com/LMf0JBC.png",
          "image":
              "https://www.sabornamesa.com.br/media/k2/items/cache/b9ad772005653afce4d4bd46c2efe842_XL.jpg",
          "title": "Hamburguer",
          "value": "Valor: 50.0"
        },
        {
          "icon": "https://i.imgur.com/ROUoabP.png",
          "image":
              "https://i0.wp.com/integradanews.com.br/wp-content/uploads/2021/12/Post_Previsao_Tempo_Somar_Integrada.png?resize=718%2C586&ssl=1",
          "title": "Portão: Nublado",
          "value": "9.0 Graus"
        },
        {
          "icon": "https://i.imgur.com/LMf0JBC.png",
          "image":
              "https://s2.glbimg.com/GToJPVardYjpzSeMfNdhCRqp6NU=/0x0:1080x608/924x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_e84042ef78cb4708aeebdf1c68c6cbd6/internal_photos/bs/2022/F/5/hm5zNWRiAawYNSghKZbw/capa-materia-gshow-2022-02-16t145245.399.png",
          "title": "Lasanha",
          "value": "Valor: 30.0"
        }
      }
    };

    return Scaffold(
      body: FutureBuilder<Object>(
          future: _loadingCardapio,
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true),
                  items: objItems['items'].map<Widget>((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: width,
                          height: height,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3, // takes 30% of available width
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            item['icon'],
                                            height: 100,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${item["title"]}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          const Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                top: 10),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "${item['value']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7, // takes 70% of available width
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: item['image'],
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => const Center(
                                      child: Text(
                                        "Carregando...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: Text('Carregando cardápio...')),
                )
              ];
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
          }),
    );
  }
}

class RestaurantMenu {
  final String title;
  final int id;
  final int userId;
  final bool completed;

  RestaurantMenu(this.title, this.userId, this.completed, this.id);

  factory RestaurantMenu.fromJson(Map json) {
    return RestaurantMenu(
        json['title'], json['userId'], json['completed'], json['id']);
  }
}
