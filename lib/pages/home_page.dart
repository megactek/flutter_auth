import 'package:auth_app/services/api_service.dart';
import 'package:auth_app/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Flutter+Auth+ExpressJs'), elevation: 0, actions: [
        IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ))
      ]),
      backgroundColor: Colors.grey[200],
      body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot<String> model) {
        if (model.hasData) {
          return Center(
            child: Text(model.data!),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
