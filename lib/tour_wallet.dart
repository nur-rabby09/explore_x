import 'package:flutter/material.dart';
import 'tour_plan.dart';
import 'tour_detail_page.dart';

class TourWalletPage extends StatefulWidget {
  final List<TourPlan> tourPlans;
  final Function(TourPlan) onAdd;
  TourWalletPage({required this.tourPlans, required this.onAdd});

  @override
  State<TourWalletPage> createState() => _TourWalletPageState();
}

class _TourWalletPageState extends State<TourWalletPage> {
  String destination = '';
  String groupBudget = '';
  String personName = '';
  List<String> people = ['You'];

  void openSheet() {
    destination = '';
    groupBudget = '';
    personName = '';
    people = ['You'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New Tour Plan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text('Destination'),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onChanged: (v) => destination = v,
                  ),
                  SizedBox(height: 12),
                  Text('Group Budget (BDT)'),
                  SizedBox(height: 6),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onChanged: (v) => groupBudget = v,
                  ),
                  SizedBox(height: 12),
                  Text('Add People'),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(border: OutlineInputBorder()),
                          onChanged: (v) => personName = v,
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          if (personName.trim().isNotEmpty) {
                            setSheetState(() => people.add(personName.trim()));
                          }
                        },
                        child: Text('Add', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: people.map((p) => Chip(label: Text(p))).toList(),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        if (destination.trim().isNotEmpty && groupBudget.trim().isNotEmpty) {
                          widget.onAdd(TourPlan(destination: destination.trim(), groupBudget: groupBudget.trim(), people: List.from(people)));
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Create Tour Plan', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Tour Wallet', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: widget.tourPlans.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text('No upcoming tours', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            SizedBox(height: 8),
            Text('Tap + to plan your first tour!', style: TextStyle(color: Colors.grey[400])),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: widget.tourPlans.length,
        itemBuilder: (context, index) {
          TourPlan plan = widget.tourPlans[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TourDetailPage(plan: plan),
                ),
              );
            },
            child: Container(
            margin: EdgeInsets.only(bottom: 14),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.destination, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Budget: BDT ${plan.groupBudget}', style: TextStyle(color: Colors.grey[700])),
                SizedBox(height: 6),
                Text('People: ${plan.people.join(', ')}', style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: openSheet,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}