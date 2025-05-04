import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';

class HomeWithAnnPage extends StatelessWidget{
  const HomeWithAnnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnBloc>(
      create: (context) => sl()..add(const Get10Announcement()),
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
          //資料型態是List<Announcement> 只需要顯示title、time欄位
          //https://www.youtube.com/watch?v=7V_P6dovixg&t=1655s 可參考26:28~26:46秒使用ListView
          //先寫出一頁就好不用換頁
        }
        return SizedBox();
      }
    );
  }
}