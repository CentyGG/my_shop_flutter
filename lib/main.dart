import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_shop_flutter/services/cart_service.dart';
import 'package:my_shop_flutter/utils/price_formatter.dart';
import 'app_router.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getDI();
  GetIt.I.allowReassignment = true;
  runApp(const MyApp());
}
void getDI(){
  GetIt.I.registerSingleton<CartService>(CartService());
  getIt.registerFactory<PriceFormatter>(() => PriceFormatter());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Магазин',
      theme: ThemeData(useMaterial3: true),
    );
  }
}
