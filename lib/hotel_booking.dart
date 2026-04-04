import 'package:flutter/material.dart';

class HotelBookingPage extends StatefulWidget {
  const HotelBookingPage({super.key});

  @override
  State<HotelBookingPage> createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {

  TextEditingController hotelName = TextEditingController();

  String checkInDate  = 'Check-in';
  String checkOutDate = 'Check-out';

  int adults   = 0;
  int children = 0;
  int rooms    = 1;

  // Opens date picker and saves to the correct variable
  void pickDate(String type) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      String formatted = "${picked.day}/${picked.month}/${picked.year}";
      setState(() {
        if (type == 'checkin')  checkInDate  = formatted;
        if (type == 'checkout') checkOutDate = formatted;
      });
    }
  }

  void searchHotel() {
    if (hotelName.text.isEmpty || checkInDate == 'Check-in' || checkOutDate == 'Check-out') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill Hotel Name, Check-in and Check-out')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Searching hotels...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Main Card//
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Hotel Name Field
                TextField(
                  controller: hotelName,
                  decoration: InputDecoration(
                    labelText: 'Hotel Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),

                SizedBox(height: 16),

                // Check-in and Check-out side by side
                // Check-in and Check-out side by side
                Row(
                  children: [

                    // Check-in Button
                    // Check-in Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => pickDate('checkin'),
                        child: Text(checkInDate, style: TextStyle(color: Colors.black87)),
                      ),
                    ),

                    SizedBox(width: 10),

                    // Check-out Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => pickDate('checkout'),
                        child: Text(checkOutDate, style: TextStyle(color: Colors.black87)),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 16),

                // Adults, Children, Rooms counter
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [

                      // Adults Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Adult',    style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.green), onPressed: () { if (adults > 1)   setState(() => adults--);   }),
                              Text('$adults',   style: TextStyle(fontSize: 16)),
                              IconButton(icon: Icon(Icons.add_circle_outline,    color: Colors.green), onPressed: () =>                  setState(() => adults++)),
                            ],
                          ),
                        ],
                      ),

                      // Children Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Children', style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.green), onPressed: () { if (children > 0) setState(() => children--); }),
                              Text('$children', style: TextStyle(fontSize: 16)),
                              IconButton(icon: Icon(Icons.add_circle_outline,    color: Colors.green), onPressed: () =>                  setState(() => children++)),
                            ],
                          ),
                        ],
                      ),

                      // Rooms Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rooms',    style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.green), onPressed: () { if (rooms > 1)    setState(() => rooms--);    }),
                              Text('$rooms',    style: TextStyle(fontSize: 16)),
                              IconButton(icon: Icon(Icons.add_circle_outline,    color: Colors.green), onPressed: () =>                  setState(() => rooms++)),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 24),

          // Search Hotel Button
          ElevatedButton(
            onPressed: searchHotel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Search Hotel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

        ],
      ),
    );
  }
}