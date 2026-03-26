import 'package:flutter/material.dart';
import 'tour_plan.dart';

class TourDetailPage extends StatefulWidget {
  final TourPlan plan;

  TourDetailPage({required this.plan});

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  String spendingLabel = '';
  String spendingAmount = '';

  void openAddSpendingSheet() {
    spendingLabel = '';
    spendingAmount = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Spending',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('What was it for'),
              SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (v) {
                  spendingLabel = v;
                },
              ),
              SizedBox(height: 12),
              Text('Amount in BDT'),
              SizedBox(height: 6),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (v) {
                  spendingAmount = v;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    double? amount = double.tryParse(spendingAmount.trim());
                    if (spendingLabel.trim().isNotEmpty && amount != null) {
                      setState(() {
                        widget.plan.spendings.add(
                          Spending(
                            label: spendingLabel.trim(),
                            amount: amount,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TourPlan plan = widget.plan;
    double budget = double.tryParse(plan.groupBudget) ?? 0;
    bool isOverBudget = plan.remainingBudget < 0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          plan.destination,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Budget'),
                    Text('BDT ' + budget.toStringAsFixed(2)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Spent'),
                    Text(
                      'BDT ' + plan.totalSpent.toStringAsFixed(2),
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'BDT ' + plan.remainingBudget.toStringAsFixed(2),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isOverBudget ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
                if (isOverBudget)
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'You have gone over budget',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: plan.spendings.isEmpty
                ? Center(
              child: Text(
                'No spendings added yet',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: plan.spendings.length,
              itemBuilder: (context, index) {
                Spending s = plan.spendings[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s.label, style: TextStyle(fontSize: 15)),
                      Text(
                        'BDT ' + s.amount.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: openAddSpendingSheet,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}