import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

class HomeWithAnnPage extends StatelessWidget{
  final int page;
  HomeWithAnnPage({super.key,this.page = 1});

  //測試假資料
  final List<AnnouncementModel> test = [
    AnnouncementModel(aid: 1, title: "系統維護公告 - 2025年5月1日" ,time: "2025-05-01"),
    AnnouncementModel(aid: 2, title: "重要通知：即將更新資料庫系統" ,time: "2025-04-30"),
    AnnouncementModel(aid: 3, title: "新版本功能介紹及使用指南" ,time: "2025-04-29"),
    AnnouncementModel(aid: 4, title: "網站公告：暫停服務維護通知" ,time: "2025-04-28"),
    AnnouncementModel(aid: 5, title: "2025年春季訓練營報名開始" ,time: "2025-04-27"),
    AnnouncementModel(aid: 6, title: "年度大會議程安排及報名詳情" ,time: "2025-04-26"),
    AnnouncementModel(aid: 7, title: "突發事件：近期網站異常修復通知" ,time: "2025-04-25"),
    AnnouncementModel(aid: 8, title: "重要安全升級公告，請盡快處理" ,time: "2025-04-24"),
    AnnouncementModel(aid: 9, title: "緊急：系統重啟及修復通知" ,time: "2025-04-23"),
    AnnouncementModel(aid: 10, title: "即將開放新功能：探索新版平台" ,time: "2025-04-22"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnBloc>(
      create: (context) => sl()..add(Get10Announcement(page)),
      child: BasicScaffold(
      child: _buildBody()
    ));
  }

  _buildBody(){
    return BlocBuilder<AnnBloc,AnnState>(
      builder: (_, state){
        if(state is AnnouncementLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is AnnouncementError){
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is AnnouncementDone){
          //需要加上UI
          //使用上方的測試假資料 只需要顯示title、time欄位
          //https://www.youtube.com/watch?v=7V_P6dovixg&t=1655s 可參考26:28~26:46秒使用ListView
          //先寫出一頁就好不用換頁
        }
        return SizedBox();
      }
    );
  }
}