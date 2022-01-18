import 'package:flutter/material.dart';

class ConnectionFailureView extends StatelessWidget {
  const ConnectionFailureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: const Center(
        child: Text(
          'myZama found an error while connecting to wallet',
        ),
      ),
    );
  }
}
