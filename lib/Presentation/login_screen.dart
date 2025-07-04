

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Logic/Login/login_cubit.dart';
import 'package:time_dignitor_task/Logic/Login/login_state.dart';
import 'package:time_dignitor_task/Logic/Profile/profile_cubit.dart';
import 'package:time_dignitor_task/Presentation/profile_screen.dart';
import 'package:time_dignitor_task/Utils/AppColor.dart';
import 'package:time_dignitor_task/Utils/CustomButtonDesignAllForm.dart';
import 'package:time_dignitor_task/Utils/GlobalSnackbar.dart';
import 'package:time_dignitor_task/Utils/ProgressDialog.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            ProgressDialog.show(context);
          }
          if(state is LoginLoadedState){
            ProgressDialog.hide(context);
            GlobalSnackbar.showSuccess(context, "Login Successful");

            //Navigate to profile screen
            Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context)=>ProfileCubit(),
                  child: ProfileScreen(),
                )
            ),(route) => false,
            );
          }
          if(state is LoginErrorState){
            ProgressDialog.hide(context);
            GlobalSnackbar.showError(context, state.error);
          }
        },
        builder: (context, state) {
          return loginScreenUi();
        },
    );
  }

  Widget loginScreenUi() {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: HalfCircleClipper(),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              decoration: BoxDecoration(
                color: AppColors.primaryColorDark,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 15),
                            const SizedBox(height: 30),
                            Transform.translate(
                              offset: const Offset(0, -50),
                              child: Container(
                                width: 110,
                                height: 110,

                                alignment: Alignment.center,
                                child: /*Image.asset('images/cvLogo.png',
                                    height: 80.0),*/
                                Image.asset(
                                  'assets/images/login_logo.png',
                                  height: 80.0,
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return const Text(
                                      'Image not found',
                                      style: TextStyle(color: Colors.red),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Recoleta',
                                  fontWeight: FontWeight.bold,
                                  height: -4,
                                  // backgroundColor: Colors.teal
                                  //color: const Color.fromARGB(255, 10, 92, 166),
                                ),
                              ),
                            ),

                            TextField(
                              controller: userNameController,
                              maxLength: 30,
                              readOnly: false,
                              decoration: const InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: 'User Name',
                                hintText: 'User Name',
                                border: OutlineInputBorder(),
                                counterText: '',
                              ),
                            ),
                            const SizedBox(height: 5),

                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              maxLength: 20,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: 'Password',
                                hintText: 'Password',
                                border: const OutlineInputBorder(),
                                counterText: '',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              // keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            CustomButtonDesign(onPressed: () {
                              validatePassword();
                            }, buttonText: "Login"),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  void validatePassword() {
    if(userNameController.text.trim().isEmpty){
      GlobalSnackbar.showWarning(context, "Please enter user name");
    }
    else if(passwordController.text.trim().isEmpty){
      GlobalSnackbar.showWarning(context, "Please enter password");
    }
    else{
      context.read<LoginCubit>().fetchLogin(userNameController.text.trim(), passwordController.text.trim());
    }
  }
}
