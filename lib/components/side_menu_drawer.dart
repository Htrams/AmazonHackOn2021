import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_interface/utilities/userInfo.dart';
import 'package:user_interface/screens/request_screen.dart';
import 'package:user_interface/screens/welcome_screen.dart';

class SideMenuDrawer extends StatelessWidget {
  final UserInfo userInfo;
  final Map<String,String> medicineMap;

  SideMenuDrawer({required this.userInfo, required this.medicineMap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.lightBlueAccent,
                    Colors.blue.shade600
                  ]
                )
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    userInfo.getFirstLastName().join(' '),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                    ),
                  ),
                  Text(
                    userInfo.email!,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0
                    ),
                  )
                ],
              )
          ),
          SideMenuListTile(
            icon: FontAwesomeIcons.user,
            text: "Account",
            onTap: () {

            },
          ),
          Divider(),
          SideMenuListTile(
            icon: FontAwesomeIcons.pills,
            text: "Medicine Requests",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RequestScreen(
                medicineMap: medicineMap,
                userInfo: userInfo,
              )));
            },
          ),
          Divider(),
          SideMenuListTile(
            icon: FontAwesomeIcons.signOutAlt,
            text: "Sign Out",
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.screenID));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SideMenuListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  SideMenuListTile({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
          icon
      ),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 18.0
        ),
      ),
    );
  }
}