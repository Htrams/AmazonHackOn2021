import 'package:flutter/material.dart';
import 'package:user_interface/components/form_text_field.dart';
import 'package:user_interface/components/rounded_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_interface/components/round_icon.dart';
import 'package:user_interface/constants.dart';
import 'package:user_interface/services/backend_helper.dart';
import 'package:user_interface/utilities/userInfo.dart';
import 'package:user_interface/screens/registration_screen.dart';
import 'package:user_interface/screens/search_screen.dart';
import 'package:user_interface/components/app_logo.dart';




class LoginScreen extends StatefulWidget {
  static String screenID = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email;
  String? pass;
  String alertMsg = '';
  bool screenLoading = false;

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
                  'Login Information',
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
                        hintText: 'Your Email',
                        onChanged: (String value) {
                          email = value;
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
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: (){
                          print('forgot password pressed');
                        },
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.grey,
//                        decoration: TextDecoration.underline
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Text(
                        '$alertMsg',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                      ),
                      RoundedButton(
                        text: 'Log In',
                        onPressed: () async{
                          setState(() {
                            screenLoading = true;
                          });
                          if(email==null || email=='' || pass==null || pass=='') {
                            setState(() {
                              alertMsg = 'Please enter Login details.';
                              screenLoading = false;
                            });
                            return;
                          }
                          if(await BackendHelper.login(email!, pass!) == LoginResponse.failed) {
                            setState(() {
                              alertMsg = 'Login Failed';
                              screenLoading = false;
                            });
                            return;
                          }
                          Map<String,dynamic> informationDetails = await BackendHelper.loginDetails(email!);
                          if(informationDetails['Passed'] == 'false') {
                            setState(() {
                              alertMsg = 'Login Failed';
                              screenLoading = false;
                            });
                            return;
                          }
                          alertMsg ='';
                          screenLoading = false;
                          UserInfo userInfo = UserInfo(
                            //email: email,
                            email: email,
                            password: pass,
                            userName: informationDetails['name'],
                            phone: informationDetails['phone'],
                          );
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => SearchScreen(
                                userInfo: userInfo,
                              )
                          ));
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
                        "Don't have an account? ",
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
                            Navigator.pushNamed(context, RegistrationScreen.screenID);
                          },
                          child: Text(
                            'Register',
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