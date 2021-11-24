import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/dto/commitment.dart';

Future<void> airdrop(
  RPCClient client,
  Ed25519HDKeyPair wallet, {
  int? sol,
  int? carats,
}) async {
  // Request some tokens first
  final int? amount = sol != null ? sol * caratsPerGema : carats;
  if (amount == null) {
    throw const FormatException('either specify "sol" or "carats"');
  }
  final txSignature = await client.requestAirdrop(
    address: wallet.address,
    carats: amount,
  );
  await client.waitForSignatureStatus(txSignature, Commitment.finalized);
}
