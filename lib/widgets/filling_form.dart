import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/extensions.dart';
import 'package:iron_byte/core/reg_exp.dart';
import 'package:iron_byte/core/theme/app_theme.dart';

class FillingForm extends StatefulWidget {
  const FillingForm({super.key});

  @override
  State<FillingForm> createState() => _FillingFormState();
}

class _FillingFormState extends State<FillingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    emailController.dispose();
    messageController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: RichText(
              softWrap: true,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Contact Us \n',
                    style: context.displayLarge!.copyWith(
                      fontSize: 35,
                      color: AppColors.dirtyWhite,
                    ),
                  ),
                  TextSpan(
                    text: 'OR \n',
                    style: context.displayLarge!.copyWith(
                      fontSize: 35,
                      color: AppColors.dirtyWhite,
                      height: 1.8,
                    ),
                  ),
                  TextSpan(
                    text: 'Get Free Consultation \n',
                    style: context.displayLarge!.copyWith(
                      fontSize: 45,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrangeAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                floatingLabelStyle: TextStyle(color: Colors.deepOrangeAccent),
                focusColor: Colors.deepOrangeAccent,
                filled: true,
                fillColor: AppColors.teal,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                labelText: 'Contact Email',
                hintText: 'example@email.com',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!fillingFormValidation.hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
          ),

          const Gap(32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                filled: true,
                floatingLabelStyle: TextStyle(color: Colors.deepOrangeAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrangeAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                fillColor: AppColors.teal,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                labelText: 'Message',
                hintText: 'Write your message here...',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Message cannot be empty';
                }
                return null;
              },
            ),
          ),
          const Gap(32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(), // prevent past dates
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                    dateController.text =
                        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.teal,
                ),
                padding: EdgeInsets.all(12),
                width: context.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Check for Availabale Dates', style: context.titleM),
                    Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ),
          ),

          const Gap(32),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 48),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint('Email: ${emailController.text}');
                  debugPrint('Message: ${messageController.text}');
                }
              },
              child: Text('Send', style: context.titleM),
            ),
          ),
        ],
      ),
    );
  }
}
