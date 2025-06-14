import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/widget/admin/admin_nav.dart';
import 'package:front_end/features/presentation/widget/attendee/attendee_nav.dart';
import 'package:front_end/features/presentation/widget/basic/basic_nav.dart';
import 'package:front_end/features/presentation/widget/judge/judge_nav.dart';
import 'package:front_end/features/presentation/widget/student/student_nav.dart';
import 'package:front_end/features/presentation/widget/teacher/teahcer_nav.dart';

class BasicScaffold extends StatelessWidget {
  final Widget child;

  const BasicScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authstate){
        print(authstate);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            //背景
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromRGBO(254, 228, 37, 1),
                  const Color.fromRGBO(250, 186, 86, 1),
                ],
              ),
            ),
          child: SizedBox(
            width: 1120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 1120,height: 40),
                  
                  //Nav
                  if(authstate is Unauthenticated || authstate is AuthInitial)
                    buildBasicNav(context),
                  if(authstate.usertype == "student")
                    StudentNav(),
                  if(authstate.usertype == "attendee")
                    AttendeeNav(),
                  if(authstate.usertype == "admin")
                    AdminNav(),
                  if(authstate.usertype == "teacher")
                    TeahcerNav(),
                  if(authstate.usertype == "judge")
                    JudgeNav(),
                  // if(authstate.usertype == "lecturer")
                  
                  //body
                  Expanded(
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  ),

                  //footer
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEE425)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/NUKlogo.png"),
                        SizedBox(width: 40),
                        Text(
                          '© 2025 國立高雄大學 軟體工程課程專案 | Developed by：陳冠霖、張卜驊、黃羿禎、涂哲偉、張哲與'
                        )
                      ], 
                    ),
                  )
                ]
              ),
          )
          )
        );
      });
  }
}