import 'package:eduroom/core/constants/app_assets.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/cubits/login/login_cubit.dart';
import 'package:eduroom/presentation/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/user_role.dart';
import 'widgets/illustration.dart';
import 'widgets/login_sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFF456BC0),
      body: Stack(
        children: [
          Container(
            height: 480,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5E83D8),
                  Color(0xFF4E74C9),
                  Color(0xFF456BC0),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              56.verticalSpace,

              SizedBox(
                height: size.height * 0.22,
                width: double.infinity,
                child: Center(
                  child: Illustration(assetPath: AppAssets.login),
                ),
              ),

              20.verticalSpace,

              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hi Student",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFDDE7FF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              20.verticalSpace,

              Expanded(
                child: Container(
                  height: 483.h,
                  width: double.infinity,
                  padding: const EdgeInsets.all(35),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),

                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA5A5A5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          6.verticalSpace,

                          CustomInput(controller: cubit.emailController),
                          22.verticalSpace,

                          const Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA5A5A5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          6.verticalSpace,

                          CustomInput(
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF8A96A8),
                                size: 22,
                              ),
                              tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                            ),
                          ),
                          40.verticalSpace,

                          BlocConsumer<LoginCubit, LoginState>(
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                if (state.role == UserRole.teacher) {
                                  context.go(AppRoutes.teacherHome);
                                } else if (state.role == UserRole.student) {
                                  context.go(AppRoutes.studentHome);
                                }
                              } else if (state is LoginFailure &&
                                  !state.suppressSnackbar) {
                                Snackbars.showError(
                                  state.failure!.message!,
                                );
                              } else if (state is LoginNetworkError &&
                                  !state.suppressSnackbar) {
                                Snackbars.showError(
                                  state.failure!.message!,
                                );
                              }
                            },
                            builder: (_, state) {
                              return LoginSignInButton(
                                isLoading: state is LoginLoading,
                                onPressed: () => cubit.handleLogin(),
                              );
                            },
                          ),

                          30.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
