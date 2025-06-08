

import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:go_router/go_router.dart';

Widget buildBasicNav(BuildContext context){
  return SizedBox(
    width: 1120,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: ()=>context.go('/homeWithAnn/1'), 
            icon: Image.asset("assets/images/weblogo.png",width: 150,height: 100,)),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 17.5),
            child: TextButton(
              child: Text("工作坊資訊",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.2,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              ),
              onPressed: (){
                context.go('/workshops');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 17.5),
            child: TextButton(
              child: Text("歷年作品",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.2,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              ),
              onPressed: (){
                context.go('/pastProjects');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 17.5),
            child: TextButton(
              child: Text("登入",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )
              ),
              onPressed: (){
                context.go('/login');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 17.5),
            child: TextButton(
              child: Text("註冊",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              onPressed: (){
                context.go('/register');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 17.5),
            width: 160,
            height: 48,
            child: BasicWebButton(
              backgroundColor: Color(0xFFF96D4E),
              title: '立刻報名',
              fontSize: 16,
              onPressed: (){
                context.go('signupCompetition');
              }
            )
          ),
        ]
      )
  );
}