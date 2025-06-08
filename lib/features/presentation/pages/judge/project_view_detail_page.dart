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
  final String workid;
  final double score;
  const ProjectViewDetailPage({super.key, required this.teamid,required this.workid,required this.score});

  @override
  _ProjectViewDetailPageState createState() => _ProjectViewDetailPageState();
}

class _ProjectViewDetailPageState extends State<ProjectViewDetailPage>{
  double score1=-1;
  double score2=-1;
  double score3=-1;
  double score4=-1;
  double totalScore=-1;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟連結：$url';
    }
  }

  Future<Map<String, dynamic>?> _showInputDialog(BuildContext context,String teamType) async {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(teamType == '創意發想組' ? '創新與特色：35%' : '產品及服務內容創新性：35%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller1,
                    ),
                    SizedBox(height: 10,),
                    Text(teamType == '創意發想組'?'實用價值與技術、服務獨特性：35%':'市場可行性：35%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller2,
                    ),
                    SizedBox(height: 10,),
                    Text(teamType == '創意發想組'?'創意實作可行性：25%':'未來發展性：25%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '請輸入數字'),
                      controller: controller3,
                    ),
                    SizedBox(height: 10,),
                    Text('其他：5%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                    final scores = [
                      int.tryParse(controller1.text),
                      int.tryParse(controller2.text),
                      int.tryParse(controller3.text),
                      int.tryParse(controller4.text),
                    ];

                    if (scores.any((s) => s == null)) {
                      setState(() {
                        errorText = '所有欄位都要填寫且必須是數字';
                      });
                      return;
                    }

                    if (scores.any((s) => s! < 0 || s > 100)) {
                      setState(() {
                        errorText = '每個分數必須在 0 到 100 之間';
                      });
                      return;
                    }

                    Navigator.pop(dialogContext, {
                      'score1': scores[0],
                      'score2': scores[1],
                      'score3': scores[2],
                      'score4': scores[3],
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

  Widget _buildBody(BuildContext context){
    final authState = context.read<AuthBloc>().state;
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
          context.go('/projectViewList/1');
        }
      },
      child: BlocBuilder<ScoreTeamBloc, ScoreTeamState>(
        builder: (context, state){
          if(state is ScoreLoaed){
            final ScrollController _scrollController = ScrollController();
            final teamType = state.teamWithProject.team.type;
            final memberList = state.teamWithProject.team.members!.map((e) => '${e.department} ${e.name}').join('\t');
            final String? yturl = state.teamWithProject.project.url!.firstWhere(
                          (url) => url.contains('youtube.com') || url.contains('youtu.be'),
                          orElse: () => '',
                        );
            final String? githuburl = state.teamWithProject.project.url!.firstWhere(
                            (url) => url.contains('github.com'),
                            orElse: () => '',);
            final List<int> sdgs = state.teamWithProject.project.sdgs!.split(',').map((e) => int.parse(e.trim())).toList();
            
            return SizedBox(
              width: 1120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(score1 != -1 && score2 != -1 && score3 != -1 && score4 != -1)
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(teamType == '創意發想組' ? 
                          '創新與特色：$score1 / 35%\t\t'
                          '實用價值與技術、服務獨特性：$score2 / 35%' 
                          '\n創意實作可行性：$score3 / 25%\t\t'
                          '其他：$score4 / 5%'  
                          :
                          '產品及服務內容創新性：$score1 / 35%\n'
                          '市場可行性：$score2 / 35%' 
                          '\n未來發展性：$score3 / 25%\t\t'
                          '其他：$score4 / 5%'
                          ,style: TextStyle(fontSize: 16)),
                        ),
                      if(totalScore != -1 || widget.score != -1)
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text('總分：${totalScore == -1 ? widget.score : totalScore}',style: TextStyle(fontSize: 20))
                        ),
                      if(score1 != -1 && score2 != -1 && score3 != -1 && score4 != -1)
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: BasicWebButton(
                            onPressed: () {
                              if(authState is Authenticated){
                                context.read<ScoreTeamBloc>().add(SubmitScoreEvent(score: totalScore, workid: widget.workid, judgeid: authState.uid ));
                              }
                            },
                            title: '送出評分',
                            fontSize: 16,
                          ),
                        ),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: BasicWebButton(
                          onPressed: () async {
                            final result = await _showInputDialog(context,teamType!);
                            if (result != null) {
                              print("使用者輸入了：$result");
                              setState(() {
                                score1 = double.parse((result['score1'] * 0.35).toStringAsFixed(2));
                                score2 = double.parse((result['score2'] * 0.35).toStringAsFixed(2));
                                score3 = double.parse((result['score3'] * 0.25).toStringAsFixed(2));
                                score4 = double.parse((result['score4'] * 0.05).toStringAsFixed(2));
                                totalScore = score1+score2+score3+score4;
                              });
                            }else{
                              print('使用者沒有輸入分數');
                            }
                          },
                          title: totalScore == -1 ? '評分' : '再次評分',
                          backgroundColor: Color(0xFFF96D4E),
                          fontSize: 16,
                        ),
                      ),
                  ]),
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
                          onPressed: () => yturl != null ? _launchURL(yturl) : null,
                          child: Text(yturl ?? '無YT'),
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
                          onPressed: () => githuburl != null ? _launchURL(githuburl) : null,
                          child: Text(githuburl ?? '無github'),
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
                      child: Text('${widget.teamid}作品說明書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.affidavitFile!, '_blank');
                      },
                      child: Text('${widget.teamid}提案切結書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.consentFile!, '_blank');
                      },
                      child: Text('${widget.teamid}個資同意書'),
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
