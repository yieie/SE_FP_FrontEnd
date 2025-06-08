

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_event.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:go_router/go_router.dart';

class JudgeNav extends StatefulWidget{
  @override
  _JudgeNavState createState() => _JudgeNavState();
  
}

class _JudgeNavState extends State<JudgeNav>{
  bool _show = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children:[ 
        if(_show)
          Container(
            width: 105,
            height: 170,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Text("編輯個人資訊",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12
                  ),
                  ),
                  onPressed: (){
                    context.go('/profile');
                  },
                ),
                TextButton(
                  child: Text("登出",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12
                  ),
                  ),
                  onPressed: (){
                    
                    context.read<AuthBloc>().add(LoggedOut());
                    context.go('/homeWithAnn/1');
                  },
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        SizedBox(
          width: 1120,
          height: 100,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: ()=>context.go('/projectViewList/1'), 
                icon: Image.asset("assets/images/weblogo.png",width: 150,height: 100,)),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 17.5),
                child: TextButton(
                  child: Text("最新公告",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 3.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  ),
                  onPressed: (){
                    context.go('/homeWithAnn/1');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 17.5),
                child: TextButton(
                  child: Text("評分列表",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 3.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  ),
                  onPressed: (){
                    context.go('/projectViewList/1');
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
                  onPressed: (){},
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _show = !_show;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 17.5, right: 17.5),
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/images/user.png"),
                )
              )
            ]
          ),
        ),  
      ]
    );
  }

}
