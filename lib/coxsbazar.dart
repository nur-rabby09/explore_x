import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoxsBazarPage extends StatefulWidget {
  @override
  State<CoxsBazarPage> createState() => _CoxsBazarPageState();
}

class _CoxsBazarPageState extends State<CoxsBazarPage> {
  bool isExpanded = false;

  final String shortText =
      "Cox's Bazar, often called the Queen of the Sea, is home to the longest natural sandy beach in the world — stretching over 120 km along the Bay of Bengal.";

  final String fullText =
      "Cox's Bazar, often called the Queen of the Sea, is home to the longest natural sandy beach in the world — stretching over 120 km along the Bay of Bengal. The town combines golden beaches, turquoise water, seafood delicacies, and a relaxed coastal lifestyle.\n\n"
      "🌅 Highlights:\n"
      "• Miles of unbroken sandy coastline\n"
      "• Gentle waves ideal for swimming or surfing\n"
      "• Colorful fishing boats, coral islands, and sea-view resorts\n"
      "• Best seafood in Bangladesh — fresh from the Bay of Bengal\n\n"
      "📍 Top Places to Visit:\n"
      "1. Laboni Beach — The main beach near the town center.\n"
      "2. Inani Beach — A quieter, more scenic coral-studded beach.\n"
      "3. Himchari National Park — Rolling hills and sea-view lookouts.\n"
      "4. Marine Drive Road — A 60-km coastal drive with breathtaking views.\n"
      "5. Saint Martin's Island — Bangladesh's only coral island.\n"
      "6. Moheshkhali Island — Mangrove forests and ancient temples.\n"
      "7. Burmese Market — Handmade crafts, jewelry, and local snacks.\n\n"
      "🗓 Best Time to Visit:\n"
      "• October – March: Cool, dry, perfect for beach activities.\n"
      "• April – June: Warm, sunny, ideal for sea swimming.";

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
                  child: Image.asset(
                    'assets/images/coxsbazar.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50, left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Positioned(
                  top: 50, right: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
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

                  Text(
                    "Cox's Bazar",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse("https://maps.google.com/?q=Cox's+Bazar,Bangladesh");
                      await launchUrl(url);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green, size: 20),
                        SizedBox(width: 4),
                        Text(
                          'Bangladesh',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    isExpanded ? fullText : shortText,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 6),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'See Less' : 'See More',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Explore In Cox's Bazar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SpotCard(name: 'Inani Beach',    imagePath: 'assets/images/spots/coxsbazar/inani.jpg'),
                  SpotCard(name: 'Himchori Hills', imagePath: 'assets/images/spots/coxsbazar/himchori.jpg'),
                  SpotCard(name: 'Laboni Beach',   imagePath: 'assets/images/spots/coxsbazar/laboni.jpg'),
                  SpotCard(name: 'Marine Drive',   imagePath: 'assets/images/spots/coxsbazar/marinedrive.jpg'),
                  SpotCard(name: 'Kolatoli Beach', imagePath: 'assets/images/spots/coxsbazar/kolatoli.jpg'),
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
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}