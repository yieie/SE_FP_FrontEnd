
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/domain/entity/SignInReqParams.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_event.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_in_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_in_event.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_in_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  final TextEditingController accountCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool _obscurepasswd = true;

  @override
  void dispose() {
    accountCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(sl()),
      child: BasicScaffold(
        child: _buildBody(context)
      )
    );
  }

  _buildBody(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInBloc,SignInState>(
          listener: (context, state){
            if(state is SignInSuccess){
                context.read<AuthBloc>().add(LoggedIn(usertype: state.responseMessage!.extraData?['userType'], uid: accountCtrl.text));
            }
          }          
        ),
        BlocListener<AuthBloc,AuthState>(
          listener: (context,state){
            if(state is Authenticated){
              if(state.usertype == 'judge'){
                context.go('/projectViewList/1');
              }else{
                context.go('/homeWithAnn/1');
              }
            }
          }
        )
      ],
      child:BlocBuilder<SignInBloc,SignInState>(
      builder: (context,state){

        
        if(state is SignInLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is SignInError){
          return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
        }
        if(state is SignInInitial || state is SignInFail){
          return Column(
            children: [
              _buildSignUpForm(context),
              if(state is SignInFail)
                Text("帳號或密碼錯誤",style: TextStyle(color: Colors.red),)
            ],
          );
        }
        return SizedBox();
      }
    )
    );
  }

  _buildSignUpForm(BuildContext context){
    return SizedBox(
      width: 1120,
      child: Column(
        children: [
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Icon(Icons.person,size: 150,color: Colors.grey.shade800)
              ),
              
              Column(
                children: [
                  _accountField(),
                  SizedBox(height: 32),
                  _passwordField()
                ],
              )
            ],
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 48,
                child: BasicWebButton(
                  title: '登入',
                  onPressed: (){
                    final signinReq = SignInReqParams(
                      account: accountCtrl.text, 
                      password: passwordCtrl.text);
                    context.read<SignInBloc>().add(SubminSignIn(signinReq));
                  }
                )
              )
            ],
          )
          
        ],
      ),

    );
  }

  Widget _accountField(){
    return SizedBox(
      width: 448,
      height: 56,
      child: TextField(
        controller: accountCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText:  '帳號'
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
}


