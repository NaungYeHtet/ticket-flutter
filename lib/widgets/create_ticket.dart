import 'package:flutter/material.dart';
import 'package:ticketing_system/config/size_config.dart';
import 'package:ticketing_system/style/style.dart';

import 'package:ticketing_system/utils/api_utils.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  createTicket(BuildContext context) async {
    final data = await ApiUtils.submitData(context, 'api/v1/tickets', {
      'title': titleController.text,
      'description': descriptionController.text
    });

    titleController.clear();
    descriptionController.clear();

    // ignore: use_build_context_synchronously
    showSnackbar(context, const Text('Ticket created.'));
  }

  void showSnackbar(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Do something when user presses the "Close" action button
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      child: PrimaryText(
                        text: 'Creat A Ticket',
                        size: 30.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: titleController,
                      decoration: _inputDecoration.copyWith(
                        hintText: 'Enter ticket title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: descriptionController,
                      decoration: _inputDecoration.copyWith(
                        hintText: 'description',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => {
                        if (_formKey.currentState!.validate())
                          {createTicket(context)}
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text("Create Ticket"))),
                    ),
                    const SizedBox(height: 40),
                  ],
                ))),
      ),
    );
  }
}

final _inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.blueGrey[50],
  labelStyle: const TextStyle(fontSize: 12),
  contentPadding: const EdgeInsets.only(left: 30),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueGrey),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueGrey),
    borderRadius: BorderRadius.circular(15),
  ),
);
