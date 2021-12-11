import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Đại Lý Test', () {
    final emailText = find.byValueKey('email');
    final passText = find.byValueKey('password');
    final loginBtn = find.byValueKey('loginButton');
    final topFlash = find.byType('FlashBar');
    final homepage = find.byType('HomePage');
    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    test("Log in incorrect", () async {
      await driver.tap(emailText);
      await driver.enterText('quochuy123dh@tql.com');
      await driver.tap(passText);
      await driver.enterText('1234567890');
      await driver.tap(loginBtn);
      await driver.waitFor(topFlash);
      await driver.waitUntilNoTransientCallbacks();
    });

    test("Log in correct", () async {
      await driver.tap(emailText);
      await driver.enterText('quochuy123dh@tql.com');
      await driver.tap(passText);
      await driver.enterText('123456789');
      await driver.tap(loginBtn);
      await driver.waitFor(homepage);
      await driver.waitUntilNoTransientCallbacks();
    });

    test("Scroll Đại Lý Table", () async {
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, -300, Duration(seconds: 1));
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, 300, Duration(seconds: 1));
      await driver.scroll(
          find.byType('ScrollableWidget'), -300, 0, Duration(seconds: 1));
      await driver.scroll(
          find.byType('ScrollableWidget'), 300, 0, Duration(seconds: 1));

      await driver.waitFor(homepage);
      await driver.waitUntilNoTransientCallbacks();
    });

    test("Thêm button", () async {
      await driver.tap(find.byValueKey('ThemDL'));
      await driver.waitFor(find.byType('ThemDaiLy'));

      await driver.tap(find.byValueKey('ThemSubmit'));

      await driver.tap(find.byValueKey('madaily'));
      await driver.enterText('123456789');
      await driver.tap(find.byValueKey('tendaily'));
      await driver.enterText('Nháp');
      await driver.tap(find.byValueKey('loaidaily'));
      await driver.enterText('1');
      await driver.tap(find.byValueKey('sodienthoai'));
      await driver.enterText('51655616');
      await driver.tap(find.byValueKey('email'));
      await driver.enterText('nhap@gmail.com');
      await driver.tap(find.byValueKey('quan'));
      await driver.enterText('Quận Phú Nhuận');
      await driver.tap(find.byValueKey('ThemSubmit'));
      await driver.waitFor(topFlash);
      await driver.waitFor(homepage);
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Xóa button', () async {
      // chưa chọn cái gì để xóa
      await driver.tap(find.byValueKey('xoaDL'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byType('TextButton'));
      // await driver.waitFor(find.byType('TableDaiLy'));
      // chọn một đại lý để xóa
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, -300, Duration(seconds: 2));
      // await driver.waitFor(find.byType('TableDaiLy'));
      await driver.tap(find.text('123456789'));
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, 300, Duration(seconds: 2));
      // await driver.waitFor(find.byType('TableDaiLy'));
      await driver.tap(find.byValueKey('xoaDL'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byValueKey('xoaDLBut'));
      await driver.waitFor(topFlash, timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('DAILY'));
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Sửa button', () async {
      await driver.tap(find.byValueKey('suaDL'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byType('TextButton'));
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, -300, Duration(seconds: 2));
      // await driver.waitFor(homepage);
      await driver.tap(find.text('77'));
      await driver.scroll(
          find.byType('ScrollableWidget'), 0, 300, Duration(seconds: 2));
      // await driver.waitFor(homepage);
      await driver.tap(find.text('88'));
      await driver.tap(find.byValueKey('suaDL'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byType('TextButton'));
      await driver.tap(find.text('88'));
      await driver.tap(find.byValueKey('suaDL'));
      await driver.waitFor(find.byType('ThemDaiLy'));
      await driver.enterText('Đại Lý G');
      await driver.tap(find.byValueKey('suaSubmit'));
      await driver.waitFor(topFlash);
      await driver.tap(find.byValueKey('DAILY'));
      await driver.waitUntilNoTransientCallbacks();
    });
    // test('Test Tài Chính Page', () async {});
  });

  group('test kho hàng', () {
    final topFlash = find.byType('FlashBar');
    final emailText = find.byValueKey('email');
    final passText = find.byValueKey('password');
    final loginBtn = find.byValueKey('loginButton');
    final homepage = find.byType('HomePage');

    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Log in correct", () async {
      await driver.tap(emailText);
      await driver.enterText('quochuy123dh@tql.com');
      await driver.tap(passText);
      await driver.enterText('123456789');
      await driver.tap(loginBtn);
      await driver.waitFor(homepage);
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Navigate Kho Hàng', () async {
      await driver.tap(find.byValueKey('KHOHANG'));
      await driver.waitFor(find.byType('HangHoaList'));
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Test Tất cả mặt hàng Page: nút thêm', () async {
      await driver.tap(find.text('Tất cả mặt hàng'));
      await driver.waitFor(find.byType('HangHoaList'));
      await driver.tap(find.byValueKey('ThemMH'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byValueKey('ThemMHSubmit'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byValueKey('mamathang'));
      await driver.enterText('15615');
      await driver.tap(find.byValueKey('tenmathang'));
      await driver.enterText('Nháp');
      await driver.tap(find.byValueKey('donvi'));
      await driver.enterText('Cái');
      await driver.tap(find.byValueKey('gianhap'));
      await driver.enterText('15000');
      await driver.tap(find.byValueKey('giaxuat'));
      await driver.enterText('17000');
      await driver.tap(find.byValueKey('ThemMHSubmit'));
      await driver.waitFor(topFlash);
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Test Tất cả mặt hàng Page: nút xóa', () async {
      await driver.tap(find.byValueKey('XoaMH'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byType('TextButton'));
      await driver.waitFor(find.byType('HangHoaList'));
      await driver.tap(find.text('15615'));
      await driver.tap(find.byValueKey('XoaMH'));
      await driver.tap(find.byValueKey('XoaMHYes'));
      await driver.waitFor(topFlash, timeout: Duration(seconds: 3));
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Test Tất cả mặt hàng Page: nút sửa', () async {
      await driver.tap(find.byValueKey('SuaMH'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byType('TextButton'));
      await driver.tap(find.text('1111'));
      await driver.tap(find.byValueKey('SuaMH'));
      await driver.waitFor(find.byType('AlertDialog'));
      await driver.tap(find.byValueKey('SuaMHSubmit'));
      await driver.waitFor(topFlash);
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Test Phiếu nhập kho Page', () async {
      await driver.tap(find.text('Phiếu nhập kho'));
      await driver.waitFor(find.byType('PhieuNhapList'));
      await driver.waitUntilNoTransientCallbacks();
    });

    test('Test Phiếu xuất kho Page', () async {
      await driver.tap(find.text('Phiếu xuất kho'));
      await driver.waitFor(find.byType('PhieuXuatList'));
      await driver.waitUntilNoTransientCallbacks();
    });
  });

  group('Test Tài Chính', () {});

  group('Test Nhân Viên', () {});
}
