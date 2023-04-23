import 'package:flutter/material.dart';

class Savepage extends StatelessWidget {
  const Savepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Center(
          child: Text("Saved", style: TextStyle(fontSize: 25)),
        ),
        Card(
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://t3.ftcdn.net/jpg/01/52/64/46/360_F_152644607_od6h0eLcz1rvp5bXYCCZPmt1mlxJXWgC.jpg"),
              ),
              title: Text("สเต๊ก"),
              subtitle: Text("Buy at ลุงหนวด"),
              trailing: Icon(Icons.bookmark, color: Colors.yellow)),
        ),
        Card(
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://f.ptcdn.info/199/019/000/1400639315-o.jpg"),
              ),
              title: Text("ข้าวผัด"),
              subtitle: Text("Buy at ตามสั่งหน้าม."),
              trailing: Icon(Icons.bookmark, color: Colors.yellow)),
        ),
        Card(
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://tecnogasthai.com/wp-content/uploads/2022/07/pic-01-3.png"),
              ),
              title: Text("ผัดกะเพราหมูกรอบ"),
              subtitle: Text("Buy at กะเพราแท้"),
              trailing: Icon(Icons.bookmark, color: Colors.yellow)),
        ),
        Card(
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://pim.in.th/images/all-side-dish-pork/ivy-gourd-soup/ivy_gourd-soup-12.JPG"),
              ),
              title: Text("ต้มจืด"),
              subtitle: Text("Buy at ป้าศรีตามสั่ง"),
              trailing: Icon(Icons.bookmark, color: Colors.yellow)),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://f.ptcdn.info/645/047/000/ohl4zjyn4DbiuAARqzW-o.jpg"),
            ),
            title: Text("ส้มตำ"),
            subtitle: Text("Buy at ครัวน้องเน"),
            trailing: Icon(Icons.bookmark, color: Colors.yellow),
          ),
        ),
      ],
    );
  }
}




