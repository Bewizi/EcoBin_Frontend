import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.bgColor,
    this.textColor,
    this.isDisabledBorder = true,
    this.width,
    this.height,
    this.radius = 8,
    this.child,
  });

  final String title;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? textColor;
  final bool? isDisabledBorder;
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: width ?? constraints.maxWidth,
          height: height ?? 50,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: AppColors.kTransparent,
              backgroundColor: bgColor ?? Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: isDisabledBorder == true
                    ? BorderSide.none
                    : BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            child:
                child ??
                Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? AppColors.kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
        );
      },
    );
  }
}

class OutlinedCustomButton extends StatelessWidget {
  const OutlinedCustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.bgColor,
    this.textColor,
    this.isDisabledBorder = true,
    this.width,
    this.height,
    this.radius = 8,
    this.loadSate = false,
    this.borderColor,
  });

  final String title;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? textColor;
  final bool? isDisabledBorder;
  final double? width;
  final double? height;
  final double radius;
  final bool loadSate;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: onTap,
          child: Container(
            width: width ?? constraints.maxWidth,
            height: height ?? 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: bgColor ?? AppColors.kTransparent,
              border: isDisabledBorder == true
                  ? null
                  : Border.all(
                      color: borderColor ?? AppColors.kPrimary,
                      width: 1,
                    ),
            ),
            child: loadSate
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: textColor ?? AppColors.kWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
