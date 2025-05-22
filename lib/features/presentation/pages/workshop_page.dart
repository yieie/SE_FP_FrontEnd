import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_event.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_state.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_event.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';

class WorkshopPage extends StatefulWidget {
  const WorkshopPage({super.key});

  @override
  _WorkshopPageState createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage>{
  
  final test = [
    Workshop(wsid: 1,topic: "產品開發與市場驗證", time: "113年09月27日", lecturerName: "劉建成" , lecturerTitle: "高雄大學產學育成中心 營運長",amount: 30, registered: 15),
    Workshop(wsid: 2,topic: "商業計劃撰寫與展示技巧", time: "113年09月30日", lecturerName: "李尚軒" , lecturerTitle: "弘帆創新 執行長",amount: 30, registered: 30),
    Workshop(wsid: 3,topic: "創意與創新思維 ", time: "113年10月07日", lecturerName: "廖宏益" , lecturerTitle: "聯樂數位創意總監 ",amount: 30, registered: 15),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    bool isLoggedIn = authState is Authenticated;
    return BlocProvider<WorkshopBloc>(
      create: (context) => sl()..add(GetWorkshop()),
      child: isLoggedIn ? 
              BlocProvider<WorkshopParticipationBloc>(
                  create: (context) => sl()..add(GetWorkshopParticipation(uid: authState.uid)),
                  child: BasicScaffold(
                      child: _buildBody(context)
                    ),
              ) :
              BasicScaffold(
                child: _buildBody(context)
              )
    );
  }

  Widget _buildBody(BuildContext context){
    final authState = context.watch<AuthBloc>().state;
    final isLoggedIn = authState is Authenticated;
    return BlocBuilder<WorkshopBloc,WorkshopState>(
      builder: (_, state) {
        if(state is WorkshopListInitial){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is WorkshopListError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is WorkshopListDone) {
          final workshops = state.workshop;
          
          if(isLoggedIn){
            return BlocBuilder<WorkshopParticipationBloc, WorkshopParticipationState>(
              builder: (context, regState) {
                final registeredIds = regState is ParticipationLoaded
                    ? regState.participation
                    : <int>[];

                return _buildWorkshopList(workshops, registeredIds);
              },
            );
          } 
          else{
            return _buildWorkshopList(workshops, []);
          }
          
        }
        return SizedBox();
      }
    );
  }

  Widget _buildWorkshopList(List<Workshop> workshops,List<int> participation){
    final authState = context.watch<AuthBloc>().state;
    return SizedBox(
      width: 1120,
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("工作坊資訊", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text("主題", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("時間", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 6,
                child: Text("講師", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
            ]
          ),
          SizedBox(height: 10,),
          Divider(height: 2,color: Colors.black),
          Expanded(
            child: ListView.builder(
            itemCount: workshops.length,
            itemBuilder: (context, index){
              return Container(
                  margin: EdgeInsets.only(top: 5,bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(workshops[index].topic ?? "無主題", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(workshops[index].time ?? "無時間", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text("${workshops[index].lecturerName} / ${workshops[index].lecturerTitle}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                      if(authState is Authenticated)
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 30,
                            child: participation.contains(workshops[index].wsid) ?
                            BasicWebButton(
                              title: "已報名",
                              fontSize: 16,
                              backgroundColor: Color(0x99D9D9D9),
                              onPressed: (){},
                            ) :
                            BasicWebButton(
                              title: workshops[index].amount! > workshops[index].registered! ? "報名" : "已額滿",
                              fontSize: 16,
                              backgroundColor: workshops[index].amount! > workshops[index].registered! ? Color(0xFF76C919) : Color(0xFFF96D4E),
                              onPressed: (){
                                print("報名工作坊${workshops[index].wsid}");
                              }
                            )
                          )
                        )
                      else
                        Expanded(
                          flex: 2,
                          child: Text("登入後即可報名",style: TextStyle(color: Colors.grey.shade800,fontSize: 16))
                        )
                    ],
                  ),
                );
              }
            )
          )
          
        ],
      ),
    );
  }
}