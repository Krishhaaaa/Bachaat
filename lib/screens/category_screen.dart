import 'package:bachaat/screens/map_selection_screen.dart';
import 'package:flutter/material.dart';
import '../models/result_model.dart';
import 'result_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase()),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Pickup field
            _inputField(
              controller: pickupController,
              label: "Pickup Location",
              icon: Icons.my_location,
            ),

            const SizedBox(height: 20),

            /// Destination field
            _inputField(
              controller: destinationController,
              label: "Destination",
              icon: Icons.location_on,
            ),

            const SizedBox(height: 40),

            /// Compare button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  final distance = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MapSelectionScreen(),
                    ),
                  );

                  print("Received distance: $distance");

                  if (distance == null) {
                    print("No distance received");
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(
                        category: widget.category,
                        value: distance,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Compare Prices",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
