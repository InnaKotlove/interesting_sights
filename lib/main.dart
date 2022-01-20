import 'package:flutter/material.dart';

void main() {
  runApp(const AttractionApp());
}

class AttractionApp extends StatefulWidget {
  const AttractionApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AttractionApp();
}

const List<String> attractions = [
  "Манявский водопад",
  "Озеро Лемурийское",
  "Оптимистическая пещера"
];

const List<String> attractionsImages = [
  "assets/images/001.jpg",
  "assets/images/002.jpg",
  "assets/images/003.jpg"
];

const List<String> attractionsDescription = [
  "Это один из крупных водопадов нашей страны высотой около 20 метров. Вода в нем ледяная, но местные жители утверждают, что эти воды имеют целебные и омолаживающие свойства. Ходят слухи, что здесь водятся мавки и другие лесные жители. Таинственное место. Кроме того, тут чистый воздух, большие старые ели и густые заросли папортника и мха, будто здесь никогда не ступала нога человека.",
  "В народе его называют украинским Мертвым морем, уровень соли в нем не ниже. Вода в озере имеет розовый оттенок благодаря растущим в ней водорослям. Озеро не только очень красивое, а и лечебное, в чем не уступает мировым оздоровительным местам. Лечебная грязь тут уникальная, на нее уже обратили внимание европейские косметические компании. Розовое озеро должен посетить каждый.",
  "Самая длинная в мире гипсовая пещера длиной 240 км, и это только та часть, которая уже изучена. Тут загадка в том, что цвет гипса меняется. В нижней части 20-метрового пласта гипс желто-серый, а в верхней - темно-бурый. По пещере проводят «экспедиции», во время которых возможно нужно будет прыгать, бегать, пролазить и иногда сталкиваться с летучими мышами. Но чаще всего они спят.",
];

class _AttractionApp extends State<AttractionApp> {
  int _selectedPlace = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interesting points on the map',
      home: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey('AttractionsPage'),
            child: AttractionScreen(
              onTapped: _handleAttractionTapped,
            ),
          ),
          if (_selectedPlace != -1)
            MaterialPage(
                key: const ValueKey('_selectedPlace'),
                child: AttractionsDetailScreen(index: _selectedPlace))
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          setState(() {
            _selectedPlace = -1;
          });

          return true;
        },
      ),
    );
  }

  void _handleAttractionTapped(int index) {
    setState(() {
      _selectedPlace = index;
    });
  }
}

class AttractionScreen extends StatelessWidget {
  ValueChanged<int> onTapped;

  AttractionScreen({required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interesting points on the map'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: attractions.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(attractionsImages[index]),
              ),
              title: Text(
                attractions[index],
                style: const TextStyle(
                    fontStyle: FontStyle.italic, fontSize: 15.0),
              ),
              onTap: () => onTapped(index),
            );
          }),
    );
  }
}

class AttractionsDetailScreen extends StatelessWidget {
  int index;

  AttractionsDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(attractions[index]),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage(attractionsImages[index]),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(attractionsDescription[index])
                ],
              ),
            )));
  }
}
