import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
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


class TeacherViewProjectPage extends StatelessWidget{
  final int page;

  TeacherViewProjectPage({super.key, this.page = 1});



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
    return BlocProvider<AnnBloc>(
      key: ValueKey(page), 
      create: (context) => sl()..add(Get10Announcement(page)),
      child: BasicScaffold(
      child: _buildBody(context)
      )
    );
  }

  
  _buildBody(context) {
  return BlocBuilder<AnnBloc, AnnState>(
    builder: (_, state) {
      if (state is AnnouncementLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is AnnouncementError) {
        return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
      }
      if (state is AnnouncementDone) {

        const int itemsPerPage = 5;
        final int totalPages = (test.length / itemsPerPage).ceil();
        final int currentPage = page;

        // 取出當前頁的資料
        final currentItems = test.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
        
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
                    final project = currentItems[index];
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
                                child: Text("參賽年度：${project.year}", style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                child: Text("參賽組別：${project.group}", style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("隊伍名稱：${project.teamName}", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text("作品名稱：${project.projectName}", style: TextStyle(fontSize: 16)),
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
                                    if (project.members.isNotEmpty)
                                      Text(
                                        project.members.take(2).map((m) => "${m.department} ${m.name}").join("、"),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    
                                    // 後續行
                                    ...List.generate(
                                      ((project.members.length - 1) / 2).ceil(),
                                      (rowIndex) {
                                        final startIndex = rowIndex * 2 + 2;
                                        final endIndex = (startIndex + 2) > project.members.length
                                            ? project.members.length
                                            : (startIndex + 2);
                                        final rowMembers = project.members.sublist(startIndex, endIndex);
                                        
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
                                  context.pushReplacement('/yourRoute/${currentPage - 1}');
                                }
                              : null,
                        ),
                        Text('$currentPage / $totalPages'),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: currentPage < totalPages
                              ? () {
                                  context.pushReplacement('/yourRoute/${currentPage + 1}');
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
  );
}

}