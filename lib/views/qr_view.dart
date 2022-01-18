import 'package:flutter/material.dart';
import 'package:my_zama/wallet_connect/wallet_connect_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QRView extends StatelessWidget {
  const QRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QrImage qrImage =
        (context.watch<WalletConnectBloc>().state as WalletConnectQRReady)
            .qrImage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Scan QR with your Algorand Wallet'),
            ),
            qrImage,
          ],
        ),
      ),
    );
  }
}
