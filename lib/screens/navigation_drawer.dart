import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:package_info/package_info.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String version;

  Widget buildDrawer(String title, IconData icon, Function controller) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: controller);
  }

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.orange,
            height: 150,
            width: double.infinity,

            // child: Image.asset(
            //   'assets/images/todo_list.png',
            // //  fit: BoxFit.fill,
            // ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: buildDrawer('Share', Icons.share, () {
              Share.share('Hello check out this awesome todo list application');
            }),
          ),
          buildDrawer('Check for updates', Icons.update, () {}),
          buildDrawer('Contact us', FontAwesomeIcons.whatsapp, () {
            FlutterOpenWhatsapp.sendSingleMessage('+2349032627367', 'hello');
          }),
          buildDrawer('About', Icons.info, () {
            // return AboutDialog(
            //   applicationName: 'Todo List',
            //   applicationVersion: '$version',
            //   applicationIcon: Image.asset('assets/images/ic_launcher.png'),
            // );
          }),
        ],
      ),
    );
  }

  Future getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      this.version = version;
    });
  }
}
