import 'package:algorand_dart/algorand_dart.dart';

final algodClient = AlgodClient(
  apiUrl: AlgoExplorer.TESTNET_ALGOD_API_URL,
  apiKey: '',
  // tokenKey: PureStake.API_TOKEN_HEADER,
);

final indexerClient = IndexerClient(
  apiUrl: AlgoExplorer.TESTNET_INDEXER_API_URL,
  apiKey: '',
  // tokenKey: PureStake.API_TOKEN_HEADER,
);

final algorand = Algorand(
  algodClient: algodClient,
  indexerClient: indexerClient,
  // kmdClient: kmdClient,
);
