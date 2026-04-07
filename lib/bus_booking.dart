import 'package:flutter/material.dart';

import 'hotel_booking.dart';

class BusBookingPage extends StatefulWidget {
  const BusBookingPage({super.key});

  @override
  State<BusBookingPage> createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {

  int selectedTab = 0;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController   = TextEditingController();
  String selectedDate = 'Select Date';

  void pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = "${picked.day} / ${picked.month} / ${picked.year}");
    }
  }

  void swapLocations() {
    setState(() {
      String temp         = fromController.text;
      fromController.text = toController.text;
      toController.text   = temp;
    });
  }

  void bookNow() {
    if (fromController.text.isEmpty || toController.text.isEmpty || selectedDate == 'Select Date') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill the form')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Searching buses...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Booking', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( // bus hotel buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => selectedTab = 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 0 ? Colors.green : Colors.white,
                      foregroundColor: selectedTab == 0 ? Colors.white : Colors.green,
                      side: BorderSide(color: Colors.green)
                    ),
                    child: Text('Bus', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => selectedTab = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 1 ? Colors.green : Colors.white,
                      foregroundColor: selectedTab == 1 ? Colors.white : Colors.green,
                      side: BorderSide(color: Colors.green),
                    ),
                    child: Text('Hotel', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            if (selectedTab == 0) ...[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    TextField(
                      controller: fromController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    IconButton(
                      onPressed: swapLocations,
                      icon: Icon(Icons.swap_vert, color: Colors.green),
                    ),

                    SizedBox(height: 10),
                    TextField(
                      controller: toController,
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text('Journey Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              OutlinedButton.icon(
                onPressed: pickDate,
                icon: Icon(Icons.calendar_month, color: Colors.green, size: 18),
                label: Text(selectedDate, style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: bookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Book Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),

            ] else ...[
              HotelBookingPage(),
            ],

          ],
        ),
      ),
    );
  }
}