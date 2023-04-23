import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';
import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';

class Recommand extends StatelessWidget {
  Recommand({Key? key}) : super(key: key);

  final List<Map<String, String>> _foodList = [
    {
      'title': 'สเต็ก',
      'image':
          'https://iamafoodblog.b-cdn.net/wp-content/uploads/2021/02/how-to-cook-steak-1061w.jpg',
      'Des': "ลุงหนวด"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: _foodList.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, String> food = _foodList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetail(
                    title: food['title']!,
                    backgroundImage: food['image']!,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      food['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      food['title']!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static getFoods() {}
}
