import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_interface/components/rounded_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_interface/components/round_icon.dart';
import 'package:user_interface/services/backend_helper.dart';
import 'package:user_interface/utilities/userInfo.dart';
import 'package:user_interface/constants.dart';
import 'package:user_interface/components/form_text_field.dart';
import 'package:user_interface/screens/login_screen.dart';
import 'package:user_interface/components/app_logo.dart';
import 'package:user_interface/screens/search_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String screenID = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String? userName;
  String? email;
  String? pass;
  String? phone;
  bool passwordsMatch = false;
  String alertMsg = '';
  bool screenLoading = false;

  RegistrationValidation validate() {
    RegistrationValidation formState = RegistrationValidation.okay;
    if(userName == null || userName=='') {
      alertMsg = 'Enter your name.';
      formState = RegistrationValidation.userName;
    }
    else if(email == null || email=='') {
      alertMsg = 'Enter your email address.';
      formState = RegistrationValidation.email;
    }
    else if(phone == null || phone == '') {
      alertMsg = 'Enter your phone number.';
      formState = RegistrationValidation.phone;
    }
    else if(pass == null || pass == '') {
      alertMsg = 'Make a password.';
      formState = RegistrationValidation.password;
    }
    else if(!passwordsMatch) {
      alertMsg = "Passwords don't match.";
      formState = RegistrationValidation.confirmPassword;
    }
    else {
      alertMsg = '';
    }
    setState(() {});
    return formState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screenLoading ? Center(child: CircularProgressIndicator()) :  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppLogo(),
                Text(
                  'Registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      letterSpacing: 1.1
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FormTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Name',
                        onChanged: (String value) {
                          userName = value;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      FormTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Your Email',
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      FormTextField(
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone Number',
                        onChanged: (String value) {
                          phone = value;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      FormTextField(
                        obscureText: true,
                        hintText: 'Your Password',
                        onChanged: (String value) {
                          pass = value;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      FormTextField(
                        obscureText: true,
                        hintText: 'Confirm Password',
                        onChanged: (String value) {
                          if (value != pass && passwordsMatch) {
                            passwordsMatch = false;
                            validate();
                          }
                          else if (value == pass && !passwordsMatch){
                            passwordsMatch = true;
                            validate();
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        alertMsg,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedButton(
                        text: 'Register',
                        onPressed: () async{
                          setState(() {
                            screenLoading = true;
                          });
                          if (validate() == RegistrationValidation.okay) {
                            UserInfo userInfo = UserInfo(
                              email: email,
                              password: pass,
                              phone: phone,
                              userName: userName,
                            );
                            RegistrationResponse response = await BackendHelper.register(
                                firstName: userInfo.getFirstLastName()[0],
                                lastName: userInfo.getFirstLastName()[1],
                                phone: phone!,
                                email: email!,
                                pass: pass!
                            );
                            if (response == RegistrationResponse.alreadyRegistered) {
                              setState(() {
                                alertMsg = 'User Already Registered. Please Log in.';
                                screenLoading = false;
                              });
                              return;
                            } else if (response == RegistrationResponse.failed) {
                              setState(() {
                                alertMsg = 'Registration Failed';
                                screenLoading = false;
                              });
                              return;
                            }
                            alertMsg ='';
                            screenLoading = false;
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => SearchScreen(
                              userInfo: userInfo,
                            )
                            ));
                          }
                        },
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                      Text(
                        "or",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
//                        decoration: TextDecoration.underline
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RoundIcon(
                            icon: FontAwesomeIcons.facebookF,
                            onPressed: () {

                            },
                          ),
                          RoundIcon(
                            icon: FontAwesomeIcons.googlePlusG,
                            onPressed: () {

                            },
                          ),
                          RoundIcon(
                            icon: FontAwesomeIcons.twitter,
                            onPressed: () {

                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, LoginScreen.screenID);
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.blue
                            ),
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
      ),
    );
  }
}
