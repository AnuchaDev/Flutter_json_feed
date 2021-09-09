import 'package:flutter/material.dart';
import 'package:json_feed/Services/AuthService.dart';

import 'Models/Youtubes.dart';
import 'Services/Network.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  String type = "superhero";

  String _solveImage(String value) {
    String result = "";
    result = value.replaceAll('http', 'https');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            authService.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          },
        )
      ]),
      body: Center(
        child: FutureBuilder<List<Youtube>>(
          future: Network.fetchYoutube(type: type),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
                ),
                child: _listSection(youtubes: snapshot.data),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _listSection({List<Youtube> youtubes}) => ListView.builder(
      itemCount: youtubes.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _headerImageSection();
        }
        var item = youtubes[index];

        return Card(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              _headerSectionCard(youtube: item),
              _bodySectionCard(youtube: item),
              _footerSectionCard(youtube: item),
            ],
          ),
        );
      });

  Widget _headerImageSection() => Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Image.asset(
          'assets/header_home.png',
          height: 100.0,
        ),
      );

  Widget _headerSectionCard({Youtube youtube}) => ListTile(
        leading: Container(
          child: ClipOval(
            child: Image.network(
              youtube.avatarImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          youtube.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        subtitle: Text(
          youtube.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _bodySectionCard({Youtube youtube}) {
    return Image.network(
      // youtube.youtubeImage,
      _solveImage(youtube.youtubeImage),
      fit: BoxFit.cover,
    );
  }

  Widget _footerSectionCard({Youtube youtube}) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _customFlatButton(icon: Icons.thumb_up, label: 'Like'),
          _customFlatButton(icon: Icons.share, label: 'Share'),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _customFlatButton({IconData icon, String label}) => FlatButton(
      onPressed: () {},
      child: Row(
        children: [Icon(icon), Text(label)],
      ));
}
