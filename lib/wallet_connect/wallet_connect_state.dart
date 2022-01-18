part of 'wallet_connect_bloc.dart';

@immutable
abstract class WalletConnectState {}

class WalletConnectInitial extends WalletConnectState {}

class WalletConnectConnectionSuccess extends WalletConnectState {
  final WalletConnectSession session;
  WalletConnectConnectionSuccess(this.session);
}

class WalletConnectConnectionFailure extends WalletConnectState {}

class WalletConnectLoading extends WalletConnectState {}

class WalletConnectQRReady extends WalletConnectState {
  final QrImage qrImage;

  WalletConnectQRReady(this.qrImage);
}
