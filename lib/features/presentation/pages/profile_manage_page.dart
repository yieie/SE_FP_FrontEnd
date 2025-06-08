import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:front_end/features/domain/entity/identity/Judge.dart';
import 'package:front_end/features/domain/entity/identity/Lecturer.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_bloc.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_event.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_dropdownButtonFormField.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';

class ProfileManagePage extends StatefulWidget {

  const ProfileManagePage({super.key});

  @override
  _ProfileManagePageState createState() => _ProfileManagePageState();
}

class _ProfileManagePageState extends State<ProfileManagePage>{
  final TextEditingController _nameCtrl = TextEditingController();
  String? _sexualCtrl='';
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  String? _studepartmentCtrl='';
  String? _stugradeCtrl='';
  final TextEditingController _departmentCtrl = TextEditingController();
  final TextEditingController _organizationCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  bool _readonly=true;
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if(authState is Authenticated){
      return BlocProvider<ProfileManageBloc>(
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
    return BlocListener<ProfileManageBloc,ProfileManageState>(
      listener: (context,state){
        if(state is ProfileError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
        if(state is ProfileEditting){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('修改個人資訊中'),
            ),
          );
        }
        if(state is ProfileSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('修改成功'),
            ),
          );
          final authState = context.read<AuthBloc>().state;
          if(authState is Authenticated){
            context.read<ProfileManageBloc>().add(SearchUserbyUID(uid: authState.uid));
          }
          _readonly=  true;
        }
        if(state is ProfileLoaded){
          setState(() {
            _nameCtrl.text = state.user.name!;
            _sexualCtrl = state.user.sexual!;
            _phoneCtrl.text = state.user.phone!;
            _emailCtrl.text = state.user.email!;

            if((usertype == 'student' || usertype == 'attendee') && state.user is Student){
              final stu = state.user as Student;
              _studepartmentCtrl = stu.department;
              _stugradeCtrl = stu.grade;
            }
            if(usertype == 'judge'){
              final judge = state.user as Judge;
              _titleCtrl.text = judge.title!;
            }
            if(usertype == 'lecturer'){
              final lecturer = state.user as Lecturer;
              _titleCtrl.text = lecturer.title!;
            }
            if(usertype == 'teacher'){
              final teacher = state.user as Teacher;
              _departmentCtrl.text = teacher.department!;
              _organizationCtrl.text = teacher.organization!;
              _titleCtrl.text = teacher.title!;
            }
          });
        }
      },
      child: BlocBuilder<ProfileManageBloc,ProfileManageState>(
        builder: (context,state){
          if(state is ProfileEditting){
            return const Center(child: CupertinoActivityIndicator());
          }
          if(state is ProfileLoaded){
            return Container(
              margin: EdgeInsets.only(top: 20),
              width: 1120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('個人資訊',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      if(_readonly)
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: BasicWebButton(
                            onPressed: (){
                              setState(() {
                                _readonly = false;
                              });
                            },
                            title: '編輯個人檔案',
                            fontSize: 16,
                          ),
                        )
                      else
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: BasicWebButton(
                            onPressed: (){
                              print(_sexualCtrl);
                              if(state.user is Student){
                                context.read<ProfileManageBloc>().add(
                                  EditProfileEvent(original: state.user, name: _nameCtrl.text, sexual: _sexualCtrl!, phone: _phoneCtrl.text, email: _emailCtrl.text,
                                                  department: _studepartmentCtrl,grade: _stugradeCtrl)
                                );
                              }else{
                                context.read<ProfileManageBloc>().add(
                                  EditProfileEvent(original: state.user, name: _nameCtrl.text, sexual: _sexualCtrl!, phone: _phoneCtrl.text, email: _emailCtrl.text,
                                                  department: _departmentCtrl.text,organization: _organizationCtrl.text,title: _titleCtrl.text)
                                );
                              }
                            },
                            title:'確定變更',
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
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
                                readOnly: _readonly,
                                controller: _nameCtrl
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
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
                              child: _readonly ? TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withAlpha(30),
                                  border: InputBorder.none, 
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                readOnly: _readonly,
                                controller: TextEditingController(text: state.user.sexual)
                              ): BasicWebDropdownbuttonFormField(
                                value: _sexualCtrl,
                                items: <String>['男','女'].map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                }).toList(),
                                hint: Text("性別"),
                                onChanged: (value) {
                                  _sexualCtrl = value;
                                },
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
                                readOnly: _readonly,
                                controller: _phoneCtrl
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
                                readOnly: _readonly,
                                controller: _emailCtrl
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
        width: 300,
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
              child: _readonly ? TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: _readonly,
                controller: TextEditingController(text: student.department)
              ):BasicWebDropdownbuttonFormField(
                value: _studepartmentCtrl,
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    enabled: false,
                    child: Text('人文社會科學院', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  ...HumanitiesAndSocialSciences.map((department) => DropdownMenuItem<String>(
                    value: department,
                    child: Text(department)
                  )),
                  const DropdownMenuItem<String>(
                    value: null,
                    enabled: false,
                    child: Text('法學院', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  ...Law.map((department) => DropdownMenuItem<String>(
                    value: department,
                    child: Text(department)
                  )),
                  const DropdownMenuItem<String>(
                    value: null,
                    enabled: false,
                    child: Text('管理學院', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  ...Management.map((department) => DropdownMenuItem<String>(
                    value: department,
                    child: Text(department)
                  )),
                  const DropdownMenuItem<String>(
                    value: null,
                    enabled: false,
                    child: Text('理學院', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  ...Science.map((department) => DropdownMenuItem<String>(
                    value: department,
                    child: Text(department)
                  )),
                  const DropdownMenuItem<String>(
                    value: null,
                    enabled: false,
                    child: Text('工學院', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  ...Enginerring.map((department) => DropdownMenuItem<String>(
                    value: department,
                    child: Text(department)
                  )),
                ],
                hint: Text("系所"),
                onChanged: (value) {
                  setState(() {
                    _studepartmentCtrl = value;
                  });
                },
            )
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
              child: _readonly ? TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                readOnly: _readonly,
                controller: TextEditingController(text: student.grade)
              ): BasicWebDropdownbuttonFormField(
                value: _stugradeCtrl,
                items: grade.map((grade) => DropdownMenuItem<String>
                (
                  value: grade,
                  child: Text(grade)
                )).toList(), 
                hint: Text('年級'),
                onChanged: (value){
                  setState(() {
                    _stugradeCtrl = value;
                  });
                }
              ),
            ),
          ],
        ),
      ),
      if(student is Attendee)
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
            
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      // color: Color(0xffd9d9d9),
                      border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(8)
                      ),
                    ),
                    child: Text('學生證',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Image.network(student.studentCard!,height: 200,)
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
              readOnly: _readonly,
              controller: _titleCtrl
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
              readOnly: _readonly,
              controller: _titleCtrl
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
                readOnly: _readonly,
                controller: _organizationCtrl
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
                readOnly: _readonly,
                controller:_departmentCtrl
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
                readOnly: _readonly,
                controller: _titleCtrl
              ),
            ),
          ],
        ),
      )
    ];
  }
}