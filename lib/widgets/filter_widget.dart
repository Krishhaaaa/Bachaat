import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterWidget({super.key, required this.onFilterSelected});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedFilter = "price";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterButton("Price", "price"),
        _buildFilterButton("Time", "time"),
        _buildFilterButton("Rating", "rating"),
      ],
    );
  }

  Widget _buildFilterButton(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedFilter == value,
      onSelected: (selected) {
        setState(() {
          selectedFilter = value;
        });
        widget.onFilterSelected(value);
      },
    );
  }
}
