import 'package:app/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/empty_state.dart';
import '../config/constants.dart';
import '../models/serializers/workout.dart';
import 'workout_page.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  createWorkout() async {
    // Validation
    try {
      if (nameController.text.isNotEmpty) {
        await Provider.of<WorkoutModel>(context, listen: false)
            .addNewWorkout(nameController.text);
        nameController.text = '';
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
                  key: kaddworkoutTextkey,
                  autofocus: true,
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: kaddWorkoutSubmitButton,
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  ),
                  onPressed: () async {
                    // if (mounted) FocusManager.instance.primaryFocus?.unfocus();
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

  String formatDate(DateTime? date) {
    return (date != null) ? DateFormat('dd MMM').format(date) : '';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        key: kaddNewWorkoutButton,
        onPressed: createnewDialog,
        child: const Icon(Icons.add),
      ),
      body: Consumer<WorkoutModel>(builder: (context, WorkoutModel data, __) {
        return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: data.getWorkoutList.length,
            itemBuilder: (BuildContext context, int index) {
              if (data.getWorkoutList.isEmpty) return const EmptyState();
              return ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.fitness_center, size: 28),
                minLeadingWidth: 10,
                key: ValueKey('workout$index'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await data.deleteWorkout(data.getWorkoutList[index]);
                  },
                ),
                title: Text("${data.getWorkoutList[index].name}"),
                subtitle: Text(
                    '${data.getWorkoutList[index].sets.length} Sets on ${formatDate(data.getWorkoutList[index].date)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WorkoutPage(workout: data.getWorkoutList[index]),
                    ),
                  );
                },
              );
            });
      }),
    );
  }
}
