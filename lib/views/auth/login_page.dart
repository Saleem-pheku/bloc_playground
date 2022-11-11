import 'package:bloc_playground/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc_playground/bloc/auth_bloc/auth_event.dart';
import 'package:bloc_playground/bloc/auth_bloc/auth_state.dart';
import 'package:bloc_playground/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController(),
      otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login with your details",
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(90),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          listener: ((context, state) => {
                if (state is UnAuthenticatedState)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "No User found with this credentials",
                        ),
                      ),
                    )
                  },
                if (state is AuthenticatedState)
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const MyHomePage()),
                      ),
                    )
                  }
              }),
          child:
              BlocBuilder<AuthBloc, AuthState>(buildWhen: (previous, current) {
            otpController.text = (current as OtpSent).otp;
            if (otpController.text.isNotEmpty) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network('https://i.imgur.com/kv2oHwT.gif',
                            fit: BoxFit.cover)),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        hintText: "Enter your Mobile number ",
                      ),
                      validator: (val) {
                        String numberPattern =
                            r'(^(?:[+0]9)?[6-9]{1}?[0-9]{9}$)';
                        RegExp numberRegExp = RegExp(numberPattern);
                        if (!numberRegExp.hasMatch(val!)) {
                          return "Enter a valid email Id";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Card(
                          color: Colors.deepPurple,
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (() {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginAttemptEvent(phoneController.text),
                                );
                                if (state is OtpSent) {
                                  setState(() {
                                    otpController.text = state.otp;
                                  });
                                }
                              }),
                              child: const Text(
                                "send otp",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        hintText: "Auto OTP enabled",
                      ),
                      validator: (val) {
                        String numberPattern =
                            r'(^(?:[+0]9)?[6-9]{1}?[0-9]{9}$)';
                        RegExp numberRegExp = RegExp(numberPattern);
                        if (!numberRegExp.hasMatch(val!)) {
                          return "Enter a valid email Id";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LogInEvent(
                            phoneController.text,
                            otpController.text,
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
