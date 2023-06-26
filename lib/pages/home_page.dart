import 'package:flutter/material.dart';
import 'package:practicebloom/models/user.dart' as model;
import 'package:practicebloom/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back, ${user.fullname}!', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
