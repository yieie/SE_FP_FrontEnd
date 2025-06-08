import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';


class AnnouncementManageListPage extends StatelessWidget{
  final int page;
  AnnouncementManageListPage({super.key,required this.page});

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

  
  _buildBody(BuildContext context) {
  return BlocBuilder<AnnBloc, AnnState>(
    builder: (context, state) {
      if (state is AnnouncementLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is AnnouncementError) {
        return Text(handleDioError(state.error!),style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),);
      }
      if (state is AnnouncementDone) {
        
        final currentList = state.announcementList?.announcements ?? [];
        final totalPages = state.announcementList?.totalPages ?? 0;
        final currentPage = state.announcementList?.page ?? 0;

        return  Container(
          width: 1120,
          height: 500,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "公告列表",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: BasicWebButton(
                      title: '新增',
                      fontSize: 16,
                      onPressed:() => context.go('/annModifyOrAdd'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child:Align(
                      alignment: Alignment.center, 
                      child: Text("修改"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center, 
                      child: Text("公告ID"),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('公告標題'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('最後修改時間'),
                  ),
                ],
              ),
              const Divider(thickness: 2, color: Colors.black,),
              Expanded(
                child: ListView.builder(
                  itemCount: currentList.length,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      child: GestureDetector(
                        onTap: () {
                          context.go('/detailAnn/${currentList[index].aid ?? 0}');
                          print("你選的是：${currentList[index].title}和${currentList[index].aid}");//測試用
                        },


                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: (){
                                    context.go('/annModifyOrAdd?aid=${currentList[index].aid}');
                                  }, 
                                  icon: Icon(Icons.edit_outlined)
                                )
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center, 
                                  child: Text("${currentList[index].aid}"),
                                )
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  currentList[index].title ?? '無標題',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  currentList[index].time ?? '無時間',
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              )
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
                            context.pushReplacement('/annManageList/${currentPage -1}');
                          }
                        : null,
                  ),
                  Text('$currentPage / $totalPages'),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: currentPage < totalPages
                        ? () {
                            context.pushReplacement('/annManageList/${currentPage +1}');
                          }
                        : null,
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