import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';


import 'package:front_end/features/data/models/project.dart';


import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/past_project_bloc.dart';
import 'package:front_end/features/presentation/bloc/past_project_event.dart';
import 'package:front_end/features/presentation/bloc/past_project_state.dart';


import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';

class PastProjectPage extends StatefulWidget {
  const PastProjectPage({super.key});

  @override
  _PastProjectPageState createState() => _PastProjectPageState();
}

class _PastProjectPageState extends State<PastProjectPage> {
  String? _year;
  String? _teamtype;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PastProjectBloc>(
      create: (context) => sl(),
      child: BasicScaffold(
        child: _buildBody(context)
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<PastProjectBloc, PastProjectState>(
      listener: (context,state){
        if (state is PastProjectError) {
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
        builder: (context, state) {
          if (state is PastProjectLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is PastProjectInitial || state is PastProjectListLoaded) {
            return SizedBox(
              width: 1120,
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
                                style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    value: _year,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text("選年份"),
                                    items: List.generate(16, (index) {
                                      final year = 2010 + index;
                                      return DropdownMenuItem(
                                        value: year.toString(),
                                        child: Text(year.toString(), 
                                          style: const TextStyle(color: Colors.black, fontSize: 16),
                                        ),
                                      );
                                    }),
                                    onChanged: (value) {
                                      setState(() {
                                        _year = value;
                                        print(_year);
                                      });
                                      if(_teamtype != null && _year  != null){
                                        context.read<PastProjectBloc>().add(GetPastProjectbyYearAndTeamtypeEvent(year: _year!, teamType: _teamtype!));
                                      }
                                    },
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
                                style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    value: _teamtype,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text("選組別"),
                                    items: const [
                                      DropdownMenuItem(value: "創意發想組", 
                                        child: Text("創意發想組", 
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                        ),
                                      ),
                                      DropdownMenuItem(value: "創業實作組", 
                                        child: Text("創業實作組", 
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _teamtype = value;
                                      });
                                      if(_teamtype != null && _year  != null){
                                        context.read<PastProjectBloc>().add(GetPastProjectbyYearAndTeamtypeEvent(year: _year!, teamType: _teamtype!));
                                      }
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
                  if(state is PastProjectListLoaded)
                    _buildProjectTable(
                      title: _teamtype!,
                      entries: state.teamwithprojectlist,
                    ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProjectTable({
    required String title,
    required List<TeamWithProject> entries,
  }) {
    return _HoverableTable(title: title, entries: entries);
  }
}


class _HoverableTable extends StatefulWidget {
  final String title;
  final List<TeamWithProject> entries;

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
              // Expanded(flex: 1, child: Text("名次", style: TextStyle(fontSize: 14))),
              Expanded(flex: 3, child: Text("作品名稱", style: TextStyle(fontSize: 14))),
              Expanded(flex: 2, child: Text("隊伍名稱", style: TextStyle(fontSize: 14))),
              Expanded(flex: 2, child: Text("指導教授/顧問", style: TextStyle(fontSize: 14))),
            ],
          ),
          Container(height: 2, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 8)),
          //內容
          ...widget.entries.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            
            return MouseRegion(
              onEnter: (_) => setState(() => selectedIndex = index),
              onExit: (_) => setState(() => selectedIndex = null),
              child: GestureDetector(
                onTap: () {
                  context.go('/pastProjectsDetail/${item.team.teamID}');
                },
                child: Container(
                  color: selectedIndex == index
                      ? const Color.fromARGB(255, 237, 227, 162)
                      : null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      // Expanded(flex: 1, child: Text('${item.team.rank}', style: TextStyle(fontSize: 14))),
                      Expanded(flex: 3, child: Text(item.project.name!, style: TextStyle(fontSize: 14))),
                      Expanded(flex: 2, child: Text(item.team.name!, style: TextStyle(fontSize: 14))),
                      Expanded(flex: 2, child: Text(item.team.teacher!.name!, style: TextStyle(fontSize: 14))),
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