import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_bloc.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_event.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';

class ProjectViewListPage extends StatelessWidget{

  final int page;

  const ProjectViewListPage({super.key, required this.page});
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    if(isLoggedIn){
      return BlocProvider<ScoreListBloc>(
      create: (context) => sl()..add(GetScoreList(page)),
      child: BasicScaffold(
              child: _buildBody(context)
            )
      );
    }
    return BasicScaffold(
        child: Text('你才不能進來這個頁面')
    );
  }

  Widget _buildBody(BuildContext context){
    
    return BlocListener<ScoreListBloc, ScoreListState>(
      listener: (context,state){
        if(state is ScoreListError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(handleDioError(state.error)),
            ),
          );
        }
      },
      child: BlocBuilder<ScoreListBloc, ScoreListState>(
        builder: (context, state){
          if(state is ScoreListLoaded){
            final currentPage = state.teamwithprojectlist.page;
            final totalPages = state.teamwithprojectlist.totalPages;
            final teamlist = state.teamwithprojectlist.teamwithprojectlist;
            int? selectedIndex;
            return StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                width: 928,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("評分標準", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('創意發想組\n\t創新與特色：35%\n\t實用價值與技術、服務獨特性：35%\n\t創意實作可行性：25%\n\t其他：5%',style: TextStyle(fontSize: 16)),
                        Text('創業實作組\n\t產品及服務內容創新性：35%\n\t市場可行性：35%\n\t未來發展性：25%\n\t其他：5%',style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      "評分列表",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('參賽組別'),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text('隊伍名稱'),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text('作品名稱'),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2, color: Colors.black,),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: teamlist.length,
                        itemBuilder: (context, index) {
                          return MouseRegion(
                            onEnter: (_) => setState(() => selectedIndex = index),
                            onExit: (_) => setState(() => selectedIndex = null),
                            child: GestureDetector(
                              onTap: () {
                                context.go('/projectViewDetail/${teamlist[index].team.teamID}');
                                print("你選的是：${teamlist[index].team.name}和${teamlist[index].team.teamID}");//測試用
                              },
              
              
                              child: Container(
                                color: selectedIndex == index
                                    ? const Color.fromARGB(255, 237, 227, 162)
                                    : null,
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(teamlist[index].team.type!),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(teamlist[index].team.name!),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(teamlist[index].project.name!),
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
                                  context.pushReplacement('/projectviewlist/${currentPage - 1}');
                                }
                              : null,
                        ),
                        Text('$currentPage / $totalPages'),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: currentPage < totalPages
                              ? () {
                                  context.pushReplacement('/projectviewlist/${currentPage + 1}');
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
              }
            );
          }
          return SizedBox(
            width: 1120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("評分標準", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text('創意發想組\n\t創新與特色：35%\n\t實用價值與技術、服務獨特性：35%\n\t創意實作可行性：25%\n\t其他：5%',style: TextStyle(fontSize: 16)),
                    Text('創業實作組\n\t產品及服務內容創新性：35%\n\t市場可行性：35%\n\t未來發展性：25%\n\t其他：5%',style: TextStyle(fontSize: 16)),
                  ],
                )
              ],
            ),
          );
        }
      ),
    )
    ;
  }

}