import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kongsi_kereta/src/page/auth/login.dart';
import 'package:kongsi_kereta/src/page/auth/sign_up.dart';
import 'package:kongsi_kereta/src/widgets/button/custom_pill_button.dart';

import '../../widgets/appbar/custom_appbar.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        onPressed: () {},
        noBackButton: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // logoMain(context: context, height: 50),
            Container(
              child: Column(children: [
                SvgPicture.asset(
                  'assets/images/illustration.svg',
                  semanticsLabel: 'News at Your Fingertips',
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Kongsi Kereta',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Cut Costs, Share Rides!',
                  style: TextStyle(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            Container(
              child: Column(
                children: [
                  customPillButton(
                    context: context,
                    borderColor: Colors.deepPurple,
                    fillColor: Colors.deepPurple,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  customPillButton(
                    context: context,
                    borderColor: Colors.deepPurple,
                    fillColor: Colors.deepPurple,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
