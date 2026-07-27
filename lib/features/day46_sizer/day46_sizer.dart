import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const _accent = Color(0xFF6C5CE7);

class Day46Sizer extends StatelessWidget {
  const Day46Sizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Day 46 - Sizer',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                /// Responsive Container
                ///
                /// 50.w = 50% of the screen width
                /// 20.h = 20% of the screen height
                Container(
                  width: 50.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '50.w × 20.h',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                /// Responsive Text
                ///
                /// .sp automatically scales the font size.
                Text(
                  'Responsive Text',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 2.h),

                /// Responsive Padding
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Sizer automatically scales your UI based on '
                    'the current screen size.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, height: 1.5),
                  ),
                ),

                SizedBox(height: 4.h),

                /// Responsive Circle
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '30.w',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                /// Responsive Button
                SizedBox(
                  width: 100.w,
                  height: 7.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Responsive Button',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                /// Device Information
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      children: [
                        Text(
                          'Current Device',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Screen Width : ${100.w.toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          'Screen Height : ${100.h.toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          'Orientation : ${orientation.name}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          'Device Type : $deviceType',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
