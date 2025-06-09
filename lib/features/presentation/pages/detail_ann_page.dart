import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:web/web.dart' as web;


/// 詳細公告頁面 
class DetailAnnPage extends StatelessWidget {
  final int aid;

  DetailAnnPage({super.key,required this.aid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnBloc>(
      create: (context) => sl()..add(GetDetailAnnouncement(aid)),
      child: BasicScaffold(
        child: _buildBody(context)
      ),
    );
  }

  _buildBody(BuildContext context){
    return BlocBuilder<AnnBloc,AnnState>(
      builder: (_,state){
        if(state is AnnouncementLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is AnnouncementError){
           return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
        }
        if(state is AnnouncementDetailDone){
          return SizedBox(
            width: 1120,
            child: Column(
              children: [
                SizedBox(height: 8,),
                TextButton(
                  onPressed: () => context.go('/homeWithAnn/1'), 
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, 
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left),
                      Text('返回公告列表',style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  )
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(state.announcementDetail!.title!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(state.announcementDetail!.time!),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(state.announcementDetail!.content!,style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                ),
                if(state.announcementDetail!.posterUrl!.isNotEmpty)
                  ...state.announcementDetail!.posterUrl!.map((url) => 
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(url,width: 500,)
                      ],
                    ),
                  )
                ),
                if(state.announcementDetail!.file!.isNotEmpty)
                  ...state.announcementDetail!.file!.map((file) =>
                    TextButton(
                      onPressed: () {
                        web.window.open(file.fileUrl, '_blank');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, 
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.file_open),
                          Text(file.fileName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      )
                    )
                  )
              ],
            ),
          );
        }
        return SizedBox();
      }
    );
  }
}