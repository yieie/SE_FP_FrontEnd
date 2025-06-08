import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';


import 'package:front_end/features/data/models/project.dart';


import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';


import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';


class data {
  final String workId;
  final int teamRank;
  final String teamName;
  final String workName;
  final String advisor;
  
  data(this.workId, this.teamRank, this.teamName, this.workName, this.advisor);
}

// 測試假資料，名次10代表佳作
  final List<data> test_creative = [
    data("2025work123",1, "Team A", "Work A","指導教授名字"),
    data("2025work123",2, "Team B", "Work B","指導教授名字"),
    data("2025work123",3, "Team C", "Work C","指導教授名字"),
    data("2025work123",10, "Team D", "Work D","指導教授名字"),
    data("2025work123",10, "Team E", "Work E","指導教授名字"),

    data("2024work123",1, "Team F", "Work F","指導教授名字"),
    data("2024work123",2, "Team G", "Work G","指導教授名字"),
    data("2024work123",3, "Team H", "Work H","指導教授名字"),
    data("2024work123",10, "Team I", "Work I","指導教授名字"),
    data("2024work123",10, "Team J", "Work J","指導教授名字"),
  ];

// 測試假資料，名次10代表佳作
  final List<data> test_business = [
    data("2025work123",1, "Team K", "Work K","指導教授名字"),
    data("2025work123",2, "Team L", "Work L","指導教授名字"),
    data("2025work123",3, "Team M", "Work M","指導教授名字"),
    data("2025work123",10, "Team N", "Work N","指導教授名字"),
    data("2025work123",10, "Team O", "Work O","指導教授名字"),

    data("2024work123",1, "Team P", "Work P","指導教授名字"),
    data("2024work123",2, "Team Q", "Work Q","指導教授名字"),
    data("2024work123",3, "Team R", "Work R","指導教授名字"),
    data("2024work123",10, "Team S", "Work S","指導教授名字"),
    data("2024work123",10, "Team T", "Work T","指導教授名字"),
  ];

class ProjectEntry {
  final String rank;
  final String projectName;
  final String teamName;
  final String advisor;
  
  ProjectEntry(this.rank, this.projectName, this.teamName, this.advisor);
}



class PastProjectListPage extends StatelessWidget {
  final int page;
  PastProjectListPage({super.key, this.page = 1});

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

  Widget _buildBody(context) {
    return BlocBuilder<AnnBloc, AnnState>(
      builder: (_, state) {
        if (state is AnnouncementLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is AnnouncementError) {
          return Text(
            handleDioError(state.error!),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        }
        if (state is AnnouncementDone) {
          return _ProjectListWithFilter();
        }
        return const SizedBox();
      },
    );
  }
}

class _ProjectListWithFilter extends StatefulWidget {
  @override
  State<_ProjectListWithFilter> createState() => _ProjectListWithFilterState();
}

class _ProjectListWithFilterState extends State<_ProjectListWithFilter> {
  String? selectedYear = "2025"; // 預設選中2025
  String? selectedGroup = "全部"; // 預設選中全部
  
  String _getRankText(int rank) {
    switch (rank) {
      case 1: return "第一名";
      case 2: return "第二名";
      case 3: return "第三名";
      case 10: return "佳作";
      default: return "佳作";
    }
  }

  List<ProjectEntry> _filterProjects(List<data> source) {
    return source
        .where((item) => 
            (selectedYear == null || item.workId.startsWith(selectedYear!)) &&
            (selectedGroup == null || 
              (selectedGroup == "創意發想組" && source == test_creative) ||
              (selectedGroup == "創業實作組" && source == test_business) ||
              selectedGroup == "全部")
        )
        .map((item) => ProjectEntry(
          _getRankText(item.teamRank),
          item.workName,
          item.teamName,
          item.advisor,
        ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final creativeEntries = _filterProjects(test_creative);
    final businessEntries = _filterProjects(test_business);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 1120,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 197, 222, 246),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //選年
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text("年份：", 
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 2,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            value: selectedYear,
                            items: List.generate(16, (index) {
                              final year = (2010 + index).toString();
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year, 
                                  style: const TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                selectedYear = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 100),
                //選組別
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text("組別：", 
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 2,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            value: selectedGroup,
                            items: const [
                              DropdownMenuItem(
                                value: "全部",
                                child: Text("全部", style: TextStyle(fontSize: 18)),
                              ),
                              DropdownMenuItem(value: "創意發想組", 
                                child: Text("創意發想組", 
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                              DropdownMenuItem(value: "創業實作組", 
                                child: Text("創業實作組", 
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGroup = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          

          if ((selectedGroup == "全部" || selectedGroup == "創意發想組") && 
              creativeEntries.isNotEmpty)
            _buildProjectTable(
              title: "創意發想組",
              entries: creativeEntries,
            ),
          
          if ((selectedGroup == "全部" || selectedGroup == "創意發想組") && 
              creativeEntries.isNotEmpty)
            const SizedBox(height: 3),
          
          if ((selectedGroup == "全部" || selectedGroup == "創業實作組") && 
              businessEntries.isNotEmpty)
            _buildProjectTable(
              title: "創業實作組",
              entries: businessEntries,
            ),
        ],
      ),
    );
  }

  Widget _buildProjectTable({
    required String title,
    required List<ProjectEntry> entries,
  }) {
    return _HoverableTable(title: title, entries: entries);
  }
}

class _HoverableTable extends StatefulWidget {
  final String title;
  final List<ProjectEntry> entries;

  const _HoverableTable({required this.title, required this.entries});

  @override
  State<_HoverableTable> createState() => _HoverableTableState();
}

class _HoverableTableState extends State<_HoverableTable> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1120,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),

          const Row(
            children: [
              Expanded(flex: 1, child: Text("名次", style: TextStyle(fontSize: 18))),
              Expanded(flex: 3, child: Text("作品名稱", style: TextStyle(fontSize: 18))),
              Expanded(flex: 2, child: Text("隊伍名稱", style: TextStyle(fontSize: 18))),
              Expanded(flex: 2, child: Text("指導教授/顧問", style: TextStyle(fontSize: 18))),
            ],
          ),
          Container(height: 2, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 8)),

          ...widget.entries.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            
            return MouseRegion(
              onEnter: (_) => setState(() => selectedIndex = index),
              onExit: (_) => setState(() => selectedIndex = null),
              child: GestureDetector(
                onTap: () {
                  //點進去的邏輯
                },
                child: Container(
                  color: selectedIndex == index
                      ? const Color.fromARGB(255, 237, 227, 162)
                      : null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text(project.rank, style: TextStyle(fontSize: 18))),
                      Expanded(flex: 3, child: Text(project.projectName, style: TextStyle(fontSize: 18))),
                      Expanded(flex: 2, child: Text(project.teamName, style: TextStyle(fontSize: 18))),
                      Expanded(flex: 2, child: Text(project.advisor, style: TextStyle(fontSize: 18))),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}