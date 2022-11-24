import 'package:flutter/material.dart';

import '../models/serializers/workout.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  const WorkoutPage({super.key, required this.workout});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final Workout wk = widget.workout;
    return Scaffold(
      appBar: AppBar(title: Text(wk.name ?? '')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: wk.sets.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              enableFeedback: true,
              leading: const Icon(Icons.sports, size: 28),
              minLeadingWidth: 10,
              key: ValueKey('set$index'),
              trailing: Text(
                '${wk.sets[index].reps} reps',
                style: const TextStyle(color: Colors.green),
              ),
              subtitle: Text('${wk.sets[index].weight} Kg'),
              title: Text(wk.sets[index].exercise.value),
            );
          }),
    );
  }
}
