import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_task_submission_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SubmissionCard extends StatefulWidget {
  const SubmissionCard({super.key, required this.submission, required this.onFeedback});

  final TeacherTaskSubmissionResponse submission;
  final void Function(String feedback) onFeedback;

  @override
  State<SubmissionCard> createState() => _SubmissionCardState();
}

class _SubmissionCardState extends State<SubmissionCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.submission.feedback);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submission = widget.submission;
    final onFeedback = widget.onFeedback;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(submission.studentName ?? 'Student #${submission.studentId}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.graySoft100, borderRadius: BorderRadius.circular(8.r)),
                child: Text(submission.status, style: TextStyle(fontSize: 12.sp)),
              ),
            ],
          ),
          if (submission.content != null && submission.content!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(submission.content!, style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
            ),
          if (submission.submittedAt != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text('Submitted: ${DateFormat('MMM d, HH:mm').format(submission.submittedAt!)}', style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
            ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Feedback',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () => onFeedback(_controller.text.trim()),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.bgColor, foregroundColor: Colors.white),
                child: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
