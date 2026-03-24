import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KhagrachariPage extends StatelessWidget {
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
                  width: double.infinity,
                  height: 280,
                  child: Image.asset('assets/images/khagrachari.jpg', fit: BoxFit.cover),
                ),
                Positioned(
                  top: 50, left: 16,
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
                  top: 50, right: 16,
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

                  Text('Khagrachari', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse("https://maps.google.com/?q=Khagrachari,Bangladesh");
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
                    "Khagrachari is a peaceful hill district in the Chittagong Hill Tracts. It is known for its misty mountains, tribal culture, and the famous Sajek Valley — one of Bangladesh's most popular tourist destinations.",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text('Explore In Khagrachari', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),

                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SpotCard(name: 'Alutila',  imagePath: 'assets/images/spots/khagrachari/alutila.jpg'),
                  SpotCard(name: 'Sajek',    imagePath: 'assets/images/spots/khagrachari/sajek.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),
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