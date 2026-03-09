import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/reg_exp.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'dart:io';

class ApplicationFillingForm extends StatefulWidget {
  const ApplicationFillingForm({super.key});

  @override
  State<ApplicationFillingForm> createState() => _ApplicationFillingFormState();
}

class _ApplicationFillingFormState extends State<ApplicationFillingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  File? cvFile;
  File? motivationLetterFile;

  @override
  void dispose() {
    emailController.dispose();
    messageController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> pickFile({required bool isCv}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isCv) {
          cvFile = File(result.files.single.path!);
        } else {
          motivationLetterFile = File(result.files.single.path!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSpacing.padding32),
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
                      height: 1.9,
                    ),
                  ),
                  TextSpan(
                    text: 'We want to know more about you \n',
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
                labelText: 'Cover letter',
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
              onTap: () => pickFile(isCv: true),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cvFile == null ? 'Upload CV' : 'CV Selected',
                      style: context.titleM,
                    ),
                    const Icon(Icons.upload_file),
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
