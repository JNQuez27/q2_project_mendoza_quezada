  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:mobile_scanner/mobile_scanner.dart';
  import 'result_page.dart';

  class ScanPage extends StatefulWidget {
    const ScanPage({super.key});

    @override
    State<ScanPage> createState() => _ScanPageState();
  }

  class _ScanPageState extends State<ScanPage> {
    String? currentlyDetectedBarcode;
    bool isBarcodeDetected = false;
    Timer? _detectionTimer;

    // Timeout duration - if no barcode is detected for this long, reset the state
    static const Duration _detectionTimeout = Duration(milliseconds: 800);

    final Map<String, String> barcodeToWaste = {
      "123456789": "Lithium Battery",
      "987654321": "Mouse",
      "555666777": "RAM",
    };

    final MobileScannerController scannerController = MobileScannerController();

    void handleScan(String barcode) {
      final wasteName = barcodeToWaste[barcode] ?? "Unknown Waste";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(scannedResult: wasteName),
        ),
      );
    }

    void _resetDetectionState() {
      if (mounted) {
        setState(() {
          currentlyDetectedBarcode = null;
          isBarcodeDetected = false;
        });
      }
    }

    void _startDetectionTimer() {
      // Cancel any existing timer
      _detectionTimer?.cancel();

      // Start a new timer
      _detectionTimer = Timer(_detectionTimeout, () {
        _resetDetectionState();
      });
    }

    void onCapturePressed() {
      if (isBarcodeDetected && currentlyDetectedBarcode != null) {
        handleScan(currentlyDetectedBarcode!);
        _resetDetectionState();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Barcode not detected. Make sure it is clear and properly aligned.",
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7F6),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF7D7D7D)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Scan E-Waste",
            style: TextStyle(
              color: Color(0xFF7D7D7D),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: scannerController,
              onDetect: (capture) {
                if (capture.barcodes.isNotEmpty) {
                  final barcode = capture.barcodes.first;
                  if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
                    if (!isBarcodeDetected ||
                        currentlyDetectedBarcode != barcode.rawValue!) {
                      setState(() {
                        currentlyDetectedBarcode = barcode.rawValue!;
                        isBarcodeDetected = true;
                      });
                    }
                    _startDetectionTimer();
                  }
                }
              },
            ),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isBarcodeDetected
                        ? Colors.green.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            // Detection status indicator
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isBarcodeDetected
                        ? Colors.green.withOpacity(0.9)
                        : Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isBarcodeDetected
                        ? "Barcode Detected: ${currentlyDetectedBarcode ?? ''}"
                        : "Align barcode within frame",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onCapturePressed,
          backgroundColor: isBarcodeDetected
              ? const Color(0xFF4CAF50)
              : const Color(0xFF5B9BD5),
          child: Icon(
            isBarcodeDetected ? Icons.check : Icons.camera_alt,
            size: 32,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }

    @override
    void dispose() {
      _detectionTimer?.cancel();
      scannerController.dispose();
      super.dispose();
    }
  }
