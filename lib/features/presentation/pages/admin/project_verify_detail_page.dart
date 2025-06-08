import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/injection_container.dart';
import 'package:go_router/go_router.dart';

class Member {
  final String name;      //隊員名字
  final String uid;      //隊員學號
  final String grade;      //年級
  final String department; //科系
  final String phone; //電話
  final String email; //信箱
  final String student_iD_card;
  Member(this.name, this.uid, this.grade, this.department, this.phone, this.email,this.student_iD_card);
}

class ProjectVerifyDetail {
  final String advisor_name;//指導老師名字
  final String advisor_title;//指導老職稱
  final String advisor_school; //指導老師所屬機構
  final List<Member> members; //成員的各個資訊

  final String group; //參賽組別
  final String team_name; //團隊名稱
  final String project_name; //團隊名稱
  final String summary; //摘要
  final String yt_url; //youtube連結
  final String github_url; //github連結
  final List<String> sdgs;//sdgs
  final List<String> files;//相關文件

  ProjectVerifyDetail({
    required this.advisor_name,
    required this.advisor_title,
    required this.advisor_school,
    required this.members,

    required this.group,
    required this.team_name,
    required this.project_name,
    required this.summary,
    required this.yt_url,
    required this.github_url,
    required this.sdgs,
    required this.files,
  });
}

class ProjectVerifyDetailPage extends StatefulWidget {
  const ProjectVerifyDetailPage({super.key});

  @override
  State<ProjectVerifyDetailPage> createState() => _ProjectVerifyDetailPageState();
}

class _ProjectVerifyDetailPageState extends State<ProjectVerifyDetailPage> {
  // 測試假資料
  final List<ProjectVerifyDetail> test = [
    ProjectVerifyDetail(
      advisor_name: "老師名字test1",
      advisor_title: "老師職稱test1",
      advisor_school: "老師所屬機構test1",
      members: [
        Member("學生1", "A111111", "大四", "資訊工程學系", "090001", "1@gmail.com","學生證1.jpg"),
        Member("學生2", "A111112", "大四", "資訊工程學系", "090002", "2@gmail.com","學生證2.jpg"),
        Member("學生3", "A111113", "大四", "資訊工程學系", "090003", "3@gmail.com","學生證3.jpg"),
      ], 
      group:"創意發想組",
      team_name:"Future seeker",
      project_name: "guradian",
      summary: "test123456789asdfghjklqwryiopoiuy",
      yt_url: "https://123456789",
      github_url: "https://123456789",
      sdgs: ["1", "2"],
      files: ["作品說明書.pdf", "提案切結書.pdf", "個茲同意書.pdf"],
    ),
  ];



  String _selectedStatus = '待審核'; // 預設選中"待審核"
  final List<String> _statusOptions = ['待審核', '已審核', '需補件'];


