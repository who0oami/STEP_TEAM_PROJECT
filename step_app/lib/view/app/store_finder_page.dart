import 'package:flutter/material.dart';

class StoreFinderPage extends StatefulWidget {
  const StoreFinderPage({super.key});

  @override
  State<StoreFinderPage> createState() => _StoreFinderPageState();
}

class _StoreFinderPageState extends State<StoreFinderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '매장 조회',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:25
          ),
        ),
      ),
    );
  }
}