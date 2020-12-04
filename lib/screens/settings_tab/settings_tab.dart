import 'package:anonaddy/services/access_token_service.dart';
import 'package:anonaddy/services/theme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../initial_screen.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final githubRepoURL = 'https://github.com/KhalidWar/anonaddy';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Theme', style: Theme.of(context).textTheme.headline5),
              Switch(
                value: context.read(themeServiceProvider).isDarkTheme,
                onChanged: (toggle) =>
                    context.read(themeServiceProvider).toggleTheme(),
              ),
            ],
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About App',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Icon(FontAwesomeIcons.github),
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('About App'),
                      content: Text(
                        'This app is a part of Khalid War\'s personal projects. It\'s free and open source. Free as in free of charge, free of ads, and free of trackers. \n\nTo check out the source code for this app, please visit our github repo.',
                      ),
                      actions: [
                        RaisedButton(
                          child: Text('Visit Project Repo'),
                          onPressed: () async {
                            if (await canLaunch(githubRepoURL)) {
                              await launch(githubRepoURL);
                            } else {
                              throw 'Could not launch $githubRepoURL';
                            }
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          // todo add license info
          Spacer(),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton(
              color: Colors.red,
              child: Text(
                'Log Out',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: () {
                context.read(accessTokenServiceProvider).removeAccessToken();
                //todo remove navigation stack upon log out
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return InitialScreen();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
