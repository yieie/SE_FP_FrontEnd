import 'package:flutter/material.dart';
import 'package:front_end/cores/route/web_route.dart';
import 'package:front_end/features/presentation/pages/home_with_ann_page.dart';
import 'package:front_end/features/presentation/pages/sign_up_page.dart';
import 'package:front_end/injection_container.dart';
Future<void> main() async{
  await initializeDependencies();
  runApp(MyApp());
}

//正式版
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: webRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
測試用架構
不是使用router
要測試單一Page使用下方class
記得把上方class註解起來

 */
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home: SignUpPage(),
//     );
//   }
// }