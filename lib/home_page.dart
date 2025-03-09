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
  int? editingIndex;

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

  // Method that gives user ability to edit an existing plan
  void _editPlan(int index) {
    setState(() {
      planController.text = plans[index].plan;
      editingIndex = index;
    });
  }

  //Method that allows users to update edits for an existing plan
  void _updatePlan() {
    if (editingIndex != null && planController.text.isNotEmpty) {
      setState(() {
        plans[editingIndex!].plan = planController.text;
        editingIndex = null;
        planController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Interactive Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: planController,
              decoration: InputDecoration(
                hintText: 'Create Plan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addPlan,
                  child: const Text('Add Plan'),
                ),
                ElevatedButton(
                  onPressed: editingIndex != null ? _updatePlan : null,
                  child: const Text('Update Plan'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(plans[index].plan),
                      leading: Checkbox(
                        value: plans[index].completionStatus,
                        onChanged: (value) => _togglePlanCompletion(index),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editPlan(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deletePlan(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
          ],     
        ),
      ),
    );
    
  }
}

