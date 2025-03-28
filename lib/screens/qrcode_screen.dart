import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'google_maps.dart';
import 'history_screen.dart';
import 'global_history_list.dart';

class QrAppScreen extends StatefulWidget {
  const QrAppScreen({super.key});

  @override
  State<QrAppScreen> createState() => _QrAppScreenState();
}

class _QrAppScreenState extends State<QrAppScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedData = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        setState(() {
          scannedData = scanData.code!;
          _saveToHistory(scannedData);
          Navigator.pop(context);
        });
      }
    });
  }

  void _saveToHistory(String data) {
    if (data.isNotEmpty) {
      setState(() {
        globalHistoryList.add(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF022e46),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'QR App',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showQRScanner,
            icon: const Icon(Icons.qr_code_scanner, size: 28, color: Colors.black),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NEW QR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Scan or generate QR codes easily with this app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: QrImageView(
                data: 'https://example.com',
                size: 300,
                version: QrVersions.auto,
                gapless: false,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showQRScanner() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 300,
          width: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF00598A),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF02313F), Color(0xFF00598A)],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 36,
                        child: Icon(Icons.person, size: 50, color: Colors.black),
                      ),
                      const SizedBox(width: 35),
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          Image.asset('images/image1.png', height: 52, cacheWidth: 800, cacheHeight: 600),
                          const SizedBox(height: 20),
                          const Text(
                            "APP NAME",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User Name", style: TextStyle(color: Colors.white, fontSize: 18)),
                            Text("******@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _buildDrawerTile("Tutorials"),
                  _buildDrawerTile("List Detail", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GoogleMapScreen()));
                  }),
                  _buildDrawerTile("Settings"),
                  _buildDrawerTile("Rate this app"),
                  _buildDrawerTile("History", onTap: () {
                    debugPrint('Passing historyList to HistoryScreen: $globalHistoryList');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(historyList: globalHistoryList),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Log Out", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(Icons.logout, color: Colors.white, size: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Color(0xFF022e46), fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}