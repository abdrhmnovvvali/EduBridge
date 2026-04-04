import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_invoices/student_invoices_cubit.dart';
import 'package:eduroom/presentation/student/invoices/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentInvoicesPage extends StatelessWidget {
  const StudentInvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentInvoicesCubit, StudentInvoicesState>(
        listener: (_, state) {
          if (state is StudentInvoicesError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentInvoicesLoading || state is StudentInvoicesInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentInvoicesSuccess) {
            final invoices = state.invoices;
            if (invoices.isEmpty) {
              return Center(
                child: Text('No invoices yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: invoices.length,
              itemBuilder: (_, i) => InvoiceCard(invoice: invoices[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
