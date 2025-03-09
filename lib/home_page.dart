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
  Map<String, List<Plans>> weeklyTasks = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };

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
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: plans.length,
                      itemBuilder: (context, index) {
                        return Draggable<Plans>(
                          data: plans[index],
                          feedback: Material(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.blueGrey,
                              child: Text(plans[index].plan,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          childWhenDragging: Card(
                            child: ListTile(
                              title: Text(plans[index].plan,
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          child: Card(
                            color: plans[index].completionStatus ? Colors.green[200] : null,
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
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: weeklyTasks.keys.map((day) {
                      return DragTarget<Plans>(
                        onAccept: (plan) {
                          setState(() {
                            weeklyTasks[day]!.add(plan);
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ...weeklyTasks[day]!.map((task) => Text(task.plan)).toList(),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
