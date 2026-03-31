import 'package:flutter/material.dart';
import 'bus_booking.dart';
import 'coxsbazar.dart';
import 'sylhet.dart';
import 'chittagong.dart';
import 'bandarban.dart';
import 'khagrachari.dart';
import 'saintmartin.dart';
import 'srimongal.dart';
import 'tour_wallet.dart';
import 'tour_plan.dart';

final places = [
  {'name': "Cox's Bazar",  'tagline': "World's Longest Sea Beach",     'img': 'assets/images/coxsbazar.jpg'},
  {'name': "Bandarban",    'tagline': "Land of Hills and Tribes",       'img': 'assets/images/bandarban.jpg'},
  {'name': "Sylhet",       'tagline': "Kingdom of Tea and Mist",        'img': 'assets/images/sylhet.jpg'},
  {'name': "Saint Martin", 'tagline': "Bangladesh's Only Coral Island", 'img': 'assets/images/saintmartin.jpg'},
  {'name': "Srimongal",    'tagline': "Tea Capital of Bangladesh",      'img': 'assets/images/srimongal.jpg'},
  {'name': "Khagrachari",  'tagline': "A valley of hills, culture, and calm beauty", 'img':'assets/images/khagrachari.jpg'},
  {'name': "Chittagong",  'tagline': "The port city of hills and sea.", 'img':'assets/images/chittagong.jpg'},
];

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<TourPlan> tourPlans = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 2 ? TourWalletPage(tourPlans: tourPlans, onAdd: (plan) {
        setState(() {
          tourPlans.add(plan);
        });
      })
      : currentIndex == 1
          ? BusBookingPage()
          : HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          if (i == 0 || i ==1 || i == 2 || i == 3) setState(() => currentIndex = i);
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),                   label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article),                label: 'Book Now'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Tour Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),               label: 'More'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('ExploreX', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Vanessa!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Where to next?',  style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search destinations...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Discover Places', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...places.map((p) => DestinationCard(name: p['name']!, tagline: p['tagline']!, imagePath: p['img']!)),
          ],
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name, tagline, imagePath;
  DestinationCard({required this.name, required this.tagline, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (name == "Cox's Bazar") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CoxsBazarPage()));
        } else if (name == "Sylhet") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SylhetPage()));
        } else if (name == "Bandarban") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BandarbanPage()));
        } else if (name == "Khagrachari") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => KhagrachariPage()));
        } else if (name == "Saint Martin") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SaintMartinPage()));
        } else if (name == "Srimongal") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SrimongalPage()));
        } else if (name == "Chittagong") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChittagongPage()));
        }
      },
      child: Container(
        width: double.infinity,
        height: 180,
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(tagline, style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String name, tagline, imagePath;
  DetailPage({required this.name, required this.tagline, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          SizedBox(height: 24),
          Text(name,    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(tagline, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: Text('Go Back', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}