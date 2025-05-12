import 'package:front_end/features/presentation/pages/detail_ann_page.dart';
import 'package:front_end/features/presentation/pages/home_with_ann_page.dart';
import 'package:front_end/features/presentation/pages/sign_in_page.dart';
import 'package:front_end/features/presentation/pages/sign_up_page.dart';
import 'package:go_router/go_router.dart';



final GoRouter webRouter = GoRouter(
  initialLocation: '/homeWithAnn',
  routes: [
    /*
    =================Nav=========================
    */
    GoRoute(
      path: '/homeWithAnn',
      name: 'homeWithAnn',
      builder: (context, state) => HomeWithAnnPage()
    ),
    // GoRoute(
    //   path: '/workshops',
    //   name: 'workshops',
    //   builder: (context, state) => SignUpPage(),
    // ),
    // GoRoute(
    //   path: '/pastProjects',
    //   name: 'pastProjects',
    //   builder: (context, state) => SignUpPage(),
    // ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/detailAnn/:aid',
      name: 'detailAnn',
      builder: (context, state){
        final aidStr = state.pathParameters['aid'];

        final aid = int.tryParse(aidStr ?? '') ?? 1;
        return DetailAnnPage(aid: aid);
      }
    ),

  ],
);