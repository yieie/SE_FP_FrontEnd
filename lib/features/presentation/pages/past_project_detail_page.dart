import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/past_project_bloc.dart';
import 'package:front_end/features/presentation/bloc/past_project_event.dart';
import 'package:front_end/features/presentation/bloc/past_project_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class PastProjectDetailPage extends StatefulWidget {
  final String teamid;
  const PastProjectDetailPage({super.key,required this.teamid});

  @override
  State<PastProjectDetailPage> createState() => _PastProjectDetailPageState();
}

class _PastProjectDetailPageState extends State< PastProjectDetailPage> {

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
    return BlocProvider<PastProjectBloc>(
      create: (context) => sl()..add(GetPastProjectDetailbyTeamIDEvent(teamid: widget.teamid)),
      child: BasicScaffold(
          child: _buildBody(context)
        )
      );
  }

  Widget _buildBody(BuildContext context){
    return BlocListener<PastProjectBloc, PastProjectState>(
      listener: (context, state){
         if(state is PastProjectError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
        if(state is PastProjectLoading){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('載入中'),
            ),
          );
        }
      },
      child: BlocBuilder<PastProjectBloc, PastProjectState>(
        builder: (context, state){
          if(state is PastProjectDetailLoaded){
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
                  // Container(
                  //   margin: EdgeInsets.all(5),
                  //   child: Text("名次：${state.teamWithProject.team.rank == -1 ? '無' : state.teamWithProject.team.rank}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  // ),
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
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, 
                      ),
                      child: Text('${widget.teamid}作品說明書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.affidavitFile!, '_blank');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, 
                      ),
                      child: Text('${widget.teamid}提案切結書'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:TextButton(
                      onPressed: () {
                        web.window.open(state.teamWithProject.project.consentFile!, '_blank');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, 
                      ),
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