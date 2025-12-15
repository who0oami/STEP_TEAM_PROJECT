import 'dart:typed_data';

class PurchaseListItem {
  final int orderId;
  final Uint8List imageBytes;
  final String? imageAssetPath;

  final String productName;
  final String brandName;
  final String branchName;
  final String sizeText;

  int pickupStatus; // 0=대기, 1=완료

  final double? branchLat;
  final double? branchLng;
  final String? branchLocation;

  PurchaseListItem({
    required this.orderId,
    required this.imageBytes,
    this.imageAssetPath,
    required this.productName,
    required this.brandName,
    required this.branchName,
    required this.sizeText,
    this.pickupStatus = 0,
    this.branchLat,
    this.branchLng,
    this.branchLocation,
  });
}
