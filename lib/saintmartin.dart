import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SaintMartinPage extends StatefulWidget {
  @override
  State<SaintMartinPage> createState() => _SaintMartinPageState();
}

class _SaintMartinPageState extends State<SaintMartinPage> {
  bool isFavorite = false;

  final String description =
      "Saint Martin is the only coral island in Bangladesh, located in the northeastern part of the Bay of Bengal. "
      "It is famous for its crystal clear water, coral reefs, and coconut trees.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Image.asset('assets/images/saintmartin.jpg', width: double.infinity, height: 280, fit: BoxFit.cover),

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
                  child: GestureDetector(
                    onTap: () => setState(() => isFavorite = !isFavorite),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Saint Martin', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse("https://maps.google.com/?q=Saint+Martin+Island,Bangladesh");
                      await launchUrl(url);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green, size: 20),
                        SizedBox(width: 4),
                        Text('Bangladesh', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(description, style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5)),
                  SizedBox(height: 20),
                  Text('Explore In Saint Martin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SpotCard('Cheradwip', 'assets/images/spots/saintmartin/cheradwip.jpg'),
                  SpotCard('Coral', 'assets/images/spots/saintmartin/coral.jpg'),
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
  final String name, imagePath;
  SpotCard(this.name, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, height: 200, margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))],
      ),
    );
  }
}