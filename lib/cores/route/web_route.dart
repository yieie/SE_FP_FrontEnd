import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/pages/admin/admin_overview_page.dart';
import 'package:front_end/features/presentation/pages/admin/announcement_add_or_modify_page.dart';
import 'package:front_end/features/presentation/pages/admin/announcement_manage_list_page.dart';
import 'package:front_end/features/presentation/pages/admin/project_verify_detail_page.dart';
import 'package:front_end/features/presentation/pages/admin/project_verify_list_page.dart';
import 'package:front_end/features/presentation/pages/attendee/sign_up_competition_page.dart';
import 'package:front_end/features/presentation/pages/detail_ann_page.dart';
import 'package:front_end/features/presentation/pages/home_with_ann_page.dart';
import 'package:front_end/features/presentation/pages/judge/project_view_detail_page.dart';
import 'package:front_end/features/presentation/pages/judge/project_view_list_page.dart';
import 'package:front_end/features/presentation/pages/past_project_detail_page.dart';
import 'package:front_end/features/presentation/pages/past_project_list_page.dart';
import 'package:front_end/features/presentation/pages/profile_manage_page.dart';
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
    GoRoute(
      path: '/pastProjects',
      name: 'pastProjects',
      builder: (context, state) => PastProjectPage(),
    ),
    GoRoute(
      path: '/pastProjectsDetail/:teamid',
      name: 'pastProjectsDetail',
      builder: (context, state){
        final teamid = state.pathParameters['teamid'];
        if(teamid != null){
          return PastProjectDetailPage(teamid: teamid);
        }else{
          return PastProjectPage();
        }
      } 
    ),
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
      builder: (context, state)=> SignUpCompetitionPage(),
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'student') {
        return '/homeWithAnn/1'; 
      }
      return null;
  }
    ),
    GoRoute(
      path: '/projectViewList/:page',
      name: 'projectViewList',
      builder: (context, state){
        final pageStr = state.pathParameters['page'];

        final page = int.tryParse(pageStr ?? '') ?? 1;
        print(page);
        return ProjectViewListPage(page: page);
      } ,
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'judge') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/projectViewDetail/:teamid/:workid',
      name: 'projectViewDetail',
      builder: (context, state){
        final teamid = state.pathParameters['teamid'];
        final workid = state.pathParameters['workid'];
        final score = double.tryParse(state.uri.queryParameters['score'] ?? '-1');
        if(teamid != null && workid != null){
          return ProjectViewDetailPage(teamid: teamid, workid: workid,score: score!);
        }else{
          return ProjectViewListPage(page: 1); 
        }
      } ,
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'judge') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state)=> ProfileManagePage(),
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState is Unauthenticated) {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/overview',
      name: 'overview',
      builder: (context, state) => AdminOverviewPage(),
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'admin') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/annManageList/:page',
      name: 'annManageList',
      builder: (context, state){
        final pageStr = state.pathParameters['page'];

        final page = int.tryParse(pageStr ?? '') ?? 1;
        print(page);
        return AnnouncementManageListPage(page: page);
      },
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'admin') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/annModifyOrAdd',
      name: 'annModifyOrAdd',
      builder: (context, state){
        final aidStr = state.uri.queryParameters['aid'];

        final aid = int.tryParse(aidStr ?? '');
        return AnnouncementAddOrModifyPage(aid: aid,);
      },
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'admin') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/projectVertifyList/:page',
      name: 'projectVertifyList',
      builder: (context, state){
        final pageStr = state.pathParameters['page'];

        final page = int.tryParse(pageStr ?? '') ?? 1;
        print(page);
        return ProjectVerifyListPage(page: page);
      } ,
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'admin') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
    GoRoute(
      path: '/projectVertifyDetail/:teamid',
      name: 'projectVertifyDetail',
      builder: (context, state){
        final teamid = state.pathParameters['teamid'];
        if(teamid!=null){
          return ProjectVerifyDetailPage(teamid: teamid);
        }else{
          return ProjectVerifyListPage(page: 1);
        }
      } ,
      redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState.usertype != 'admin') {
        return '/homeWithAnn/1'; 
      }
      return null;
      }
    ),
  ]
  
);