import 'package:flutter/material.dart';

class RequirementAddScreen extends StatefulWidget {
  const RequirementAddScreen({super.key});
  @override
  State<StatefulWidget> createState() => _RequirementAddScreen();
}

class _RequirementAddScreen extends State<RequirementAddScreen> {
  // _RequirementAddScreen() {
  //   selectedPayment = payment[1];
  // }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? selectedPayment = "";
  String? selectedRating = "";
  String? selectedProposalsSend = "";
  TextEditingController selectedPaymentController = TextEditingController();
  List<String> payment = ['Verified', 'UnVerified'];
  List<String> rating = ['1.0', '2.0', '3.0', '4.0', '5.0'];
  List<String> proposalsListSend = [
    'Less than 5',
    '5 to 10',
    '10 to 20',
    '20 to 30',
    '30 to 40',
    '50+'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Requirement'),
        backgroundColor: Colors.orangeAccent,
        shadowColor: Colors.black,
        toolbarHeight: 60.60,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25.5),
        foregroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Description';
                  } else if (value.length < 10) {
                    return 'Please enter a Description that contains 10 words or greter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width / 2 + 3,
                    initialSelection: selectedPayment,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    label: const Text('Select Payment'),
                    onSelected: (String? payment) {
                      setState(() {
                        selectedPayment = payment ?? "";
                      });
                    },
                    dropdownMenuEntries: payment
                        .map<DropdownMenuEntry<String>>((String payment) {
                      return DropdownMenuEntry<String>(
                        value: payment,
                        label: payment,
                        style: MenuItemButton.styleFrom(
                          foregroundColor:
                              selectedPayment == payment ? Colors.amber : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 8),
                  DropdownMenu<String>(
                    initialSelection: selectedRating,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    label: const Text('Client Rating'),
                    onSelected: (String? rating) {
                      setState(() {
                        selectedRating = rating ?? "";
                      });
                    },
                    dropdownMenuEntries:
                        rating.map<DropdownMenuEntry<String>>((String rating) {
                      return DropdownMenuEntry<String>(
                        value: rating,
                        label: rating,
                        style: MenuItemButton.styleFrom(
                          foregroundColor:
                              selectedRating == rating ? Colors.amber : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Project Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter project price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width/2+100,
                    initialSelection: selectedProposalsSend,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    label: const Text('Poposals Send'),
                    onSelected: (String? propSend) {
                      setState(() {
                        selectedProposalsSend = propSend ?? "";
                      });
                    },
                    dropdownMenuEntries: proposalsListSend
                        .map<DropdownMenuEntry<String>>((String propSend) {
                      return DropdownMenuEntry<String>(
                        value: propSend,
                        label: propSend,
                        style: MenuItemButton.styleFrom(
                          foregroundColor: selectedProposalsSend == propSend
                              ? Colors.amber
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, process the data
                    String name = _nameController.text;
                    String email = _descriptionController.text;
                    String country = _countryController.text;
                    String price = _priceController.text;

                    // Do something with the form data
                    print('Name: $name, Email: $email, country : $country');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