  bool _isMemberInfoExpanded = false; // 隊員暨指導老師資料
  bool _isProjectInfoExpanded = false; // 參賽作品詳細資料

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 353.0, top: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 400,
                    height:50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStatus,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        items: _statusOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStatus = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 250),
                  
                  SizedBox(
                    width: 150,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero, 
                      ),
                      onPressed: () {
                        // 點選後的邏輯
                      },
                      child: const Text("更新狀態",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),


                ],
              ),
            ),


            const SizedBox(height: 10),
            
            //展開格子，隊員暨指導老師資料
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: 

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: 
                  Column(
                    children: [
                      // 灰色底的標題區塊
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(
                            _isMemberInfoExpanded ? Icons.expand_less : Icons.expand_more,
                          ),
                          title: const Text(
                            "隊員暨指導老師資料",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            setState(() {
                              _isMemberInfoExpanded = !_isMemberInfoExpanded;
                            });
                          },
                        ),
                      ),

                      // 展開內容為白底
                      if (_isMemberInfoExpanded) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: 

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //指導老師部分 - 三個欄位同一行
                              _buildPlainSection([
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // 標題
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0),
                                        child: Text(
                                          "指導老師/顧問:",
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: _buildInfoRow("姓名:", test[0].advisor_name)),
                                          Expanded(flex: 2, child: _buildInfoRow("職稱:", test[0].advisor_title)),
                                          Expanded(flex: 3, child: _buildInfoRow("所屬機構:", test[0].advisor_school)),
                                        ],
                                      ),
                                    ],
                                  ),
                              ]),

                              _buildPlainSection([
                                for (int i = 0; i < test[0].members.length; i++)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // 標題
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0),
                                        child: Text(
                                          i == 0 ? "隊員${i + 1}(代表人):" : "隊員${i + 1}:",
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // 第一行：姓名、學號、年級、科系
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: _buildInfoRow("姓名:", test[0].members[i].name)),
                                          Expanded(flex: 2, child: _buildInfoRow("學號:", test[0].members[i].uid)),
                                          Expanded(flex: 2, child: _buildInfoRow("年級:", test[0].members[i].grade)),
                                          Expanded(flex: 3, child: _buildInfoRow("科系:", test[0].members[i].department)),
                                        ],
                                      ),
                                      // 第二行：電話、email
                                      Row(
                                        children: [
                                          Expanded(flex: 3, child: _buildInfoRow("電話:", test[0].members[i].phone)),
                                          Expanded(flex: 7, child: _buildInfoRow("Email:", test[0].members[i].email)),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 10),

                                      //學生證
                                      _buildInfoRow("學生證:", test[0].members[i].student_iD_card),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                              ]),


                            ],
                          ),

                        ),
                      ],
                    ],
                  ),
                )
              ),
            ),






            const SizedBox(height: 10),
            
            //展開格子，隊伍資料
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: 

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: 
                  Column(
                    children: [
                      // 灰色底的標題區塊
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(
                            _isProjectInfoExpanded ? Icons.expand_less : Icons.expand_more,
                          ),
                          title: const Text(
                            "參賽作品詳細資料",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            setState(() {
                              _isProjectInfoExpanded = !_isProjectInfoExpanded;
                            });
                          },
                        ),
                      ),

                      if (_isProjectInfoExpanded) ...[

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 參賽隊伍
                              _buildInfoRow("參賽隊伍:", test[0].group),
                              const SizedBox(height: 10),
                              
                              // 團隊名稱
                              _buildInfoRow("團隊名稱:", test[0].team_name),
                              const SizedBox(height: 10),
                              
                              // 隊員列表
                              _buildInfoRow(
                                "隊員:",
                                test[0].members.map((member) => 
                                  "${member.department}系 ${member.name}"
                                ).join("、"),
                              ),
                              const SizedBox(height: 10),
                              
                              // 指導教授
                              _buildInfoRow(
                                "指導教授:",
                                "${test[0].advisor_school} ${test[0].advisor_name+test[0].advisor_title}",
                              ),
                              const SizedBox(height: 10),
                              
                              // 作品名稱
                              _buildInfoRow("作品名稱:", test[0].project_name),
                              const SizedBox(height: 10),
                              
                              // 作品摘要
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "作品摘要:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(test[0].summary),
                                ],
                              ),
                              const SizedBox(height: 10),
                              
                              // YouTube連結
                              _buildInfoRow("YouTube連結:", test[0].yt_url),
                              const SizedBox(height: 10),
                              
                              // GitHub連結
                              _buildInfoRow("GitHub連結:", test[0].github_url),
                              const SizedBox(height: 10),
                              
                              // SDGs 相關
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "SDGs相關:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                  child: Text(test[0].sdgs.join("  ")),
                                  ), 
                                ],
                              ),
                              const SizedBox(height: 10),
                              // 相關文件
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "相關文件:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(test[0].files.join("\n")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],





                    ],
                  ),
                )
              ),
            ),

            
          ],
        ),
      ),
    );
  }


Widget _buildPlainSection(List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    ],
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
}