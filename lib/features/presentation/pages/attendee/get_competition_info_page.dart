import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_event.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

class GetCompetitionInfoPage extends StatefulWidget {
  const GetCompetitionInfoPage({super.key});

  @override
  _GetCompetitionInfoPageState createState() => _GetCompetitionInfoPageState();
}

class _GetCompetitionInfoPageState extends State<GetCompetitionInfoPage>{
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<GetCompetitionInfoBloc>(
      create: (context) => sl()..add(GetInfoByUIDEvent(authState.uid)),
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
    return BlocBuilder<GetCompetitionInfoBloc, GetCompetitionInfoState>(
      builder:(context, state){
        if(state is InfoLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is InfoError){
          return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
        }
        if(state is InfoLoaded){
          //呈現學生的隊伍資訊
        }
        return SizedBox();
      }
    
    );
  }

}