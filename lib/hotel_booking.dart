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

  int adults   = 1;
  int children = 0;
  int rooms    = 1;


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
        SnackBar(content: Text('Please fill the form')),
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

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextField(
                  controller: hotelName,
                  decoration: InputDecoration(
                    labelText: 'Hotel Name',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),

                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => pickDate('checkin'),
                        icon: Icon(Icons.calendar_month, color: Colors.green, size: 18),
                        label: Text(checkInDate, style: TextStyle(color: Colors.black),),
                      ),
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => pickDate('checkout'),
                        icon: Icon((Icons.calendar_month), color: Colors.green, size: 18,),
                        label: Text(checkOutDate, style: TextStyle(color: Colors.black87)),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Adult',    style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.green),
                                  onPressed: () { if (adults > 1)   setState(() => adults--);   }),

                              Text('$adults',   style: TextStyle(fontSize: 16)),

                              IconButton(icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green),
                                  onPressed: () => { if (adults < 6)   setState(() => adults++) }),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rooms',    style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.green),
                                  onPressed: () { if (rooms > 1)  setState(() => rooms--);    }),

                              Text('$rooms',    style: TextStyle(fontSize: 16)),

                              IconButton(icon: Icon(Icons.add_circle_outline,
                                  color: Colors.green), onPressed: () =>
                                  setState(() => rooms++)),
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