import 'package:step_app/model/customer.dart';
import 'package:step_app/vm/database_handler_customer.dart';

class SeedCustomer {
   static Future<void> insertSeed() async {
    final dbHandler = DatabaseHandlerCustomer();

    List<Customer> customers = [
      Customer(
        customer_name: '황만수',
        customer_phone: '010-4324-3443',
        customer_pw: 'password123',
        customer_email: 'hong@naver.com',
        customer_address: '서울시 강남구',
        customer_image: null,
        customer_lat: 37.4979,
        customer_lng: 127.0276,
      ),
      Customer(
        customer_name: '김나라',
        customer_phone: '010-9876-5432',
        customer_pw: '1234abcd',
        customer_email: 'kim@test.com',
        customer_address: '서울시 마포구 홍익로',
        customer_image: null,
        customer_lat: 37.2343,
        customer_lng: 127.0090,
      ),
    ];

    // 삽입
    for (var c in customers) {
      await dbHandler.insertCustomer(c);
    }
  }
}
