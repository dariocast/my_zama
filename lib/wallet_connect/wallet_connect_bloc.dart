import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';

part 'wallet_connect_event.dart';
part 'wallet_connect_state.dart';

class WalletConnectBloc extends Bloc<WalletConnectEvent, WalletConnectState> {
  WalletConnect? connector;

  WalletConnectBloc() : super(WalletConnectLoading()) {
    on<WalletConnectAppLoaded>((event, emit) async {
      if (connector != null) {
        emit(WalletConnectConnectionSuccess(connector!.session));
      } else {
        emit(WalletConnectInitial());
      }
    });

    on<WalletConnectConnectionRequested>((event, emit) async {
      emit(WalletConnectLoading());
      // * Currently, a new wallet connect instance must be initialized
      // Define a session storage
      final sessionStorage = WalletConnectSecureStorage();
      final session = await sessionStorage.getSession();
      // Create a connector
      connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        session: session,
        sessionStorage: sessionStorage,
        clientMeta: const PeerMeta(
          name: 'myZama',
          description: 'myZama NFTs',
          url: 'https://www.facebook.com/ACSanMichele',
          icons: [
            'https://scontent.fnap5-2.fna.fbcdn.net/v/t1.6435-9/36859581_10160714825835512_5143644290999648256_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=MHkJeXzo_MYAX_dUw9c&_nc_ht=scontent.fnap5-2.fna&oh=00_AT83IDN2B96MeQ1VInJxGdEJvjdowZtkBwbAnUQiC67aiw&oe=6204F0D7'
          ],
        ),
      );

      // Subscribe to events
      connector!.registerListeners(
        onConnect: (status) => add(WalletConnectConnected(connector!.session)),
        onSessionUpdate: (response) => log('sessionUpdate: $response'),
        onDisconnect: () => add(WalletConnectDisconnected()),
      );

      connector!.setDefaultProvider(AlgorandWCProvider(connector!));
      // Create a new session
      if (!connector!.connected) {
        await connector!.createSession(
            chainId: 4160,
            onDisplayUri: (uri) {
              if (kIsWeb) {
                emit(
                  WalletConnectQRReady(
                    QrImage(
                      data: uri,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                );
              } else {
                launch(uri);
              }
            });
      } else {
        emit(WalletConnectConnectionSuccess(connector!.session));
      }
    });

    on<WalletConnectConnected>((event, emit) {
      emit(WalletConnectConnectionSuccess(event.session));
    });

    on<WalletConnectDisconnected>((event, emit) async {
      emit(WalletConnectLoading());
      // if serve perché l'evensto viene generato 1 o 2 volte in base a quale lato interrompe la connessione
      if (connector != null && connector!.connected) {
        await connector!.killSession();
        connector = null;
      }
      emit(WalletConnectInitial());
    });
  }
  @override
  void onChange(Change<WalletConnectState> change) {
    super.onChange(change);
    log('$change');
  }
}
