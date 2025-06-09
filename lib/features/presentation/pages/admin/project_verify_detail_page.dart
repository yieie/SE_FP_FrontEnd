import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/Team.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_event.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_state.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class ProjectVerifyDetailPage extends StatefulWidget {
  final String teamid;
  const ProjectVerifyDetailPage({super.key,required this.teamid});

  @override
  State<ProjectVerifyDetailPage> createState() => _ProjectVerifyDetailPageState();
}

class _ProjectVerifyDetailPageState extends State<ProjectVerifyDetailPage> {

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟連結：$url';
    }
  }

  final TextEditingController _messageCtrl = TextEditingController();
  String? _errorMessage;
  String? _selectedStatus; 
  final List<String> _statusOptions = ['待審核', '已審核', '需補件'];


  bool _isMemberInfoExpanded = false; // 隊員暨指導老師資料
  bool _isProjectInfoExpanded = false; // 參賽作品詳細資料

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<VertifyTeamBloc>(
      create: (context) => sl()..add(GetVertifyTeamDetailEvent(widget.teamid)),
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
    return BlocListener<VertifyTeamBloc,VertifyTeamState>(
      listener: (context,state){
        if(state is VertifyTeamDetailLoaded){
          setState(() {
            _selectedStatus = state.teamWithProject.project.state!;
          });
        }
        if(state is VertifyTeamSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('修改狀態成功'),
            ),
          );
          context.go('/projectVertifyList/1');
        }
        if(state is VertifyTeamError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
      },
      child: BlocBuilder<VertifyTeamBloc,VertifyTeamState>(
        builder: (context,state){
          if(state is VertifyTeamDetailLoaded){
            return Container(
              width: 1120,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => context.go('/projectVertifyList/1'), 
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, 
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left),
                        Text('返回隊伍',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 400,
                        height:50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedStatus,
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            items: _statusOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedStatus = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 250),
                      
                      SizedBox(
                        width: 150,
                        height: 48,
                        child: BasicWebButton(
                          onPressed: (){
                            if(_selectedStatus == '需補件' && _messageCtrl.text.isEmpty){
                              setState(() {
                                _errorMessage = '需補件理由不得為空';
                              });
                            }else{
                              context.read<VertifyTeamBloc>().add(SubmitStateEvent(teamid: widget.teamid, state: _selectedStatus!,message: _messageCtrl.text));
                            }
                          },
                          title: '更新狀態',
                          fontSize: 16,
                        ),
                      ),  
                    ],
                  ),
                  if(_selectedStatus == '需補件')...[
                    SizedBox(height:10),
                    SizedBox(
                      width: 800,
                      child: TextField(
                          controller: _messageCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                            hintText:  '請輸入需補件原因',
                            errorText: _errorMessage
                          ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  _buildMemberAndTeacher(context,state.teamWithProject.team),
                  const SizedBox(height: 10),
                  _buildProjectInfo(context,state.teamWithProject)
                ],
              ),
            );
          }
          return SizedBox();
        }
      ),
    );
  }

  //展開格子，隊員暨指導老師資料
  Widget _buildMemberAndTeacher(BuildContext context,Team team){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: 

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(maxWidth: 800),
          child: 
          Column(
            children: [
              // 灰色底的標題區塊
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(
                    _isMemberInfoExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  title: const Text(
                    "隊員暨指導老師資料",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    setState(() {
                      _isMemberInfoExpanded = !_isMemberInfoExpanded;
                    });
                  },
                ),
              ),

              // 展開內容為白底
              if (_isMemberInfoExpanded) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: 

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //指導老師部分 - 三個欄位同一行
                      _buildPlainSection([
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 標題
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  "指導老師/顧問:",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 2, child: _buildInfoRow("姓名:", team.teacher!.name!)),
                                  Expanded(flex: 2, child: _buildInfoRow("職稱:", team.teacher!.title!)),
                                  Expanded(flex: 3, child: _buildInfoRow("所屬機構:",team.teacher!.organization! + team.teacher!.department!)),
                                ],
                              ),
                            ],
                          ),
                      ]),

                      _buildPlainSection([
                        for (int i = 0; i < team.members!.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 標題
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  i == 0 ? "隊員${i + 1}(代表人):" : "隊員${i + 1}:",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // 第一行：姓名、學號、年級、科系
                              Row(
                                children: [
                                  Expanded(flex: 2, child: _buildInfoRow("姓名:", team.members![i].name!)),
                                  Expanded(flex: 2, child: _buildInfoRow("學號:", team.members![i].uid!)),
                                  Expanded(flex: 2, child: _buildInfoRow("年級:", team.members![i].grade!)),
                                  Expanded(flex: 3, child: _buildInfoRow("科系:", team.members![i].department!)),
                                ],
                              ),
                              // 第二行：電話、email
                              Row(
                                children: [
                                  Expanded(flex: 3, child: _buildInfoRow("電話:", team.members![i].phone!)),
                                  Expanded(flex: 7, child: _buildInfoRow("Email:", team.members![i].email!)),
                                ],
                              ),
                              
                              const SizedBox(height: 10),

                              //學生證
                              Text('學生證',style: const TextStyle(fontWeight: FontWeight.bold),),
                              Image.network(team.members![i].studentCard!,width: 500,),
                              const SizedBox(height: 10),
                            ],
                          ),
                      ]),


                    ],
                  ),

                ),
              ],
            ],
          ),
        )
      ),
    );
  }

  //展開格子，隊伍資料
  Widget _buildProjectInfo(BuildContext context,TeamWithProject teamwithproject){
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
      child: Align(
        alignment: Alignment.center,
        child: 

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(maxWidth: 800),
          child: 
          Column(
            children: [
              // 灰色底的標題區塊
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(
                    _isProjectInfoExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  title: const Text(
                    "參賽作品詳細資料",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    setState(() {
                      _isProjectInfoExpanded = !_isProjectInfoExpanded;
                    });
                  },
                ),
              ),

              if (_isProjectInfoExpanded) ...[

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 參賽組別
                      _buildInfoRow("參賽組別:", teamwithproject.team.type!),
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
                              web.window.open(teamwithproject.project.introductionFile!, '_blank');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black, 
                            ),
                            child: Text('${widget.teamid}作品說明書'),
                          ),
                          TextButton(
                            onPressed: () {
                              web.window.open(teamwithproject.project.affidavitFile!, '_blank');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black, 
                            ),
                            child: Text('${widget.teamid}提案切結書'),
                          ),
                          TextButton(
                            onPressed: () {
                              web.window.open(teamwithproject.project.consentFile!, '_blank');
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





            ],
          ),
        )
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