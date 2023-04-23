import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';
import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const FoodCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetail(
              title: title,
              backgroundImage: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Food extends StatelessWidget {
  Food({Key? key}) : super(key: key);

  final List<Map<String, String>> _foodList = [
    {
      'title': 'สเต็ก',
      'image':
          'https://iamafoodblog.b-cdn.net/wp-content/uploads/2021/02/how-to-cook-steak-1061w.jpg',
      'Des': "ลุงหนวด"
    },
    {
      'title': 'พิซซ่า',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Eataly_Las_Vegas_-_Feb_2019_-_Sarah_Stierch_12.jpg/800px-Eataly_Las_Vegas_-_Feb_2019_-_Sarah_Stierch_12.jpg',
      'Des': "1112"
    },
    {
      'title': 'ผัดไทย',
      'image':
          'https://www.silpa-mag.com/wp-content/uploads/2021/05/shrimp-5940735_1920.jpeg',
      'Des': "ป้าศรี"
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
