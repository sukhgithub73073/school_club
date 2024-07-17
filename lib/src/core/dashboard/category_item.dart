import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 37.r,
          backgroundColor: colorCard,
          child: Image.asset(
            category.icon,
            height: 37.r,
          ),
        ),
        10.verticalSpace,
        TextView(
          text: category.name,
          color: colorBlack,
          textSize: 15.sp,
          textAlign: TextAlign.center,
          style: AppTextStyleEnum.title,
          fontFamily: Family.bold,
          lineHeight: 1.3,
        ),
      ],
    );
  }
}
