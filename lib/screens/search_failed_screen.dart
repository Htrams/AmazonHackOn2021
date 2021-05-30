import 'package:flutter/material.dart';
import 'package:user_interface/components/app_logo.dart';
import 'package:user_interface/components/rounded_button.dart';
import 'package:user_interface/constants.dart';
import 'package:user_interface/screens/request_screen.dart';

class SearchFailedScreen extends StatefulWidget {
  @override
  _SearchFailedScreenState createState() => _SearchFailedScreenState();
}

const Color kTextColor = Color(0xFF350561);
class _SearchFailedScreenState extends State<SearchFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9F4FE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogo(),
                    Text(
                      'MediSearch',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        letterSpacing: 1.1
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      'Medicine not available in range',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 23
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RoundedButton(
                        text: 'Increase Range',
                        onPressed: () {

                        },
                        borderRadius: 10.0,
                        color: Color(0xFF2A2AC0),
                        textColor: Colors.white,
                      ),
                    ),
                    Text(
                      "or",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
//                        decoration: TextDecoration.underline
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: RoundedButton(
                        text: 'Drop an emergency request',
                        onPressed: () {
                          Navigator.pop(context,SearchFailedResponse.dropRequest);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RequestScreen()));
                        },
                        borderRadius: 10.0,
                        color: Color(0xFF3A559F),
                        textColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Nearby retailers will be notified about the emergency',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
//                        decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
