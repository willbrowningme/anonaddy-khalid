import 'package:anonaddy/constants.dart';
import 'package:anonaddy/services/networking.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String baseURL = 'https://app.anonaddy.com/api/v1';
  String accountDetailsURL = 'account-details';
  String id, username, subscription;
  double bandwidth, bandwidthLimit;
  int usernameCount;

  Future accountDetails() async {
    Networking networking = Networking('$baseURL/$accountDetailsURL');
    var data = await networking.getData();
    print(data);

    setState(() {
      id = data['data']['id'];
      username = data['data']['username'];
      bandwidth = data['data']['bandwidth'] / 1024000;
      bandwidthLimit = data['data']['bandwidth_limit'] / 1024000;
      usernameCount = data['data']['username_count'];
      subscription = data['data']['subscription'];
    });

    print(id);
    print(username);
    print(bandwidth);
    print(usernameCount);

    return data;
  }

  @override
  void initState() {
    super.initState();
    accountDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          // title: Image.asset('assets/images/logo-dark.svg'),
          leading: IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //todo POST to create Aliases
          },
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '$username'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.grey),
                          ),
                          Text(
                            '$id',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subscription:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.grey),
                          ),
                          Text(
                            '$subscription',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bandwidth:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.grey),
                          ),
                          Text(
                            '${bandwidth.round()} MB / ${bandwidthLimit.round()} MB',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // RaisedButton(
              //   child: Text('CLICK ME!!'),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
