import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String version;

  Widget buildDrawer(String title, IconData icon, Function controller) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: controller);
  }

  final String playStoreURL =
      'https://play.google.com/store/apps/details?id=com.onyema.tony.todo_list';

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
            //padding: EdgeInsets.all(50),
            color: Colors.orange,
            height: 180,
            width: double.infinity,

            child: Image.asset(
              'assets/images/ic_launcher.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: buildDrawer('Share', Icons.share, () {
              Share.share('Hello check out this awesome todo list application');
            }),
          ),
          buildDrawer('Check for updates', Icons.update, () async {
            await canLaunch(playStoreURL)
                ? await launch(playStoreURL)
                : throw 'Could not launch $playStoreURL';
          }),
          buildDrawer('Contact us', FontAwesomeIcons.whatsapp, () {
            FlutterOpenWhatsapp.sendSingleMessage('+2349032627367', 'hello');
          }),
          AboutListTile(
            applicationIcon: Container(
              width: 50,
              height: 50,
              child: Image.asset('assets/images/ic_launcher.png'),
            ),
            icon: Icon((Icons.info)),
            aboutBoxChildren: <Widget>[],
            applicationVersion: version,
            applicationLegalese: "Apache License 2.0",
          ),
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
