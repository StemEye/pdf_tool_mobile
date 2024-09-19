import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: Text('btn 1')),
        ElevatedButton(onPressed: () {}, child: Text('btn 2')),
        ElevatedButton(onPressed: () {}, child: Text('btn 3')),
        ElevatedButton(onPressed: () {}, child: Text('btn 4')),
        ElevatedButton(onPressed: () {}, child: Text('btn 5')),
      ],
    );
  }
}
