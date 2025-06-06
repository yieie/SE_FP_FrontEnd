import 'package:front_end/features/presentation/pages/attendee/sign_up_competition_page.dart';
import 'package:front_end/features/presentation/pages/detail_ann_page.dart';
import 'package:front_end/features/presentation/pages/home_with_ann_page.dart';
import 'package:front_end/features/presentation/pages/sign_in_page.dart';
import 'package:front_end/features/presentation/pages/sign_up_page.dart';
import 'package:front_end/features/presentation/pages/workshop_page.dart';
import 'package:go_router/go_router.dart';



final GoRouter webRouter = GoRouter(
  initialLocation: '/homeWithAnn/1',
  routes: [
    /*
    =================Nav=========================
    */
    GoRoute(
      path: '/homeWithAnn/:page',
      name: 'homeWithAnn',
      builder: (context, state){
        final pageStr = state.pathParameters['page'];

        final page = int.tryParse(pageStr ?? '') ?? 1;
        print(page);
        return HomeWithAnnPage(page: page);
      } 
      
    ),
    GoRoute(
      path: '/workshops',
      name: 'workshops',
      builder: (context, state) => WorkshopPage(),
    ),
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
    GoRoute(
      path: '/signupCompetiton',
      name: 'signupCompetition',
      builder: (context, state)=> SignUpCompetitionPage()
    ),

  ]
);