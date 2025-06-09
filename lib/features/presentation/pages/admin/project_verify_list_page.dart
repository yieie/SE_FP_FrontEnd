import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_event.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_state.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';



class ProjectVerify {
  final String tid; //隊伍id
  final String teamName; //隊名
  final String projectName; //作品名
  final String status; //審核狀態
  ProjectVerify({
    required this.tid,
    required this.teamName,
    required this.projectName,
    required this.status,
  });
}

class ProjectVerifyListPage extends StatefulWidget {
  final int page;
  const ProjectVerifyListPage({super.key,required this.page});

  @override
  State<ProjectVerifyListPage> createState() => _ProjectVerifyListPageState();
}

class _ProjectVerifyListPageState extends State<ProjectVerifyListPage> {
  //測試假資料
  final List<ProjectVerify> test2 = [
    ProjectVerify(tid: "2025team1", teamName: "team1", projectName: "team1_project", status: "待審核"),
    ProjectVerify(tid: "2025team2", teamName: "team2", projectName: "team2_project", status: "已審核"),
    ProjectVerify(tid: "2025team3", teamName: "team3", projectName: "team3_project", status: "需補件"),
    ProjectVerify(tid: "2025team4", teamName: "team4", projectName: "team4_project", status: "需補件"),
    ProjectVerify(tid: "2025team5", teamName: "team5", projectName: "team5_project", status: "已審核"),
    ProjectVerify(tid: "2025team6", teamName: "team6", projectName: "team6_project", status: "已審核"),
    ProjectVerify(tid: "2025team7", teamName: "team7", projectName: "team7_project", status: "已審核"),
    ProjectVerify(tid: "2025team8", teamName: "team8", projectName: "team8_project", status: "需補件"),
    ProjectVerify(tid: "2025team9", teamName: "team9", projectName: "team9_project", status: "待審核"),
    ProjectVerify(tid: "2025team10", teamName: "team10", projectName: "team10_project", status: "已審核"),
    ProjectVerify(tid: "2025team11", teamName: "team11", projectName: "team11_project", status: "待審核"),
  ];

  int _currentPage = 1;
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<VertifyTeamBloc>(
      key: ValueKey(widget.page),
      create: (context) => sl()..add(GetVertifyTeamListEvent(widget.page)),
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
    return BlocListener<VertifyTeamBloc,VertifyTeamState>(
      listener: (context,state){
        if(state is VertifyTeamError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
        if(state is VertifyTeamLoading){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('載入中'),
            ),
          );
        }
      },
      child: BlocBuilder<VertifyTeamBloc,VertifyTeamState>(
        builder: (context,state){
          if(state is VertifyTeamListLoaded){
            final currentPage = state.teamwithprojectlist.page;
            final totalPages = state.teamwithprojectlist.totalPages;
            final currentlist = state.teamwithprojectlist.teamwithprojectlist;

            return Container(
              width: 1120,
              height: 520,
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "報名審核",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4), 
                    child: const Row(
                      children: [
                        Expanded(flex: 1, child: Align(alignment: Alignment.center, child: Text("點擊查看", style: TextStyle(fontSize: 14)),)),
                        Expanded(flex: 1, child: Text("隊伍ID", style: TextStyle(fontSize: 14))),
                        Expanded(flex: 3, child: Text("隊伍名稱", style: TextStyle(fontSize: 14))),
                        Expanded(flex: 3, child: Text("作品名稱", style: TextStyle(fontSize: 14))),
                        Expanded(flex: 1, child: Text("報名狀態", style: TextStyle(fontSize: 14))),
                      ],
                    ),
                  ),

                  const Divider(thickness: 2, color: Colors.black),

                  // 表格内容
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemExtent: 38.0,  //每行高度            
                      itemCount: currentlist.length,
                      itemBuilder: (context, index) {
                        final item = currentlist[index];
                        return MouseRegion(
                          onEnter: (_) => setState(() => _hoverIndex = index),
                          onExit: (_) => setState(() => _hoverIndex = null),
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                context.go('/projectVertifyDetail/${item.team.teamID}');
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.search, size: 15),
                                      onPressed: () {
                                        context.go('/projectVertifyDetail/${item.team.teamID}');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(item.team.teamID!, style: const TextStyle(fontSize: 15)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(item.team.name!, style: const TextStyle(fontSize: 15)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(item.project.name!, style: const TextStyle(fontSize: 15)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusBackgroundColor(item.project.state!),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        item.project.state!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentPage > 1
                            ? () {
                                context.pushReplacement('/projectVertifyList/${currentPage - 1}');
                              }
                            : null,
                      ),
                      Text('$_currentPage / $totalPages'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _currentPage < totalPages
                            ? () {
                                context.pushReplacement('/projectVertifyList/${currentPage + 1}');
                              }
                            : null,
                      ),
                    ],
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

  //標籤背景色
  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case '待審核':
        return Color(0xFFF96D4E);
      case '已審核':
        return Color(0xFF76C919);
      case '需補件':
        return Color(0xFFD2F1FF);
      default:
        return Colors.grey[300]!;
    }
  }
}