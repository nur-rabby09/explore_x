import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BandarbanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Container(
                  width: 500,
                  height: 280,
                  child: Image.asset('assets/images/bandarban.jpg', fit: BoxFit.cover),
                ),
                Positioned(
                  top: 50, left: 18,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Positioned(
                  top: 50, right: 18,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Bandarban', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse("https://maps.google.com/?q=Bandarban,Bangladesh");
                      await launchUrl(url);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green, size: 20),
                        SizedBox(width: 4),
                        Text('Location', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(
                    "Bandarban is a hilly district in southeastern Bangladesh, home to several indigenous communities. It boasts some of the highest peaks in Bangladesh, dense forests, and stunning waterfalls.",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text('Explore In Bandarban', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),

                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SpotCard(name: 'Nilachal',  imagePath: 'assets/images/spots/bandarban/nilachal.jpg'),
                  SpotCard(name: 'Nilgiri',   imagePath: 'assets/images/spots/bandarban/nilgiri.jpg'),
                  SpotCard(name: 'Sangu',     imagePath: 'assets/images/spots/bandarban/sangu.jpg'),
                  SpotCard(name: 'Boga Lake', imagePath: 'assets/images/spots/bandarban/bogalake.jpg'),
                  SpotCard(name: 'Nafakhum',  imagePath: 'assets/images/spots/bandarban/nafakhum.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpotCard extends StatelessWidget {
  final String name;
  final String imagePath;

  SpotCard({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}