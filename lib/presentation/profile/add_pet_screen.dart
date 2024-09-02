import 'package:flutter/material.dart';
import 'package:petmaama/api_functions/api_functions.dart';
import 'package:petmaama/model/add_pet_model.dart';
import 'package:petmaama/presentation/profile/attribute_selection_dialog.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  AddPetPageState createState() => AddPetPageState();
}

class AddPetPageState extends State<AddPetPage> {
  String? selectedPetType;
  List<Pet> availablePets = [];
  List<Map<String, dynamic>> selectedAttributes = [];

  @override

  /// Initializes the state of the widget by calling the superclass's `initState` method and fetching the list of pet types.
  /// 
  /// This function does not take any parameters and does not return any value.
  void initState() {
    super.initState();
    _fetchPetTypes();
  }

  // Fetch the list of pets and store them in availablePets
  /// Fetches the list of pet types from the server and updates the state with the fetched data.
  ///
  /// This function makes an asynchronous call to the `Api.getAddPet()` function to retrieve the list of pet types.
  /// The response is then parsed into an `Addpet` object using the `Addpet.fromRawJson()` function.
  /// The `availablePets` list is updated with the fetched pet types.
  ///
  /// If an error occurs during the fetch, a `SnackBar` is shown with the error message.
  ///
  /// This function does not take any parameters and does not return any value.
   void _fetchPetTypes() async {
    try {
      String petResponse = await Api.getAddPet();
      Addpet addpet = Addpet.fromRawJson(petResponse);
      if (mounted) {
        setState(() {
          availablePets = addpet.pets;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load pet types. Please try again.')),
        );
      }
    }
  }

  // Show the attribute selection dialog based on the selected pet type
  /// Shows the attribute selection dialog based on the selected pet type.
  /// 
  /// This function checks if a pet type has been selected. If a pet type is selected, 
  /// it attempts to find the corresponding pet ID and show the attribute selection dialog.
  /// 
  /// If the pet ID is found, the dialog is shown with the pet ID. If not, a SnackBar is 
  /// shown with an error message. If an error occurs during the process, a SnackBar is 
  /// shown with an error message. If no pet type is selected, a SnackBar is shown with 
  /// a message prompting the user to select a pet type first.
  /// 
  /// This function does not take any parameters and does not return any value.
  void _showAttributesInputDialog() async {
    if (selectedPetType != null) {
      try {
        // Get the pet ID for the selected pet type
        Pet? selectedPet = availablePets.firstWhere(
          (pet) => pet.name == selectedPetType,
          orElse: () => Pet(id: '', name: ''),  // Return a default Pet instead of null
        );

        if (selectedPet.id.isNotEmpty) {
          // Show the dialog and pass the pet ID to fetch attributes within the dialog
          showDialog(
            context: context,
            builder: (context) {
              return AttributeSelectionDialog(
                petId: selectedPet.id,
                onSelected: (selected) {
                  setState(() {
                    selectedAttributes = selected;
                  });
                },
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pet type not found. Please select a valid pet type.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to show attribute dialog. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a pet type first.')),
      );
    }
  }

  @override
  /// 
  /// Builds the UI for the add pet screen, including the app bar, pet type dropdown, 
  /// and a list view to display selected attributes.
  /// 
  /// Parameters:
  ///   `context` - The `BuildContext` for this widget.
  /// 
  /// Returns:
  ///   A `Widget` representing the add pet screen.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: const Text('Select Pet Type'),
            value: selectedPetType,
            onChanged: (String? newValue) {
              setState(() {
                selectedPetType = newValue;
                selectedAttributes = []; // Clear previous attributes when changing pet type
              });
              _showAttributesInputDialog();
            },
            items: availablePets.map<DropdownMenuItem<String>>((Pet pet) {
              return DropdownMenuItem<String>(
                value: pet.name,
                child: Text(pet.name),
              );
            }).toList(),
          ),
          // Display selected attributes in a ListView
          Expanded(
            child: ListView.builder(
              itemCount: selectedAttributes.length,
              itemBuilder: (context, index) {
                final attribute = selectedAttributes[index];
                return ListTile(
                  title: Text(attribute['name']),
                  subtitle: Text('Value: ${attribute['value']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}