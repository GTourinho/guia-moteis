import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final int activeFilters;

  const FilterButton({super.key, required this.activeFilters});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.tune, size: 12),
          const SizedBox(width: 4),
          const Text('filtros', style: TextStyle(fontSize: 12)),
          if (activeFilters > 0)
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: Text(
                activeFilters.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
        ],
      ),
      onSelected: (_) {
        // Show filter options
      },
    );
  }
}
