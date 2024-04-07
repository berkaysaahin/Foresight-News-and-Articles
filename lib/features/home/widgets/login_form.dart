import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/rectangle_rounded_button.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email
  String _password = '';

  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      print('Name: $_name'); // Print the name
      print('Email: $_email'); // Print the email
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Associate the form key with this Form widget
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: AppColors.black08,
              decoration: const InputDecoration(
                  hoverColor: AppColors
                      .osloGray, // Color when hovering over the input field
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors
                            .osloGray), // Color of the underline when not focused
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors
                            .osloGray), // Color of the underline when focused
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: AppColors.black08)), // Label for the name field
              validator: (value) {
                // Validation function for the name field
                if (value!.isEmpty) {
                  return 'Please enter your name.'; // Return an error message if the name is empty
                }
                return null; // Return null if the name is valid
              },
              onSaved: (value) {
                _name = value!; // Save the entered name
              },
            ),
            const SizedBox(height: 5.0),
            TextFormField(
              cursorColor: AppColors.black08,

              decoration: const InputDecoration(
                hoverColor: AppColors
                    .osloGray, // Color when hovering over the input field
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors
                          .osloGray), // Color of the underline when not focused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.osloGray),
                  // Color of the underline when focused
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: AppColors.black08),
              ), // Label for the email field
              validator: (value) {
                // Validation function for the email field
                if (value!.isEmpty) {
                  return 'Please enter your email.'; // Return an error message if the email is empty
                }
                // You can add more complex validation logic here
                return null; // Return null if the email is valid
              },
              onSaved: (value) {
                _email = value!; // Save the entered email
              },
            ),
            const SizedBox(height: 5.0),
            TextFormField(
              cursorColor: AppColors.black08,

              decoration: const InputDecoration(
                hoverColor: AppColors
                    .osloGray, // Color when hovering over the input field
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors
                          .osloGray), // Color of the underline when not focused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.osloGray),
                  // Color of the underline when focused
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: AppColors.black08),
              ), // Label for the email field
              validator: (value) {
                // Validation function for the email field
                if (value!.isEmpty) {
                  return 'Please enter your password.'; // Return an error message if the email is empty
                }
                // You can add more complex validation logic here
                return null; // Return null if the email is valid
              },
              onSaved: (value) {
                _password = value!; // Save the entered email
              },
            ),
            const SizedBox(height: 20.0),
            RectangleRoundedButton(
                onTap: () {
                  _submitForm();
                },
                buttonText: "Submit"),
          ],
        ),
      ),
    );
  }
}