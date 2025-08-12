import 'package:flutter/material.dart';
import 'dart:js_interop';

// JS tarafındaki window.starknet objesi
@JS()
external StarknetWallet? get starknet;

// Starknet wallet ana sınıfı
@JS()
@staticInterop
class StarknetWallet {}

extension StarknetWalletExtension on StarknetWallet {
  external JSPromise<JSAny?> enable();
  external StarknetAccount? get account;
}

// Account objesi
@JS()
@staticInterop
class StarknetAccount {}

extension StarknetAccountExtension on StarknetAccount {
  external String get address;
  external JSPromise<JSAny?> execute(JSArray calls);
}

// Provider için
@JS()
@staticInterop
class StarknetProvider {}

extension StarknetProviderExtension on StarknetProvider {
  external JSPromise<JSAny?> callContract(JSObject call);
}

extension StarknetWalletProviderExtension on StarknetWallet {
  external StarknetProvider get provider;
} 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Henüz yapılmadı';
  String? _walletAddress;
  String _mintStatus = 'NFT henüz mintlenmedi';
  String _balance = 'Bakiye kontrol edilmedi';

  void _checkStarknetOnWindow() {
    setState(() {
      _status = starknet == null
          ? 'window.starknet bulunamadı'
          : 'window.starknet bulundu';
    });
  }

  Future<void> _checkBalance() async {
    try {
      if (starknet?.account == null) {
        setState(() {
          _balance = 'Önce cüzdanı bağlayın';
        });
        return;
      }

      setState(() {
        _balance = 'Bakiye kontrol ediliyor...';
      });

      const strkContract = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
      
      final call = {
        "contractAddress": strkContract,
        "entrypoint": "balanceOf",
        "calldata": [_walletAddress]
      }.jsify() as JSObject;

      final result = await starknet!.provider.callContract(call).toDart;
      
      // Parse uint256 result [low, high]
      final resultList = result as List;
      final balanceHex = resultList[0].toString(); // Get low part
      final balanceBigInt = BigInt.parse(balanceHex.replaceFirst('0x', ''), radix: 16);
      final balanceStrk = balanceBigInt / BigInt.from(1000000000000000000); // Convert from wei to STRK
      
      setState(() {
        _balance = 'STRK Bakiye: ${balanceStrk.toStringAsFixed(2)} STRK';
      });

    } catch (e) {
      setState(() {
        _balance = 'Bakiye hatası: $e';
      });
    }
  }

  Future<void> _mintNFT() async {
    try {
      if (starknet?.account == null) {
        setState(() {
          _mintStatus = 'Önce cüzdanı bağlayın';
        });
        return;
      }

      setState(() {
        _mintStatus = 'NFT mintleniyor...';
      });

      // Test: Basit mint fonksiyonu (kendi contract deploy edilince değişecek)
      const nftContract = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
      
      // Generate a random token ID
      final tokenId = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Test call (STRK transfer simulating mint)
      final calls = [
        {
          "contractAddress": nftContract,
          "entrypoint": "transfer",
          "calldata": [
            _walletAddress, // to address
            "100000000000000000", // 0.1 STRK
            "0" // high part
          ]
        }
      ].jsify() as JSArray;

      final result = await starknet!.account!.execute(calls).toDart;
      
      setState(() {
        _mintStatus = 'STRK transfer başarılı! �';
      });

      print('Transaction result: $result');

    } catch (e) {
      setState(() {
        _mintStatus = 'NFT Mint hatası: $e';
      });
      print('Transaction error: $e');
    }
  }

  Future<void> _enableStarknet() async {
    try {
      if (starknet == null) {
        setState(() {
          _status = 'Enable başarısız — window.starknet bulunamadı';
        });
        return;
      }

      final wallet = starknet!;
      final jsPromise = wallet.enable();
      await jsPromise.toDart; // bağlanma isteği (popup açılmalı)

      final address = wallet.account?.address;

      setState(() {
        _walletAddress = address;
        _status = address != null
            ? 'Bağlandı ✅'
            : 'Bağlantı başarısız ❌';
      });

      print('Wallet address: $address');
    } catch (e, st) {
      setState(() {
        _status = 'Hata: $e';
      });
      print('Hata stack: $st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web — Dart ↔ JS demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Dart ↔ JS (starknet) Demo')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Durum: $_status'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _checkStarknetOnWindow,
                child: const Text('Check window.starknet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _enableStarknet,
                child: const Text('Cüzdanı Bağla'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _walletAddress != null ? _checkBalance : null,
                child: const Text('Bakiye Kontrol Et'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _walletAddress != null ? _mintNFT : null,
                child: const Text('NFT Mint'),
              ),
              const SizedBox(height: 16),
              const Text('Wallet Address:'),
              const SizedBox(height: 8),
              SelectableText(_walletAddress ?? 'Henüz yok'),
              const SizedBox(height: 16),
              Text(_balance),
              const SizedBox(height: 16),
              const Text('Transaction Durumu:'),
              const SizedBox(height: 8),
              Text(_mintStatus),
              const SizedBox(height: 20),
              const Text(
                'Not: Cüzdan popup penceresi açılmazsa, tarayıcı eklentiniz yok demektir.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
