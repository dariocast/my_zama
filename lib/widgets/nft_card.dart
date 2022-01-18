import 'package:flutter/material.dart';
import 'package:my_zama/models/nft.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({Key? key, required this.nft}) : super(key: key);
  final NFT nft;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
            image: NetworkImage(nft.url),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Text(nft.name),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: Text('${nft.amount} ${nft.unitName}'),
            ),
          ],
        ),
      ),
    );
  }
}
