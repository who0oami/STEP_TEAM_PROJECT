import 'package:step_app/model/branch.dart';
import 'package:step_app/vm/database_handler_branch.dart';

// seed_branch.dart
class SeedBranch {
  // ✅ 앱 실행 중 1회만 실행되게 하는 안전장치
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = BranchHandler();

    final List<Branch> seedBranches = [
      Branch(
        branch_name: '강남점',
        branch_phone: '02-325-4441',
        branch_location: '서울특별시 강남구 역삼동 815-2',
        branch_lat: 37.5009279,
        branch_lng: 127.0266585,
      ),
      Branch(
        branch_name: '홍대점',
        branch_phone: '02-325-4442',
        branch_location: '서울특별시 마포구 홍익로 17',
        branch_lat: 37.5538991615,
        branch_lng: 126.9228014552,
      ),
      Branch(
        branch_name: '성수점',
        branch_phone: '02-325-4437',
        branch_location: '서울특별시 성동구 성수동2가 320-4',
        branch_lat: 37.5458,
        branch_lng: 127.0573,
      ),
    ];

    for (final b in seedBranches) {
      await handler.insertBranch(b);
    }

    _inserted = true;
  }
}
