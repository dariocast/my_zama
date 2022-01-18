import 'package:flutter/material.dart';
import 'package:my_zama/wallet_connect/wallet_connect_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('myZama')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'myZama is not connected to wallet',
              ),
            ),
            ElevatedButton(
              onPressed: () => context
                  .read<WalletConnectBloc>()
                  .add(WalletConnectConnectionRequested()),
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
