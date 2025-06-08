import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_event.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class ProjectViewDetailPage extends StatefulWidget{
  final String teamid;
  const ProjectViewDetailPage({super.key, required this.teamid});

  @override
  _ProjectViewDetailPageState createState() => _ProjectViewDetailPageState();
}

class _ProjectViewDetailPageState extends State<ProjectViewDetailPage>{

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟連結：$url';
    }
  }

  Future<Map<String, dynamic>?> _showInputDialog(BuildContext context) async {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    final TextEditingController controller4 = TextEditingController();
    String? errorText;

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('請輸入評分'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('創新與特色：35%'),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller1,
                    ),
                    Text('實用價值與技術、服務獨特性：35%'),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller2,
                    ),
                    Text('創意實作可行性：25%'),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller3,
                    ),
                    Text('其他：5%'),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller4,
                    ),
                    if (errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          errorText!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext), // 回傳 null
                  child: Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    if ([controller1, controller2, controller3, controller4]
                        .any((c) => c.text.trim().isEmpty)) {
                      setState(() {
                        errorText = '所有欄位都要填寫';
                      });
                      return;
                    }

                    Navigator.pop(dialogContext, {
                      'score1': int.parse(controller1.text),
                      'score2': int.parse(controller2.text),
                      'score3': int.parse(controller3.text),
                      'score4': int.parse(controller4.text),
                    });
                  },
                  child: Text('確認'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<ScoreTeamBloc>(
      create: (context) => sl()..add(LoadTeamInfoEvent(teamid: widget.teamid)),
      child: BasicScaffold(
              child: _buildBody(context)
            )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }

  Widget _buildBody(context){
    return BlocListener<ScoreTeamBloc, ScoreTeamState>(
      listener: (context, state){
         if(state is ScoreFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
        if(state is ScoreSubmit){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('送出評分中'),
            ),
          );
        }
        if(state is ScoreSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('評分成功，將重導至評分列表'),
            ),
          );
          context.go('projectViewList/1');
        }
      },
      child: BlocBuilder<ScoreTeamBloc, ScoreTeamState>(
        builder: (context, state){
          if(state is ScoreLoaed){
            final ScrollController _scrollController = ScrollController();
            final memberList = state.teamWithProject.team.members!.map((e) => '${e.department} ${e.name}').join('\t');
            final yturl = state.teamWithProject.project.url!.firstWhere(
                          (url) => url.contains('youtube.com') || url.contains('youtu.be'),
                          orElse: () => '',
                        );
            final githuburl = state.teamWithProject.project.url!.firstWhere(
                            (url) => url.contains('github.com'),
                            orElse: () => '',);
            final List<int> sdgs = state.teamWithProject.project.sdgs!.split(',').map((e) => int.parse(e.trim())).toList();
            return SizedBox(
              width: 1120,
              child: Column(
                children: [
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: BasicWebButton(
                      onPressed: () async {
                        final result = await _showInputDialog(context);
                      },
                      title: '評分',
                      backgroundColor: Color(0xFFF96D4E),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("參賽組別：${state.teamWithProject.team.type}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("團隊名稱：${state.teamWithProject.team.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("隊員：$memberList",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("指導教授：${state.teamWithProject.team.teacher!.organization}${state.teamWithProject.team.teacher!.department} ${state.teamWithProject.team.teacher!.name}${state.teamWithProject.team.teacher!.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("作品名稱：${state.teamWithProject.project.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("作品摘要：${state.teamWithProject.project.abstract}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Youtube影片'),
                        TextButton(
                          onPressed: () => _launchURL(yturl),
                          child: Text(yturl),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('GitHub連結'),
                        TextButton(
                          onPressed: () => _launchURL(githuburl),
                          child: Text(githuburl),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('SDGs:'),
                        Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true, 
                          trackVisibility: true, 
                          interactive: true,
                          thickness: 6,          
                          radius: Radius.circular(4),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                            children: sdgsList.map((sdg) {
                              final had = sdgs.contains(sdg.id);
                                return SizedBox(
                                  height: 100,
                                  child: had ? Image.asset(sdg.imagePath,width: 100,height: 100): null,
                                );
                            }).toList(),
                            )
                          )
                        )
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("相關文件",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.introductionFile!, '_blank');
                      },
                      child: Text('${state.teamWithProject.project.workID}作品說明書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.affidavitFile!, '_blank');
                      },
                      child: Text('${state.teamWithProject.project.workID}提案切結書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.consentFile!, '_blank');
                      },
                      child: Text('${state.teamWithProject.project.workID}個資同意書'),
                    ),
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
}
