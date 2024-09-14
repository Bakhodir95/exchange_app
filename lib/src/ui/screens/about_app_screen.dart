import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("about_the_app")),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr("currency_rate_app_description"),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 40.sp,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10.w),
                Text(
                  context.tr("app_info"),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Divider(thickness: 1.h, color: Colors.grey[300]),
            SizedBox(height: 20.h),
            Text(
              context.tr("more_info"),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
