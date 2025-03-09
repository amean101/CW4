
import 'package:flutter/material.dart';

//Class with plans and completion status
class Plans {
  String plan;
  bool completionStatus;
  Plans(this.plan, {this.completionStatus = false});
}

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  State<PlanManagerScreen> createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {

  //initialized an empty list of plans that user can add to
  final TextEditingController planController = TextEditingController();
  final List<Plans> plans = [];

  //Method that adds plan
  void _addPlan() {
    if (planController.text.isNotEmpty) {
      setState(() {
        plans.add(Plans(planController.text));
        planController.clear();
      });
    }
  }

  //Method that toggles plan completion
  void _togglePlanCompletion(int index) {
    setState(() {
      plans[index].completionStatus = !plans[index].completionStatus;
    });
  }
  
  //Method that removes the plan
  void _deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Calendar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(
              hintText: 'Add Plan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),)
          ],
        ),
         ),
    );
  }
}