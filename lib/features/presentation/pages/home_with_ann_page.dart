import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';



import 'package:front_end/features/presentation/pages/detail_ann_page.dart';
import 'package:go_router/go_router.dart';

class HomeWithAnnPage extends StatelessWidget{
  final int page;
  HomeWithAnnPage({super.key,this.page = 1});

  //測試假資料
  final List<AnnouncementModel> test2 = [
    const AnnouncementModel(aid: 1, title: "系統維護公告 - 2025年5月1日" ,time: "2025-05-01"),
    const AnnouncementModel(aid: 2, title: "重要通知：即將更新資料庫系統" ,time: "2025-04-30"),
    const AnnouncementModel(aid: 3, title: "新版本功能介紹及使用指南" ,time: "2025-04-29"),
    const AnnouncementModel(aid: 4, title: "網站公告：暫停服務維護通知" ,time: "2025-04-28"),
    const AnnouncementModel(aid: 5, title: "2025年春季訓練營報名開始" ,time: "2025-04-27"),
    const AnnouncementModel(aid: 6, title: "年度大會議程安排及報名詳情" ,time: "2025-04-26"),
    const AnnouncementModel(aid: 7, title: "突發事件：近期網站異常修復通知" ,time: "2025-04-25"),
    const AnnouncementModel(aid: 8, title: "重要安全升級公告，請盡快處理" ,time: "2025-04-24"),
    const AnnouncementModel(aid: 9, title: "緊急：系統重啟及修復通知" ,time: "2025-04-23"),
    const AnnouncementModel(aid: 10, title: "即將開放新功能：探索新版平台" ,time: "2025-04-22"),
    const AnnouncementModel(aid: 11, title: "第二頁test" ,time: "2025-01-10"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnBloc>(
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
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is AnnouncementDone) {
        final test = state.announcements ?? [];
        final total = test.length;
        final totalPages = (total / 10).ceil();
        final currentPage = page;
        final start = (currentPage - 1) * 10;
        final end = (start + 10 < total) ? start + 10 : total;
        final currentList = test.sublist(start, end);

        int? selectedIndex;

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 1120,
              height: 500,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "最新公告",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(thickness: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        return MouseRegion(
                          onEnter: (_) => setState(() => selectedIndex = index),
                          onExit: (_) => setState(() => selectedIndex = null),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/detailAnn/${currentList[index].aid ?? 0}');
                              print("你選的是：${currentList[index].title}和${currentList[index].aid}");//測試用
                            },


                            child: Container(
                              color: selectedIndex == index
                                  ? const Color.fromARGB(255, 237, 227, 162)
                                  : null,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentList[index].title ?? '無標題',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    currentList[index].time ?? '無時間',
                                    style: const TextStyle(color: Colors.black, fontSize: 15),
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
                        onPressed: currentPage > 1
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeWithAnnPage(page: currentPage - 1),
                                  ),
                                );
                              }
                            : null,
                      ),
                      Text('$currentPage / $totalPages'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: currentPage < totalPages
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeWithAnnPage(page: currentPage + 1),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
      return const SizedBox();
    },
  );
}
}