import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_event.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_state.dart';
import 'package:front_end/features/presentation/widget/attendee/build_teacher_with_file.dart';
import 'package:front_end/features/presentation/widget/attendee/build_team_Basic_Info.dart';
import 'package:front_end/features/presentation/widget/attendee/build_team_member_info.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';

//TODO: 驗證各欄位有效性 e.g. email、yt網址 等

class EditCompetitionPage extends StatefulWidget {
  const EditCompetitionPage({super.key});

  @override
  _EditCompetitionPageState createState() => _EditCompetitionPageState();
}

class _EditCompetitionPageState extends State<EditCompetitionPage>{

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<SignUpCompetitionBloc>(
      create: (context) => sl()..add(LoadTeamInfoEvent(authState.uid)),
      child: BasicScaffold(
              child: _buildBody(context)
            )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }

  Widget _buildBody(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
  return BlocListener<SignUpCompetitionBloc, SignUpCompetitionState>(
    listener: (context, state) {
      if(state.status == SubmissionStatus.failure){
        if(state.error != null){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error!)),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
        context.read<SignUpCompetitionBloc>().add(ResetSubmissionStatus());
      }
      if(state.status == SubmissionStatus.submitting){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('送出報名中'),
          ),
        );
      }
      if(state.status == SubmissionStatus.success){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('報名成功'),
          ),
        );
      }
    },
    child: BlocBuilder<SignUpCompetitionBloc, SignUpCompetitionState>(
      builder: (context, state) {
        return SizedBox(
          width: 1120,
          child: Column(
            children: [
              SizedBox(height: 16),
              buildStepIndicator(state.currentPage),
              SizedBox(height: 16),

              if (state.currentPage == 0) buildTeamBasicInfo(context, state,editmode: true),
              if (state.currentPage == 1) buildTeamMemberInfo(context, state,editmode: true),
              if (state.currentPage == 2) buildTeacherInfoWithFiles(context, state,editmode: true),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (state.currentPage > 0)
                    BasicWebButton(
                      onPressed: () =>
                          context.read<SignUpCompetitionBloc>().add(GoToPreviousPage()),
                      title: '上一頁',
                      fontSize: 16,
                      backgroundColor: Color(0xFFD9D9D9),
                      textColor: Colors.black,
                      width: 60,
                      height: 40,
                    ),
                  if (state.currentPage < 2)
                    BasicWebButton(
                      onPressed: () =>
                          context.read<SignUpCompetitionBloc>().add(GoToNextPage()),
                      title: '下一頁',
                      fontSize: 16,
                      backgroundColor: Color(0xFFD9D9D9),
                      textColor: Colors.black,
                      width: 60,
                      height: 40,
                    ),
                  if (state.currentPage == 2)
                    BasicWebButton(
                      onPressed: () => authState is Authenticated ? context
                          .read<SignUpCompetitionBloc>()
                          .add(EditCompetitionFormEvent(authState.uid)):null,
                      title: '送出修改',
                      fontSize: 16,
                      width: 60,
                      height: 40,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}


  Widget buildStepIndicator(int currentPage) {
    final steps = ['隊伍作品資訊', '隊員資訊', '指導老師暨檔案資料'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final isActive = index == currentPage;

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? Color(0xFF76C919) : Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                steps[index],
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (index != steps.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.chevron_right, size: 16),
              ),
          ],
        );
      }),
    );
  }
}