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
  final String student_iD_card;//學生證
  Member(this.name, this.uid, this.grade, this.department, this.phone, this.email,this.student_iD_card);
}

class TeamInfo {
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

  TeamInfo({
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

class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({super.key});

  @override
  State<TeamInfoPage> createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {
  // 測試假資料
  final List<TeamInfo> test = [
    TeamInfo(
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



  String _selectedTab = '隊伍資料'; //當前選中的

  @override
Widget build(BuildContext context) {
  return BasicScaffold(
    child: Center( 
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "隊伍狀態: $_selectedStatus",
                    style: const TextStyle(fontSize: 16),
                  ),
                  
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 221, 99, 78),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero, 
                      ),
                      onPressed: () {
                        // 編輯資料的邏輯
                      },
                      child: const Text(
                        "編輯資料",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedTab = '隊伍資料'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "隊伍資料",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedTab == '隊伍資料' ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 30),
                
                GestureDetector(
                  onTap: () => setState(() => _selectedTab = '隊員暨指導老師資料'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "隊員暨指導老師資料",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedTab == '隊員暨指導老師資料' ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            //分隔線
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Color.fromARGB(255, 0, 0, 0),
                thickness: 2,
              ),
            ),
            
            //內容部分
            if (_selectedTab == '隊伍資料') 
              _buildTeamInfoContent(),
            
            if (_selectedTab == '隊員暨指導老師資料') 
              _buildMemberInfoContent(),
          ],
        ),
      ),
    ),
  );
}

  // 隊伍資料內容
  Widget _buildTeamInfoContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
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
        ),
      ),
    );
  }

  // 隊員暨指導老師資料內容
  Widget _buildMemberInfoContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //指導老師部分
                  _buildPlainSection([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            "指導老師/顧問:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

                  //隊員列表
                  _buildPlainSection([
                    for (int i = 0; i < test[0].members.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              i == 0 ? "隊員${i + 1}(代表人):" : "隊員${i + 1}:",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: _buildInfoRow("姓名:", test[0].members[i].name)),
                              Expanded(flex: 2, child: _buildInfoRow("學號:", test[0].members[i].uid)),
                              Expanded(flex: 2, child: _buildInfoRow("年級:", test[0].members[i].grade)),
                              Expanded(flex: 3, child: _buildInfoRow("科系:", test[0].members[i].department)),
                            ],
                          ),
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