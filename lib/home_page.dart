
import 'package:flutter/material.dart';

//Class with plans and completion status
class Plans {
  String plan;
  bool completionStatus;
  Plans({required this.plan, required this.completionStatus});
}

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  State<PlanManagerScreen> createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {

  //initialized an empty list of plans that user can add to
  List<Plans> plans = List.empty(growable: true);

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