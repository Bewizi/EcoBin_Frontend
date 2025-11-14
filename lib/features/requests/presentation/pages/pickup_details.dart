import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PickupDetails extends StatefulWidget {
  const PickupDetails({super.key});

  static const String routeName = '/pickupDetails';

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _pickupDate = TextEditingController();
  final TextEditingController _pickupTime = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _pickupDate.text = DateFormat('MM dd, yyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _pickupTime.text = picked.format(context);
      });
    }
  }

  @override
  void dispose() {
    _pickupDate.dispose();
    _pickupTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        backgroundColor: AppColors.kTransparent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Pickup Details',
                fontWeight: FontWeight.w500,
                color: AppColors.kRaisinBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Let us know where and when to pick up your\nwaste. This helps us plan accordingly.',
                fontWeight: FontWeight.w500,
                color: AppColors.kPayneGray,
              ),

              SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppField(
                              hintText: '03, Adekunmi Estate, Ojota Lago... ',
                              title: 'Pickup Address',
                              prefixIcons: SvgPicture.asset(
                                AppSvgs.kGPS,
                                width: 20,
                                height: 20,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            SizedBox(height: 12),
                            InkWell(
                              child: TextRegular(
                                'Change Location',
                                color: AppColors.kPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.kPrimary,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),

                        SizedBox(height: 37),

                        Row(
                          children: [
                            Expanded(
                              child: AppField(
                                hintText: 'Pick A Date',
                                title: 'Pickup Date',
                                controller: _pickupDate,
                                keyboardType: TextInputType.datetime,
                                prefixIcons: Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context),
                              ),
                            ),

                            SizedBox(width: 22),

                            Expanded(
                              child: AppField(
                                hintText: 'Pick A Time',
                                title: 'Pickup Time',
                                controller: _pickupTime,
                                keyboardType: TextInputType.datetime,
                                prefixIcons: Icon(Icons.access_time, size: 20),
                                readOnly: true,
                                onTap: () => _selectTime(context),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 37),

                        AppField(
                          hintText: 'Comment',
                          title: 'Additional Note',
                          maxLines: 5,
                          minLines: 5,
                        ),

                        // Spacer(),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * (101 / 640),
                        ),

                        // button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomButton(
                              title: 'Schedule Pickup',
                              isDisabledBorder: false,
                              bgColor: AppColors.kTransparent,
                              onTap: () {},
                              textColor: AppColors.kPrimary,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(height: 20),

                            CustomButton(
                              title: 'Confirm Pickup',
                              isDisabledBorder: false,
                              bgColor: AppColors.kPrimary,
                              onTap: () {},
                              textColor: AppColors.kWhite,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
