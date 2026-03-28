import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/reg_exp.dart';
import 'package:iron_byte/core/utils/sizes.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final horizontalPadding = isMobile ? 16.0 : 24.0;

        // Reduce typography/gaps on smaller screens to avoid vertical overflow.
        final titleFontSmall = isMobile ? 28.0 : 35.0;
        final titleFontLarge = isMobile ? 36.0 : 45.0;
        final verticalGap = isMobile ? 16.0 : 32.0;

        final form = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: verticalGap),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile
                      ? AppSpacing.padding16
                      : AppSpacing.padding24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.tealLight.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Contact Us \n',
                        style: context.displayLarge!.copyWith(
                          fontSize: titleFontSmall,
                          color: AppColors.dirtyWhite,
                        ),
                      ),
                      TextSpan(
                        text: 'OR \n',
                        style: context.displayLarge!.copyWith(
                          fontSize: titleFontSmall,
                          color: AppColors.dirtyWhite,
                          height: 1.8,
                        ),
                      ),
                      TextSpan(
                        text: 'Get Free Consultation',
                        style: context.displayLarge!.copyWith(
                          fontSize: titleFontLarge,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? AppSpacing.padding16 : AppSpacing.padding24,
                ),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrangeAccent,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.deepOrangeAccent,
                    ),
                    focusColor: Colors.deepOrangeAccent,
                    filled: true,
                    fillColor: AppColors.teal,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
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
              SizedBox(height: verticalGap),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: TextFormField(
                  controller: messageController,
                  maxLines: isMobile ? 4 : 5,
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
              SizedBox(height: verticalGap),

              // Date selector is the main overflow hotspot in the original code.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: LayoutBuilder(
                  builder: (context, dateConstraints) {
                    final dateWidth = dateConstraints.maxWidth;
                    final compact = dateWidth < 360;

                    return GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 365)),
                        );

                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                            dateController.text =
                                '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity, // Important: obey constraints.
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.teal,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: compact
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Check for Available Dates',
                                    style: context.titleM,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.calendar_month),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Check for Available Dates',
                                      style: context.titleM,
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.calendar_month),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: verticalGap),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.deepOrange),
                    minimumSize: WidgetStateProperty.all(
                      Size(double.infinity, 48),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Replace debug prints with actual submission logic later.
                      debugPrint('Email: ${emailController.text}');
                      debugPrint('Message: ${messageController.text}');
                      debugPrint('Date: ${dateController.text}');
                    }
                  },
                  child: Text('Send', style: context.titleM),
                ),
              ),

              // Extra bottom padding for very small screens (prevents clipping).
              if (isMobile) const SizedBox(height: 24),
              if (isMobile) const Gap(0),
            ],
          ),
        );

        // On narrow layouts, ensure the form remains scrollable vertically.
        // HomeScreen also scrolls, but keeping this safe prevents clipped/overflowed widgets.
        return isMobile
            ? SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: form,
              )
            : form;
      },
    );
  }
}

