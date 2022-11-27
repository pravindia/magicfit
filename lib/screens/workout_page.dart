import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/empty_state.dart';
import '../config/constants.dart';
import '../models/serializers/workout.dart';
import '../models/serializers/workout_set.dart';
import '../models/workout_model.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  const WorkoutPage({super.key, required this.workout});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    repsController.dispose();
    super.dispose();
  }

  Future<bool> createWorkoutSet() async {
    if (nameController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        repsController.text.isNotEmpty &&
        int.tryParse(weightController.text) != null &&
        int.tryParse(repsController.text) != null) {
      try {
        var json = {
          'exercise': nameController.text,
          'weight': weightController.text,
          'reps': repsController.text,
        };
        await Provider.of<WorkoutModel>(context, listen: false)
            .addWorkoutSet(widget.workout.id, WorkoutSet.fromJson(json));
        nameController.text = '';
        weightController.text = '';
        repsController.text = '';
        return true;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    }
    return false;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var element in ExerciseType.values) {
      menuItems.add(DropdownMenuItem(
        value: element.value,
        child: Text(element.value),
      ));
    }
    return menuItems;
  }

  createnewDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 16,
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Set',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text("Workout Type"),
                  key: kaddnameKey,
                  items: dropdownItems,
                  onChanged: (String? value) {
                    //
                    if (value != null && value.isNotEmpty) {
                      nameController.text = value;
                    }
                  },
                ),
                TextFormField(
                  key: kaddweightKey,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight Used'),
                ),
                TextField(
                  key: kaddrepsKey,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  controller: repsController,
                  decoration: const InputDecoration(labelText: 'Repetitions'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: kaddWorkoutSetSubmitButton,
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  ),
                  onPressed: () async {
                    // if (mounted) FocusManager.instance.primaryFocus?.unfocus();
                    if (await createWorkoutSet()) {
                      Navigator.of(context).maybePop();
                    }
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

  @override
  Widget build(BuildContext context) {
    final Workout wk = widget.workout;

    return Scaffold(
      appBar: AppBar(title: Text(wk.name ?? '')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          await createnewDialog();
          //
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<WorkoutModel>(builder: (context, WorkoutModel model, __) {
        return ListView.builder(
            itemCount: wk.sets.length,
            itemBuilder: (BuildContext context, int index) {
              if (wk.sets.isEmpty) return const EmptyState();
              return ListTile(
                enableFeedback: false,
                leading: const Icon(Icons.sports, size: 28),
                minLeadingWidth: 10,
                key: ValueKey('set$index'),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await model.deleteWorkoutSet(wk.id, wk.sets[index]);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                title: Text(wk.sets[index].exercise.value),
                subtitle: Text(
                    '${wk.sets[index].weight} Kg / ${wk.sets[index].reps} reps',
                    style: const TextStyle(color: Colors.amber)),
              );
            });
      }),
    );
  }
}
