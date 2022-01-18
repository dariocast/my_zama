import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_zama/views/views.dart';
import 'package:my_zama/wallet_connect/wallet_connect_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletConnectBloc()..add(WalletConnectAppLoaded()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletConnectBloc, WalletConnectState>(
      builder: (context, state) {
        if (state is WalletConnectConnectionSuccess) {
          return const ConnectionSuccessView();
        } else if (state is WalletConnectConnectionFailure) {
          return const ConnectionFailureView();
        } else if (state is WalletConnectInitial) {
          return const InitialView();
        } else if (state is WalletConnectQRReady) {
          return const QRView();
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
