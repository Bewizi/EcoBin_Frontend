import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/requests/presentation/pages/pickup_details.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/waste_type_bloc.dart';
import 'package:ecobin/features/requests/presentation/widgets/waste_items_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class OrganicWasteDetails extends StatefulWidget {
  final String id;
  const OrganicWasteDetails({super.key, required this.id});
  static const String routeName = '/organicWasteDetails';

  @override
  State<OrganicWasteDetails> createState() => _OrganicWasteDetailsState();
}

class _OrganicWasteDetailsState extends State<OrganicWasteDetails> {
  final List<Map<String, String>> reasons = [
    {'icon': AppSvgs.kShopeefoodDriver, 'text': 'Fruit and Vegetable Peels'},
    {'icon': AppSvgs.kTissuePaper, 'text': 'Coffee Grounds and Tea Bags'},
    {'icon': AppSvgs.kDamageMap, 'text': 'Eggshells'},
    {'icon': AppSvgs.kClothesOutline, 'text': 'Yard Waste'},
    {'icon': AppSvgs.kLucideHouse, 'text': 'All kind of organic waste'},
  ];

  List<bool> chekedList = [];

  bool get isAnyChecked => chekedList.any((isChecked) => isChecked);

  String? _loadedId;

  @override
  void didUpdateWidget(covariant OrganicWasteDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if id changed from the parent, fetch the new category
    if (oldWidget.id != widget.id) {
      context.read<WasteTypeBloc>().add(GetWasteCategoryByIdEvent(widget.id));
      _loadedId = widget.id;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // When the dependencies are ready and provider is available, request
    // the waste category by id. Avoid re-fetching if it's already loaded.
    if (_loadedId != widget.id) {
      _loadedId = widget.id;
      context.read<WasteTypeBloc>().add(GetWasteCategoryByIdEvent(widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool buttonActive = isAnyChecked;
    return Scaffold(
      appBar: AppBar(leading: AppBackButton()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Organic Waste Details',
                fontWeight: FontWeight.w500,
                color: AppColors.kRaisinBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Help us understand what you\'re disposing of\nso we can come prepared with the right tools\nand team',
                fontWeight: FontWeight.w500,
                color: AppColors.kPayneGray,
              ),
              SizedBox(height: 40),

              BlocConsumer<WasteTypeBloc, WasteTypeState>(
                listener: (context, state) {
                  if (state is WasteTypeLoadId) {
                    // initialize checked list for this category's items so
                    // checkbox state stays consistent
                    final count = state.category.items.length;
                    setState(() {
                      chekedList = List.generate(count, (_) => false);
                    });
                    return;
                  }

                  if (state is WasteTypeError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is WasteTypeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is WasteTypeLoadId) {
                    final category = state.category;
                    return WasteItemsSelector(
                      items: category.items,
                      onSelectionChanged: (selectedIndices) {
                        setState(() {
                          // update checked list based on selected indices
                          chekedList = List.generate(
                            category.items.length,
                            (index) => selectedIndices.contains(index),
                          );
                        });
                      },
                    );
                  } else if (state is WasteTypeError) {
                    return TextRegular(
                      'Error: ${state.message}',
                      color: AppColors.kError500,
                    );
                  } else {
                    return TextRegular(
                      'No data available.',
                      color: AppColors.kPayneGray,
                    );
                  }
                },
              ),

              Spacer(),

              Expanded(
                child: Column(
                  children: [
                    CustomButton(
                      title: 'Next',
                      bgColor: buttonActive
                          ? AppColors.kPrimary
                          : AppColors.kHoneydew,
                      textColor: buttonActive
                          ? AppColors.kWhite
                          : AppColors.kTealDeer,
                      onTap: (buttonActive)
                          ? () {
                              context.push(PickupDetails.routeName);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
