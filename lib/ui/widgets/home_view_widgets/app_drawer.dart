import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager/core/services/AuthServices.dart';
import 'package:moneymanager/ui/shared/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
    BuildContext context, {
    Key? key,
  }) : super(key: key);
  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            AuthServices().logout();
            Get.toNamed("/login");
          },
          child: const Text(
            " Yes",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" No"));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              'assets/icons/wallet.png',
              width: 100,
              height: 100,
              alignment: Alignment.centerLeft,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),
          ListTile(
            title: Text('Chart'),
            leading: Icon(Icons.pie_chart),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/chart");
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            title: Text('Log out'),
            leading: Icon(Icons.logout),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      content: Text("Do you wanna leave?"),
                      actions: [Negative(context), Positive()],
                    );
                  });
            },
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
