import 'package:app/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/constants.dart';
import '../config/mock_data.dart';
import '../models/serializers/workout.dart';
import 'workout_page.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  List<Workout> workoutlist = [];
  final WorkoutModel _model = WorkoutModel();

  TextEditingController name = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await loadData();
    });
    super.initState();
  }

  loadData() async {
    // mockdata
    await _model.loadWorkout();
    if (mounted) {
      setState(() {
        workoutlist = _model.getWorkoutList;
      });
    }
  }

  createWorkout() async {
    // Validation
    try {
      if (name.text.isNotEmpty) {
        Workout newWorkout = await _model.addNewWorkout(name.text);
        if (mounted) {
          setState(() {
            workoutlist = _model.getWorkoutList;
          });
        }
      } else {
        //  Error Message
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  createnewDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New workout',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextField(
                  key: addworkoutTextkey,
                  autofocus: true,
                  controller: name,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  ),
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await createWorkout();
                    Navigator.of(context).maybePop();
                  },
                  child: const Text('Create'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDat(DateTime? date) {
    return (date != null) ? DateFormat('yyyy-MM-dd').format(date) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: workoutlist.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              enableFeedback: true,
              leading: const Icon(Icons.fitness_center, size: 28),
              minLeadingWidth: 10,
              key: ValueKey('workout$index'),
              trailing: Text(
                '${workoutlist[index].sets.length} Sets',
                style: const TextStyle(color: Colors.green),
              ),
              subtitle: Text(formatDat(workoutlist[index].date)),
              title: Text("${workoutlist[index].name}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutPage(workout: workoutlist[index]),
                  ),
                );
              },
            );
          }),
    );
  }
}
