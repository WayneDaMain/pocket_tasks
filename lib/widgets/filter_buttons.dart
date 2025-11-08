import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/screens/task_list_screen.dart';
import 'package:pocket_tasks/utils/enums.dart';

class FilterButtons extends ConsumerWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(filterProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: TaskFilter.values.map((filter) {
        final isSelected = filter == current;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text(filter.name.toUpperCase()),
            selected: isSelected,
            onSelected: (_) => ref.read(filterProvider.notifier).state = filter,
          ),
        );
      }).toList(),
    );
  }
}
