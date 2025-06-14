import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/route/web_route.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_event.dart';


import 'package:front_end/features/presentation/pages/past_project_list_page.dart';
import 'package:front_end/features/presentation/pages/past_project_detail_page.dart';

import 'package:front_end/features/presentation/pages/admin/project_verify_list_page.dart';
import 'package:front_end/features/presentation/pages/admin/project_verify_detail_page.dart';
import 'package:front_end/features/presentation/pages/attendee/team_info_page.dart';
import 'package:front_end/injection_container.dart';


final authBloc = sl<AuthBloc>();
Future<void> main() async{
  await initializeDependencies();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>()..add(AppStarted()),
      child:  MyApp()
  ));
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


//  class MyApp extends StatelessWidget {
//   @override
//    Widget build(BuildContext context) {
//      return  MaterialApp(
//        //home: SignUpPage(),
//       //home: HomeWithAnnPage(),

//        //home: TeacherViewProjectPage(),

//        //home: ProjectVerifyListPage(),

//        //home:  ProjectVerifyDetailPage(),

//        //home:  TeamInfoPage(),

//        //home: TeacherProjectViewDetailPage(),

//        home: PastProjectDetailPage(),
//      );
//   }
//  }