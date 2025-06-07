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
  const ProjectVerifyListPage({super.key});

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
    return BasicScaffold(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    const itemsPerPage = 10;
    final totalItems = test2.length;
    final totalPages = (totalItems / itemsPerPage).ceil();
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final currentPageItems = test2.sublist(
      startIndex,
      endIndex > totalItems ? totalItems : endIndex,
    );

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
                Expanded(flex: 1, child: Text("點擊查看", style: TextStyle(fontSize: 14))),
                Expanded(flex: 2, child: Text("隊伍ID", style: TextStyle(fontSize: 14))),
                Expanded(flex: 2, child: Text("隊伍名稱", style: TextStyle(fontSize: 14))),
                Expanded(flex: 2, child: Text("作品名稱", style: TextStyle(fontSize: 14))),
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
              itemCount: currentPageItems.length,
              itemBuilder: (context, index) {
                final item = currentPageItems[index];
                return MouseRegion(
                  onEnter: (_) => setState(() => _hoverIndex = index),
                  onExit: (_) => setState(() => _hoverIndex = null),
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        context.go('/projectDetail/${item.tid}');
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(Icons.search, size: 15),
                              onPressed: () {
                                context.go('/projectDetail/${item.tid}');
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(item.tid, style: const TextStyle(fontSize: 15)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(item.teamName, style: const TextStyle(fontSize: 15)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(item.projectName, style: const TextStyle(fontSize: 15)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusBackgroundColor(item.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.status,
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
                        setState(() {
                          _currentPage--;
                        });
                      }
                    : null,
              ),
              Text('$_currentPage / $totalPages'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _currentPage < totalPages
                    ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //標籤背景色
  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case '待審核':
        return Colors.grey[300]!;
      case '已審核':
        return const Color.fromARGB(255, 89, 220, 93);
      case '需補件':
        return const Color.fromARGB(255, 236, 66, 83);
      default:
        return Colors.grey[300]!;
    }
  }
}