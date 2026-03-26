class Spending {
  String label;
  double amount;

  Spending({required this.label, required this.amount});
}

class TourPlan {
  String destination;
  String groupBudget;
  List<String> people;
  List<Spending> spendings;

  TourPlan({
    required this.destination,
    required this.groupBudget,
    required this.people,
  }) : spendings = [];

  double get totalSpent {
    double total = 0;
    for (Spending s in spendings) {
      total = total + s.amount;
    }
    return total;
  }

  double get remainingBudget {
    double budget = double.tryParse(groupBudget) ?? 0;
    return budget - totalSpent;
  }
}