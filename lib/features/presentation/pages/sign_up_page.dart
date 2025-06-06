
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_up_event.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_dropdownButtonFormField.dart';
import 'package:front_end/injection_container.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_up_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController studentIDCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordCheckCtrl = TextEditingController();
  String? _errorMessage;
  bool _obscurepasswd = true;
  bool _obscurepasswdcheck = true;

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    studentIDCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    passwordCheckCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(sl()),
      child: BasicScaffold(
        child: _buildBody(context)
      )
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<SignUpBloc,SignUpState>(
      builder: (context,state){
        if(state is SignUpLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is SignUpFailure){
          return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
        }
        if(state is SignUpInitial){
          return _buildSignUpForm(context);
        }
        return const SizedBox();
      }
    );
  }

  _buildSignUpForm(BuildContext context){
    return Container(
      width: 1120,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 96),
            alignment: Alignment.centerLeft,
            child: Text("註冊帳號以進行更多操作！",
            style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             letterSpacing: 6.4 
            )),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _firstNameField(),
              SizedBox(width: 32),
              _lastNameField(),
              SizedBox(width: 32),
              _sexualField(context)
            ],
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _studentIDField(),
              SizedBox(width: 32),
              _departmentField(context),
              SizedBox(width: 32),
              _gradeField(context)
            ],
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              SizedBox(width: 32),
              _phoneField()
            ]
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _passwordField(),
              SizedBox(width: 32),
              _passwordcheckField()
            ]
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 48,
                child: BasicWebButton(
                  title: '註冊',
                  onPressed: (){
                    final state = context.read<SignUpBloc>().state;
                    final sexual = state.signupReq.sexual;
                    final deparment = state.signupReq.department;
                    final grade = state.signupReq.grade;
                    final signupReq = SignupReqParams(
                      uid: studentIDCtrl.text,
                      password: passwordCtrl.text,
                      name: firstNameCtrl.text + lastNameCtrl.text,
                      email: emailCtrl.text,
                      sexual: sexual,
                      phone: phoneCtrl.text,
                      department: deparment,
                      grade: grade
                    );

                    context.read<SignUpBloc>().add(SubmitSignUp(signupReq));
                  }
                )
              )
            ],
          )
          
        ],
      ),

    );
  }

  Widget _firstNameField(){
    return SizedBox(
      width: 352,
      height: 56,
      child: TextField(
        controller: firstNameCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '姓'
        ),
    ));
  }

  Widget _lastNameField(){
    return SizedBox(
      width: 352,
      height: 56,
      child: TextField(
        controller: lastNameCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
          hintText:  '名'
        ),
    ));
  }

  Widget _sexualField(BuildContext context){
    return SizedBox(
      width: 160,
      height: 56,
      child: BasicWebDropdownbuttonFormField(
        items: <String>['男','女'].map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
        }).toList(),
        hint: Text("性別"),
        onChanged: (value) {
          print(value);
          final state = context.read<SignUpBloc>().state;
          context.read<SignUpBloc>().add(SexualChanged(value));
          print('state: ${state}');
        },
    ));
  }

  Widget _studentIDField(){
    return SizedBox(
      width: 256,
      height: 56,
      child: TextField(
        controller: studentIDCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
          hintText:  '學號'
        ),
    ));
  }

  Widget _departmentField(BuildContext context){
    return SizedBox(
      width: 352,
      height: 56,
      child: BasicWebDropdownbuttonFormField(
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
          context.read<SignUpBloc>().add(DepartmentChanged(value));
        },
    ));
  }

  Widget _gradeField(BuildContext context){
    return SizedBox(
      width: 256,
      height: 56,
      child: BasicWebDropdownbuttonFormField(
        items: grade.map((grade) => DropdownMenuItem<String>
        (
          value: grade,
          child: Text(grade)
        )).toList(), 
        hint: Text('年級'),
        onChanged: (value){
          context.read<SignUpBloc>().add(GradeChanged(value));
        }
      ),
    );
  }

  Widget _emailField(){
    return SizedBox(
      width: 544,
      height: 56,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '電子信箱'
        ),
    ));
  }

  Widget _phoneField(){
    return SizedBox(
      width: 352,
      height: 56,
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: phoneCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '電話'
        ),
    ));
  }

  Widget _passwordField(){
    return SizedBox(
      width: 448,
      height: 56,
      child: TextField(
        obscureText: _obscurepasswd,
        controller: passwordCtrl,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              _obscurepasswd = !_obscurepasswd;
            });
          }, icon: Icon(_obscurepasswd ? Icons.lock_outline_rounded : Icons.lock_open_rounded)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '密碼'
        ),
    ));
  }

  Widget _passwordcheckField(){
    return SizedBox(
      width: 448,
      height: 56,
      child: TextField(
        obscureText: _obscurepasswdcheck,
        controller: passwordCheckCtrl,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              _obscurepasswdcheck = !_obscurepasswdcheck;
            });
          }, icon: Icon(_obscurepasswdcheck ? Icons.lock_outline_rounded : Icons.lock_open_rounded)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '請再次輸入密碼',
          errorText: _errorMessage,
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF96D4E)))
        ),
        onChanged: _validatePasswordMatch,
    ));
  }

  void _validatePasswordMatch(String _) {
    final password = passwordCtrl.text;
    final confirmPassword = passwordCheckCtrl.text;

    setState(() {
      if (confirmPassword.isEmpty || password == confirmPassword) {
        _errorMessage = null;
      } else {
        _errorMessage = '密碼不一致';
      }
    });
  }
}


