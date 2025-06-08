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


class data {
  final String teamId;
  final String teamName;
  final String workName;
  final String state;
  
  data({required this.teamId,required this.teamName,required this.workName,required this.state});
}

final List<data> test = [
  data(teamId: "2025team123",teamName: "對對隊",workName: "作品名稱",state: "已審核",),
  data(teamId: "2025team321",teamName: "不太隊",workName: "作品名稱",state: "需補件",),
  data(teamId: "2025team321",teamName: "A隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "B隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "C隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "D隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "E隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "F隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "G隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "H隊",workName: "作品名稱",state: "待審核",),
  data(teamId: "2025team321",teamName: "I隊",workName: "作品名稱",state: "待審核",),
];

class ProjectVerifyListPage extends StatefulWidget {
  const ProjectVerifyListPage({super.key});

  @override
  State<ProjectVerifyListPage> createState() => _ProjectVerifyListPageState();
}

class _ProjectVerifyListPageState extends State<ProjectVerifyListPage> {
  int _currentPage = 1;
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    const itemsPerPage = 10;
    final totalItems = test.length;
    final totalPages = (totalItems / itemsPerPage).ceil();
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final currentPageItems = test.sublist(
      startIndex,
      endIndex > totalItems ? totalItems : endIndex,
    );

    return BasicScaffold(
      child: Container(
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

            // 表格標題
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4), 
              child: const Row(
                children: [
                  Expanded(flex: 1, child: Text("點擊查看", style: TextStyle(fontSize: 14))),
                  Expanded(flex: 2, child: Text("隊伍ID", style: TextStyle(fontSize: 14))),
                  Expanded(flex: 2, child: Text("隊伍名稱", style: TextStyle(fontSize: 14))),
                  Expanded(flex: 2, child: Text("作品名稱", style: TextStyle(fontSize: 14))),
                  Expanded(flex: 1, child: Text("審核狀態", style: TextStyle(fontSize: 14))),
                ],
              ),
            ),

            const Divider(thickness: 2, color: Colors.black),

            // 表格內容
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemExtent: 38.0,  // 每行高度            
                itemCount: currentPageItems.length,
                itemBuilder: (context, index) {
                  final item = currentPageItems[index];
                  return MouseRegion(
                    onEnter: (_) => setState(() => _hoverIndex = index),
                    onExit: (_) => setState(() => _hoverIndex = null),
                    child: Container(
                      color: _hoverIndex == index ? Colors.grey[200] : null,
                      child: GestureDetector(
                        onTap: () {
                          context.go('/projectDetail/${item.teamId}');
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.search, size: 15),
                                onPressed: () {
                                  context.go('/projectDetail/${item.teamId}');
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(item.teamId, style: const TextStyle(fontSize: 15)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(item.teamName, style: const TextStyle(fontSize: 15)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(item.workName, style: const TextStyle(fontSize: 15)),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusBackgroundColor(item.state),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.state,
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

            // 分頁控制
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
      ),
    );
  }

  // 狀態標籤背景色
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