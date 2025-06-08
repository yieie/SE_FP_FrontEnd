import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/domain/entity/identity/Judge.dart';
import 'package:front_end/features/domain/entity/identity/Lecturer.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_bloc.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_event.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

class ProfileManagePage extends StatefulWidget {

  const ProfileManagePage({super.key});

  @override
  _ProfileManagePageState createState() => _ProfileManagePageState();
}

class _ProfileManagePageState extends State<ProfileManagePage>{
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if(authState is Authenticated){
      return BlocProvider<SearchUserBloc>(
        create: (context) => sl()..add(SearchUserbyUID(uid: authState.uid)),
        child: BasicScaffold(
          child: _buildbody(authState.usertype!,context)
        )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }

  Widget _buildbody(String usertype,BuildContext context){
    return BlocListener<SearchUserBloc,SearchUserState>(
      listener: (context,state){
        if(state is SearchError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
      },
      child: BlocBuilder<SearchUserBloc,SearchUserState>(
        builder: (context,state){
          if(state is SearchDone){
            return Container(
              margin: EdgeInsets.only(top: 20),
              width: 1120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('個人資訊',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Wrap(
                    spacing: 8.0, 
                    runSpacing: 16.0, 
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)
                                ),
                              ),
                              child: Text('帳號/學號',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text:state.user.uid)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)
                                ),
                              ),
                              child: Text('姓名',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text:state.user.name)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)
                                ),
                              ),
                              child: Text('性別',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text:state.user.sexual)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)
                                ),
                              ),
                              child: Text('電話',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text:state.user.phone)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)
                                ),
                              ),
                              child: Text('電子郵件',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text:state.user.email)
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(usertype == 'student' && state.user is Student)..._buildStudetField(state.user as Student),
                      if(usertype == 'judge')
                        _buildJudgeField(state.user as Judge),
                      if(usertype == 'lecturer')
                        _buildLecturerField(state.user as Lecturer),
                      if(usertype == 'teacher')..._buildTeahcerField(state.user as Teacher)
                    ],
                  ),                    
                ],
              ),
            );
          }
          return SizedBox();
        }
      ),
    );
  }

  List<Widget> _buildStudetField(Student student){
    return [
      Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                ),
              ),
              child: Text('系所',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: true,
                controller: TextEditingController(text:student.department)
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                ),
              ),
              child: Text('年級',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: true,
                controller: TextEditingController(text:student.grade)
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildJudgeField(Judge judge){
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
        
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.black)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              ),
            ),
            child: Text('頭銜',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withAlpha(30),
                border: InputBorder.none, 
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              readOnly: true,
              controller: TextEditingController(text:judge.title)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLecturerField(Lecturer lecturer){
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
        
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.black)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              ),
            ),
            child: Text('頭銜',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withAlpha(30),
                border: InputBorder.none, 
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              readOnly: true,
              controller: TextEditingController(text:lecturer.title)
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTeahcerField(Teacher teacher){
    return [
      Container(
        width: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                ),
              ),
              child: Text('單位/任職機構',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: true,
                controller: TextEditingController(text:teacher.organization)
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                ),
              ),
              child: Text('系所',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: true,
                controller: TextEditingController(text:teacher.department)
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                ),
              ),
              child: Text('頭銜',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: true,
                controller: TextEditingController(text:teacher.title)
              ),
            ),
          ],
        ),
      )
    ];
  }
}