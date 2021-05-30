import 'package:flutter/material.dart';
import 'package:user_interface/components/app_logo.dart';
import 'package:user_interface/components/rounded_button.dart';
import 'package:user_interface/components/background_wave_painter.dart';
import 'package:user_interface/screens/login_screen.dart';
import 'package:user_interface/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String screenID = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double endValue = 0.7;
  double animatedOpacityValue = 1.0;
  double animatedElevationValue = 5.0;

  @override
  Widget build(BuildContext context) {
    print('Starting app');
    return Scaffold(
      backgroundColor: Colors.white,
      body: TweenAnimationBuilder(
        duration: const Duration(seconds: 1),
        tween: Tween<double>(begin: 1,end: endValue),
        curve: Curves.elasticOut,
        builder: (BuildContext context, double value, Widget? child) {
          animatedOpacityValue = (1-endValue*2+value*2) >= 1 ? 1:1-endValue*2+value*2;
          animatedElevationValue = 5-endValue*2+value*2;
          return CustomPaint(
            painter: BackgroundWavePainter(
              midHeight: value
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 73,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLogo(
                          color: Colors.blue.shade200.withOpacity(animatedOpacityValue),
                        ),
                        Text(
                          'Medico',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black.withOpacity(animatedOpacityValue)
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                          text: 'Log In',
                          onPressed: () {
                            print('Log In button pressed');
                            Navigator.pushNamed(context, LoginScreen.screenID);
                          },
                          color: Color(0xfff5f9fa),
                          opacity: animatedOpacityValue,
                          elevation: animatedElevationValue,
                        ),
                        RoundedButton(
                          text: 'Register',
                          onPressed: () {
                              print('Register button pressed');
                              Navigator.pushNamed(context, RegistrationScreen.screenID);
                          },
                          color: Color(0xfff5f9fa),
                          opacity: animatedOpacityValue,
                          elevation: animatedElevationValue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}