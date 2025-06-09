import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_event.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class TeachTeamViewDetailPage extends StatefulWidget {
  final String teamid;
  const TeachTeamViewDetailPage({super.key ,required this.teamid});

  @override
  State<TeachTeamViewDetailPage> createState() => _TeachTeamViewDetailPageState();
}

class _TeachTeamViewDetailPageState extends State<TeachTeamViewDetailPage> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟連結：$url';
    }
  }


  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if(authState is Authenticated){
      return BlocProvider<TeachTeamBloc>(
        create: (context) => sl()..add(GetTeachTeamDetailEvent(widget.teamid)),
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
    return BlocListener<TeachTeamBloc, TeachTeamState>(
      listener: (context, state){
        if(state is TeamError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
        // if(state is TeamLoading){
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('載入中'),
        //     ),
        //   );
        // }
      },
      child: BlocBuilder<TeachTeamBloc, TeachTeamState>(
        builder: (context,state){
          if(state is TeamDetailLoaded){
            final ScrollController _scrollController = ScrollController();
            final String? yturl = state.teamWithProject.project.url!.firstWhere(
                          (url) => url.contains('youtube.com') || url.contains('youtu.be'),
                          orElse: () => '',
                        );
            final String? githuburl = state.teamWithProject.project.url!.firstWhere(
                            (url) => url.contains('github.com'),
                            orElse: () => '',);
            final List<int> sdgs = state.teamWithProject.project.sdgs!.split(',').map((e) => int.parse(e.trim())).toList();
            return Container(
              constraints: BoxConstraints(maxWidth: 1120),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => context.go('/teachTeamViewList/1'), 
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, 
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.chevron_left),
                              Text('返回隊伍列表',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                        ),
                        // 參賽組別
                        _buildInfoRow("參賽類型:", state.teamWithProject.team.type!),
                        const SizedBox(height: 10),
                        
                        // 團隊名稱
                        _buildInfoRow("團隊名稱:", state.teamWithProject.team.name!),
                        const SizedBox(height: 10),
                        
                        // 隊員列表
                        _buildInfoRow(
                          "隊員:",
                          state.teamWithProject.team.members!.map((member) => 
                            "${member.department} ${member.name}"
                          ).join("、"),
                        ),
                        const SizedBox(height: 10),
              
                                    
                        // 指導教授
                        _buildInfoRow(
                          "指導教授:",
                          "${state.teamWithProject.team.teacher!.organization! + state.teamWithProject.team.teacher!.department!} ${state.teamWithProject.team.teacher!.name! + state.teamWithProject.team.teacher!.title!}",
                        ),
                        const SizedBox(height: 10),
                        
                        // 作品名稱
                        _buildInfoRow("作品名稱:", state.teamWithProject.project.name!),
                        const SizedBox(height: 10),
                        
                        // 作品摘要
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "作品摘要:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(state.teamWithProject.project.abstract!),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        // YouTube連結
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Youtube影片'),
                            TextButton(
                              onPressed: () => yturl != null ? _launchURL(yturl) : null,
                              child: Text(yturl ?? '無YT'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        // GitHub連結
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('GitHub連結'),
                            TextButton(
                              onPressed: () => githuburl != null ? _launchURL(githuburl) : null,
                              child: Text(githuburl ?? '無github'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        // SDGs 相關
                        Row(
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
                        ),
                        const SizedBox(height: 10),
                        
                        // 相關文件
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "相關文件:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            TextButton(
                              onPressed: () {
                                web.window.open(state.teamWithProject.project.introductionFile!, '_blank');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, 
                              ),
                              child: Text('${widget.teamid}作品說明書'),
                            ),
                            TextButton(
                              onPressed: () {
                                web.window.open(state.teamWithProject.project.affidavitFile!, '_blank');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, 
                              ),
                              child: Text('${widget.teamid}提案切結書'),
                            ),
                            TextButton(
                              onPressed: () {
                                web.window.open(state.teamWithProject.project.consentFile!, '_blank');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, 
                              ),
                              child: Text('${widget.teamid}個資同意書'),
                            ),
                          ],
                        ),
                      ],
                    ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  
}