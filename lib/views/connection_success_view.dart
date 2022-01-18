import 'dart:developer';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zama/models/nft.dart';
import 'package:my_zama/services/algorand_service.dart';
import 'package:my_zama/wallet_connect/wallet_connect_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_zama/widgets/nft_card.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class ConnectionSuccessView extends StatelessWidget {
  const ConnectionSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = (context.watch<WalletConnectBloc>().state
            as WalletConnectConnectionSuccess)
        .session;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your myZama NFTs'),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showOkCancelAlertDialog(
                  context: context,
                  title: 'Disconnect from wallet',
                  message: 'This will disconnect myZama form your wallet.',
                );

                if (result == OkCancelResult.ok) {
                  context
                      .read<WalletConnectBloc>()
                      .add(WalletConnectDisconnected());
                }
              },
              icon: const FaIcon(FontAwesomeIcons.powerOff)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'myZama is connected to wallet: ${session.accounts[0]}',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) =>
                    snapshot.hasData ? snapshot.data as ListView : Container(),
                future: printAssets(
                  algorand: algorand,
                  accountPublicAddress: session.accounts[0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<ListView> printAssets({
  required Algorand algorand,
  required String accountPublicAddress,
}) async {
  List<NFTCard> assets = [];
  final information = await algorand.getAccountByAddress(accountPublicAddress);
  log('Asset holding:');
  for (var asset in information.assets) {
    final assetResponse = await algorand.indexer().getAssetById(asset.assetId);
    final assetParams = assetResponse.asset.params;
    log('$assetParams');
    assets.add(
      NFTCard(
        nft: NFT(
          id: asset.assetId,
          name: assetParams.name ?? "",
          unitName: assetParams.unitName ?? "",
          amount: asset.amount,
          url: assetParams.url ?? "",
        ),
      ),
    );
  }
  return ListView(
    children: assets,
  );
}
