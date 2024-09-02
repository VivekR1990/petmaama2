import 'package:flutter/material.dart';
import 'package:petmaama/api_functions/api_functions.dart';
import 'package:petmaama/model/attributes_model.dart';

class AttributeSelectionDialog extends StatefulWidget {
  final String petId;
  final Function(List<Map<String, dynamic>>) onSelected;

  const AttributeSelectionDialog({
    super.key,
    required this.petId,
    required this.onSelected,
  });

  @override
  AttributeSelectionDialogState createState() =>
      AttributeSelectionDialogState();
}

class AttributeSelectionDialogState extends State<AttributeSelectionDialog> {
  List<Attribute> availableAttributes = [];
  Map<String, dynamic> attributeValues = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttributes();
  }

  void _fetchAttributes() async {
    try {
      final petStructureResponse = await Api.getPetStructure(widget.petId);

      if (petStructureResponse.isEmpty) {
        throw Exception('Empty Response');
      }

      final petDetails = PetDetails.fromRawJson(petStructureResponse);
      setState(() {
        availableAttributes = petDetails.petStructure.attributes;
        isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load attributes. Error: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  
  Widget _buildAttributeInput(Attribute attribute) {
    switch (attribute.fieldType) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(
            labelText: attribute.name,
            errorText: attribute.required &&
                    (attributeValues[attribute.id] == null ||
                        attributeValues[attribute.id].isEmpty)
                ? 'This field is required'
                : null,
          ),
          onChanged: (value) {
            setState(() {
              attributeValues[attribute.id] = value;
            });
          },
        );
      case 'number':
        return TextFormField(
          decoration: InputDecoration(
            labelText: attribute.name,
            errorText: attribute.required &&
                    (attributeValues[attribute.id] == null ||
                        attributeValues[attribute.id].isEmpty)
                ? 'This field is required'
                : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              attributeValues[attribute.id] = value;
            });
          },
        );
      case 'select':
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: attribute.name,
            errorText:
                attribute.required && attributeValues[attribute.id] == null
                    ? 'This field is required'
                    : null,
          ),
          value: attributeValues[attribute.id],
          items: attribute.possibleValues.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              attributeValues[attribute.id] = value;
            });
          },
        );
      default:
        return CheckboxListTile(
          title: Text(attribute.name),
          value: attributeValues[attribute.id] == true,
          onChanged: (bool? value) {
            setState(() {
              attributeValues[attribute.id] = value;
            });
          },
        );
    }
  }

  bool _validateInputs() {
    bool isValid = true;
    for (var attribute in availableAttributes) {
      if (attribute.required) {
        if (attributeValues[attribute.id] == null ||
            (attribute.fieldType == 'text' &&
                attributeValues[attribute.id].isEmpty) ||
            (attribute.fieldType == 'number' &&
                attributeValues[attribute.id].isEmpty) ||
            (attribute.fieldType == 'select' &&
                attributeValues[attribute.id] == null)) {
          isValid = false;
          break;
        }
      }
    }
    return isValid;
  }

  @override

  Widget build(BuildContext context) {
    print(
        'AttributeSelectionDialogState.build: isLoading: $isLoading, availableAttributes: ${availableAttributes.length}');
    return AlertDialog(
      title: const Text('Select Attributes'),
      content: isLoading
          ? const Center(child: CircularProgressIndicator())
          : availableAttributes.isNotEmpty
              ? LayoutBuilder(
                  builder: (ctx, constraints) {
                    print(
                        'AttributeSelectionDialogState.build: availableAttributes: ${availableAttributes.length}');
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: availableAttributes.map((attribute) {
                          return _buildAttributeInput(attribute);
                        }).toList(),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No attributes available.')),
      actions: [
        TextButton(
          onPressed: () {
            print('AttributeSelectionDialogState.build: Cancel button pressed');
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            print('AttributeSelectionDialogState.build: OK button pressed');
            if (_validateInputs()) {
              print(
                  'AttributeSelectionDialogState.build: Validation successful');
              List<Map<String, dynamic>> selectedAttributes =
                  availableAttributes
                      .where(
                          (attribute) => attributeValues[attribute.id] != null)
                      .map((attribute) => {
                            "id": attribute.id,
                            "name": attribute.name,
                            "value": attributeValues[attribute.id],
                            "fieldType": attribute.fieldType,
                          })
                      .toList();
              if (mounted) {
                print(
                    'AttributeSelectionDialogState.build: selectedAttributes: ${selectedAttributes.length}');
                widget.onSelected(selectedAttributes);
                Navigator.of(context).pop();
              }
            } else {
              print('AttributeSelectionDialogState.build: Validation failed');
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please fill in all required fields.')),
                );
              }
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
