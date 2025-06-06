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



class ProjectEntry {
  final String rank;
  final String projectName;
  final String teamName;
  final String advisor;
  
  ProjectEntry(this.rank, this.projectName, this.teamName, this.advisor);
}

class PastProjectPage extends StatelessWidget {
  final int page;
  PastProjectPage({super.key, this.page = 1});

  // 測試假資料
  final List<ProjectEntry> creativeGroup = [
    ProjectEntry("第一名", "AI情緒辨識口罩", "表情辨真隊", "王俊傑教授"),
    ProjectEntry("第二名", "室內智慧植物照護系統", "綠生活小隊", "林玉珍教授"),
    ProjectEntry("第三名", "防災地圖互動平台", "安心守護者", "陳威廷教授"),
    ProjectEntry("佳作", "書聲朗朗共讀App", "悅讀童年隊", "許美雲教授"),
    ProjectEntry("佳作", "智慧校園點名系統", "點點點隊", "洪家嘉教授"),
  ];

  final List<ProjectEntry> businessGroup = [
    ProjectEntry("第一名", "可攜式水質快檢裝置", "水感科技", "鄭偉倫教授"),
    ProjectEntry("第二名", "二手書流通平台", "書不盡言隊", "林詠翔教授"),
    ProjectEntry("第三名", "智能自動咖啡攪拌杯", "啡你莫屬", "吳文君教授"),
    ProjectEntry("佳作", "室內空閒測儀", "清新每一天隊", "胡志宏教授"),
    ProjectEntry("佳作", "智慧體驗觀食器", "毛孩好幫手", "陳雅婷教授"),
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
          return SingleChildScrollView(
            child: Column(
              children: [
                // 藍色篩選框
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
                      // 年份選擇部分
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
                                  hint: const Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text("選年份", 
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  items: List.generate(16, (index) {
                                    final year = 2010 + index;
                                    return DropdownMenuItem(
                                      value: year.toString(),
                                      child: Text(year.toString(), 
                                        style: const TextStyle(color: Colors.black, fontSize: 18),
                                      ),
                                    );
                                  }),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 100),
                      // 組別選擇
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text("組別：", 
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 80,
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
                                  hint: const Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text("選組別", 
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  items: const [
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
                                  onChanged: (value) {},
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
                // 創意發想組表格
                _buildProjectTable(
                  title: "創意發想組",
                  entries: creativeGroup,
                ),
                const SizedBox(height: 3),
                // 創業實作組表格
                _buildProjectTable(
                  title: "創業實作組",
                  entries: businessGroup,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
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
          //標題
          const Row(
            children: [
              Expanded(flex: 1, child: Text("名次", style: TextStyle(fontSize: 18))),
              Expanded(flex: 3, child: Text("作品名稱", style: TextStyle(fontSize: 18))),
              Expanded(flex: 2, child: Text("隊伍名稱", style: TextStyle(fontSize: 18))),
              Expanded(flex: 2, child: Text("指導教授/顧問", style: TextStyle(fontSize: 18))),
            ],
          ),
          Container(height: 2, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 8)),
          //內容
          ...widget.entries.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            
            return MouseRegion(
              onEnter: (_) => setState(() => selectedIndex = index),
              onExit: (_) => setState(() => selectedIndex = null),
              child: GestureDetector(
                onTap: () {
                  //點擊
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