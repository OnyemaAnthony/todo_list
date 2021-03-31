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

  final String playStoreURL = 'https://play.google.com/store/apps/details?id=com.onyema.tony.todo_list';
 // final String playStoreURL = 'https://apps.apple.com/app/id1518200433';

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
            height: 200,
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
          buildDrawer('Check for updates', Icons.update, () async{
            await canLaunch(playStoreURL) ? await launch(playStoreURL) : throw 'Could not launch $playStoreURL';

          }),
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

