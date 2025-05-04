import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';

class BasicScaffold extends StatelessWidget {
  final Widget child;

  const BasicScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 1120,height: 40,),
              SizedBox(
                width: 1120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 170,
                        height: 120,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Image.asset("assets/images/weblogo.png"),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text("工作坊資訊",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text("歷年作品",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text("登入",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text("註冊",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        width: 160,
                        height: 48,
                        child: BasicWebButton(
                          backgroundColor: Color(0xFFF96D4E),
                          title: '立刻報名',
                          fontSize: 16,
                          onPressed: (){}
                        )
                      ),
                    ]
                  )
              ), 
              SizedBox(width: 1120,height: 40,),
              Container(
                child: child,
              )
            ]
          ),
      )
      )
    );
  }
}