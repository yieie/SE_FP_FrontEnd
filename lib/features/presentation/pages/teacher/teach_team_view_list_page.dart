import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_event.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

import 'package:go_router/go_router.dart';


class Member {
  final String department; // 系所
  final String name;      // 名字

  Member(this.department, this.name);

  @override
  String toString() => "$department $name";
}

class Project {
  final int year;//參加年度
  final String group;//組別
  final String teamName;//隊名
  final String projectName;//作品名
  final List<Member> members; //成員+系所
  
  Project({
    required this.year,
    required this.group,
    required this.teamName,
    required this.projectName,
    required this.members,
  });
}

class TeachTeamViewListPage extends StatelessWidget{
  final int page;

  TeachTeamViewListPage({super.key, this.page = 1});



  // 測試假資料
  final List<Project> test = [

    Project(year: 2025,
      group: "創意發想組",
      teamName: "A隊",
      projectName: "測試作品1",
      members: [
        Member("資工系", "jay"),
        Member("電機系", "max"),
      ], 
    ),

    Project(
      year: 2025,
      group: "創業實作組",
      teamName: "B隊",
      projectName: "測試作品2",
      members: [
        Member("資工系", "ray"),
        Member("電機系", "elen"),
        Member("電機系", "terry"),
        Member("電機系", "herry"),
        Member("電機系", "john"),
      ],  
    ),
    Project(
      year: 2025,
      group: "創業實作組",
      teamName: "B隊",
      projectName: "測試作品2",
      members: [
        Member("資工系", "ray"),
        Member("電機系", "elen"),
      ],  
    ),

    Project(
      year: 2024,
      group: "創業實作組",
      teamName: "B隊",
      projectName: "測試作品2",
      members: [
        Member("資工系", "ray"),
        Member("電機系", "elen"),
      ],  
    ),

    Project(
      year: 2024,
      group: "創業實作組",
      teamName: "B隊",
      projectName: "測試作品2",
      members: [
        Member("資工系", "ray"),
        Member("電機系", "elen"),
      ],  
    ),

    Project(
      year: 2023,
      group: "創業實作組",
      teamName: "B隊",
      projectName: "測試作品2",
      members: [
        Member("資工系", "ray"),
        Member("電機系", "elen"),
      ],  
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if(authState is Authenticated){
      return BlocProvider<TeachTeamBloc>(
        key: ValueKey(page), 
        create: (context) => sl()..add(GetTeachTeamListEvent(page, authState.uid)),
        child: BasicScaffold(
        child: _buildBody(context)
        )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }

  
  _buildBody(BuildContext context) {
    return BlocListener<TeachTeamBloc, TeachTeamState>(
        listener: (context, state){
          if(state is TeamError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(handleDioError(state.error)),
              ),
            );
          }
          if(state is TeamLoading){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('載入中'),
              ),
            );
          }
        },
        child: BlocBuilder<TeachTeamBloc, TeachTeamState>(
          builder: (_, state) {
            if (state is TeamListLoaded) {

              final int totalPages = state.teamWithProjectList.totalPages;
              final int currentPage = page;

              // 取出當前頁的資料
              final currentItems = state.teamWithProjectList.teamwithprojectlist;
              
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 750), // 想往哪邊移就加哪邊
                      child: Text(
                        "指導隊伍列表",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 900,
                      height: 400,
                      
                      child: ListView.builder(
                        itemCount: currentItems.length,
                        itemBuilder: (context, index) {
                          final teamwithproject = currentItems[index];
                          return Container(
                            width: 900,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text("參賽年度：${teamwithproject.team.teamID!.substring(0,4)}", style: TextStyle(fontSize: 16)),
                                    ),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: Text("參賽組別：${teamwithproject.team.type}", style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text("隊伍名稱：${teamwithproject.team.name}", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 4),
                                Text("作品名稱：${teamwithproject.project.name}", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 8),

                                //隊員2個2個排
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("隊員：", style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (teamwithproject.team.members != null)
                                            Text(
                                              teamwithproject.team.members!.take(2).map((m) => "${m.department} ${m.name}").join("、"),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          
                                          // 後續行
                                          ...List.generate(
                                            ((teamwithproject.team.members!.length - 1) / 2).ceil(),
                                            (rowIndex) {
                                              final startIndex = rowIndex * 2 + 2;
                                              final endIndex = (startIndex + 2) > teamwithproject.team.members!.length
                                                  ? teamwithproject.team.members!.length
                                                  : (startIndex + 2);
                                              final rowMembers = teamwithproject.team.members!.sublist(startIndex, endIndex);
                                              
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Text(
                                                  rowMembers.map((m) => "${m.department} ${m.name}").join("、"),
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    // 分頁按鈕
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 300), // 可調整為你想要的位置
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: currentPage > 1
                                    ? () {
                                        context.pushReplacement('/projectViewList/${currentPage - 1}');
                                      }
                                    : null,
                              ),
                              Text('$currentPage / $totalPages'),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: currentPage < totalPages
                                    ? () {
                                        context.pushReplacement('/projectViewList/${currentPage + 1}');
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        )
    );
}

}