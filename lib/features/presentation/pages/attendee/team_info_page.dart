import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_event.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class TeamInfoPage extends StatefulWidget {
  final String uid;
  const TeamInfoPage({super.key,required this.uid});

  @override
  State<TeamInfoPage> createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟連結：$url';
    }
  }


  String _selectedTab = '隊伍資料'; //當前選中的

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
    final authState = context.read<AuthBloc>().state;
    return BlocListener<GetCompetitionInfoBloc, GetCompetitionInfoState>(
    listener: (context,state){
      if(state is InfoError){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(handleDioError(state.error)),
          ),
        );
      }
      if(state is InfoLoading){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('載入中'),
          ),
        );
      }
    },
    child: BlocBuilder<GetCompetitionInfoBloc, GetCompetitionInfoState>(
      builder:(context, state){
        if(state is InfoLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is InfoLoaded){
          return Container(
            constraints: BoxConstraints(maxWidth: 1120),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "隊伍狀態: ${state.info.project.state!}",
                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                
                    if(state.info.project.state == '需補件')                      
                      if(authState is Authenticated)
                        if(authState.uid.toLowerCase() == state.info.team.members![0].uid!.toLowerCase())
                          SizedBox(
                            width: 200,
                            height: 40,
                            child: BasicWebButton(
                              onPressed: (){
                                context.go('/editCompetitionInfo');
                              },
                              backgroundColor: Color(0xFFF96D4E),
                              title: '編輯資訊',
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
                
                const SizedBox(height: 10),
                if(state.info.project.state == '需補件')
                  Text('需補件原因：${state.info.project.message}',style: const TextStyle(fontSize: 16),),
                const SizedBox(height: 10),
                
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _selectedTab = '隊伍資料'),
                      child: Container(
                        alignment: Alignment.center,
                        width: 540,
                        height: 40,
                        decoration: _selectedTab == '隊伍資料' ?  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              const Color.fromRGBO(254, 228, 37, 1),
                              const Color.fromRGBO(250, 186, 86, 1),
                            ],
                          ),
                        ):null,
                        child: Text(
                          "隊伍資料",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: _selectedTab == '隊伍資料' ? FontWeight.bold:FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: () => setState(() => _selectedTab = '隊員暨指導老師資料'),
                      child: Container(
                        alignment: Alignment.center,
                        width: 540,
                        height: 40,
                        decoration:_selectedTab == '隊員暨指導老師資料' ? BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              const Color.fromRGBO(254, 228, 37, 1),
                              const Color.fromRGBO(250, 186, 86, 1),
                            ],
                          ),
                        ):null,
                        child: Text(
                          "隊員暨指導老師資料",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: _selectedTab == '隊員暨指導老師資料' ? FontWeight.bold:FontWeight.normal,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                //分隔線
                Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                ),
                
                //內容部分
                if (_selectedTab == '隊伍資料') 
                  _buildTeamInfoContent(state.info),
                
                if (_selectedTab == '隊員暨指導老師資料') 
                  _buildMemberInfoContent(state.info),
              ],
            ),
          );
        }
        return SizedBox();
      }
    ));
  }


  // 隊伍資料內容
  Widget _buildTeamInfoContent(TeamWithProject teamwithproject) {
    final ScrollController _scrollController = ScrollController();
    final List<int> sdgs = teamwithproject.project.sdgs!.split(',').map((e) => int.parse(e.trim())).toList();

    final String? yturl = teamwithproject.project.url!.firstWhere(
                  (url) => url.contains('youtube.com') || url.contains('youtu.be'),
                  orElse: () => '',
                );
    final String? githuburl = teamwithproject.project.url!.firstWhere(
                    (url) => url.contains('github.com'),
                    orElse: () => '',);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 參賽組別：
                  _buildInfoRow("參賽組別：", teamwithproject.team.type!),
                  const SizedBox(height: 10),
                  
                  // 團隊名稱
                  _buildInfoRow("團隊名稱:", teamwithproject.team.name!),
                  const SizedBox(height: 10),
                  
                  // 作品名稱
                  _buildInfoRow("作品名稱:", teamwithproject.project.name!),
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
                      Text(teamwithproject.project.abstract!),
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
                          web.window.open(teamwithproject.project.introductionFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('作品說明書(點擊查看)'),
                      ),
                      TextButton(
                        onPressed: () {
                          web.window.open(teamwithproject.project.affidavitFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('提案切結書(點擊查看)'),
                      ),
                      TextButton(
                        onPressed: () {
                          web.window.open(teamwithproject.project.consentFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('個資同意書(點擊查看)'),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 隊員暨指導老師資料內容
  Widget _buildMemberInfoContent(TeamWithProject teamwithproject) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //指導老師部分
                  _buildPlainSection([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            "指導老師/顧問:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(flex: 2, child: _buildInfoRow("姓名:", teamwithproject.team.teacher!.name!)),
                            Expanded(flex: 2, child: _buildInfoRow("職稱:", teamwithproject.team.teacher!.title!)),
                            Expanded(flex: 3, child: _buildInfoRow("所屬機構:", teamwithproject.team.teacher!.organization! + teamwithproject.team.teacher!.department!)),
                          ],
                        ),
                      ],
                    ),
                  ]),

                  //隊員列表
                  _buildPlainSection([
                    for (int i = 0; i < teamwithproject.team.members!.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              i == 0 ? "隊員${i + 1}(代表人):" : "隊員${i + 1}:",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: _buildInfoRow("姓名:", teamwithproject.team.members![i].name!)),
                              Expanded(flex: 2, child: _buildInfoRow("學號:", teamwithproject.team.members![i].uid!)),
                              Expanded(flex: 2, child: _buildInfoRow("年級:", teamwithproject.team.members![i].grade!)),
                              Expanded(flex: 3, child: _buildInfoRow("科系:", teamwithproject.team.members![i].department!)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: _buildInfoRow("電話:", teamwithproject.team.members![i].phone!)),
                              Expanded(flex: 7, child: _buildInfoRow("Email:", teamwithproject.team.members![i].email!)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          //學生證
                          Text('學生證',style: const TextStyle(fontWeight: FontWeight.bold),),
                          Image.network(teamwithproject.team.members![i].studentCard!,width: 500,),
                          const SizedBox(height: 10),

                        ],
                      ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget _buildPlainSection(List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    ],
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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