import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_event.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_state.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

class AdminOverviewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if(authState is Authenticated && authState.usertype == 'admin'){
      return BlocProvider<OverviewBloc>(
      create: (context) => sl()..add(getOverviewEvent()),
      child: BasicScaffold(
              child: _buildBody(context)
            )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }
  
  Widget _buildBody(BuildContext context){
    return BlocListener<OverviewBloc, OverviewState>(
      listener: (context, state){

      },
      child: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state){
          if(state is OverviewLoaded){
            return SizedBox(
              width: 1120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text('總覽', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('使用者管理', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Wrap(
                    spacing: 8,
                    runSpacing: 16,
                    children: [
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('總使用者', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.totaluser}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('學生', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.studentAmount}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('參賽者', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.attendeeAmount}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('指導教授/顧問', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.teacherAmount}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('講師', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.lecturerAmount}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('評審', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.judgeAmount}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 20,),
                  Text('參賽隊伍管理', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Wrap(
                    spacing: 8,
                    children: [
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('總參賽隊伍', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.totalTeam}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF76C919),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF76C919),
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('已審核', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.verified}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color:  Color(0xFFF96D4E),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF96D4E),
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('待審核', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.needVerify}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFD2F1FF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFD2F1FF),
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('待補件', style: TextStyle(fontSize: 16),),
                            Text('${state.adminOverview.needReAttached}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        }
      )      
    );    
  }
}