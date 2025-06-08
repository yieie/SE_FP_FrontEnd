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

class teamInfo {
  final String workSate;//作品狀態
  final String teamName;//隊伍名    
  final String teamType;//參賽組別      
  final String workName;//作品名      
  final String workAbstract;//作品摘要          
  final List<String> workUrls;//作品連結:yt和github
  final String sdgs;//sdgs
  final String workIntroduction;//作品說明書 
  final String workConsent;//個資同意書     
  final String workAffidavit;//提案切結書 

  teamInfo(this.workSate, this.teamName, this.teamType, 
  this.workName, this.workAbstract, this.workUrls
  ,this.sdgs, this.workIntroduction, this.workConsent,this.workAffidavit
  );
}

class teacherInfo {
  final String title;//職位 
  final String department;//系所      
  final String organization;//學校  

  teacherInfo(this.title, this.department, this.organization);
} 

class advisorInfo {
  final String name;//老師名字       
  final List<teacherInfo> teacher_Info;   
  advisorInfo(this.name,this.teacher_Info);
} 

class studentInfo {
  final String department;//系所 
  final String grade;//年級      

  studentInfo(this.department,this.grade);
}

class attendeeInfo {
  final String studentCard;//學生證 
  final String teamId;//隊伍id      
  final String workId;//作品id  
  attendeeInfo(this.studentCard,this.teamId,this.workId);
}

class memberInfo {
  final String uId;//帳號id 
  final String name;//參賽者名字      
  final String email;//信箱      
  final String phone;//電話             
  final List<studentInfo> student_Info;
  final List<attendeeInfo> attendee_Info;

  memberInfo(this.uId, this.name, this.email, 
  this.phone, this.student_Info, this.attendee_Info);
}

class project_verify_detail {
  final List<teamInfo> team_Info;
  final List<advisorInfo> advisor_Info;
  final List<memberInfo> member_Info;

  project_verify_detail({
    required this.team_Info,
    required this.advisor_Info,
    required this.member_Info,
  });
}


final List<project_verify_detail> test2 = [
  project_verify_detail(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        "1, 2",
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "陳老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],

    member_Info: [
      memberInfo(
        "a1115555",
        "陳小明",
        "a1115555@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115566",
        "張三",
        "a1115566@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大三")
        ],
        [
          attendeeInfo("student_card_path_2.jpg", "2025team123", "2025work456")
        ]
      )
    ]
  ),
];

class ProjectVerifyDetailPage extends StatefulWidget {
  const ProjectVerifyDetailPage({super.key});

  @override
  State<ProjectVerifyDetailPage> createState() => _ProjectVerifyDetailPageState();
}

class _ProjectVerifyDetailPageState extends State<ProjectVerifyDetailPage> {
  final project = test2[0];
  final team = test2[0].team_Info[0];
  final advisor = test2[0].advisor_Info[0];
  final members = test2[0].member_Info;

  String _selectedStatus = '待審核';
  final List<String> _statusOptions = ['待審核', '已審核', '需補件'];

  bool _isMemberInfoExpanded = false;
  bool _isProjectInfoExpanded = false;

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
                        // Update logic
                      },
                      child: const Text("更新狀態",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
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

                      if (_isMemberInfoExpanded) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
  
                              _buildPlainSection([
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0),
                                      child: Text(
                                        "指導老師/顧問:",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(flex: 2, child: _buildInfoRow("姓名:", advisor.name)),
                                        Expanded(flex: 2, child: _buildInfoRow("職稱:", advisor.teacher_Info[0].title)),
                                        Expanded(flex: 3, child: _buildInfoRow("所屬機構:", advisor.teacher_Info[0].organization)),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),


                              _buildPlainSection([
                                for (int i = 0; i < members.length; i++)
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
                                          Expanded(flex: 2, child: _buildInfoRow("姓名:", members[i].name)),
                                          Expanded(flex: 2, child: _buildInfoRow("學號:", members[i].uId)),
                                          Expanded(flex: 2, child: _buildInfoRow("年級:", members[i].student_Info[0].grade)),
                                          Expanded(flex: 3, child: _buildInfoRow("科系:", members[i].student_Info[0].department)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 3, child: _buildInfoRow("電話:", members[i].phone)),
                                          Expanded(flex: 7, child: _buildInfoRow("Email:", members[i].email)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      _buildInfoRow("學生證:", members[i].attendee_Info[0].studentCard),
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
            

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
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
                              _buildInfoRow("參賽組別:", team.teamType),
                              const SizedBox(height: 10),
                              _buildInfoRow("團隊名稱:", team.teamName),
                              const SizedBox(height: 10),
                              _buildInfoRow(
                                "隊員:",
                                members.map((member) => 
                                  "${member.student_Info[0].department}系 ${member.name}"
                                ).join("、"),
                              ),
                              const SizedBox(height: 10),
                              _buildInfoRow(
                                "指導教授:",
                                "${advisor.teacher_Info[0].organization} ${advisor.name}${advisor.teacher_Info[0].title}",
                              ),
                              const SizedBox(height: 10),
                              _buildInfoRow("作品名稱:", team.workName),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "作品摘要:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(team.workAbstract),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildInfoRow("YouTube連結:", team.workUrls.isNotEmpty ? team.workUrls[0] : "無"),
                              const SizedBox(height: 10),
                              _buildInfoRow("GitHub連結:", team.workUrls.length > 1 ? team.workUrls[1] : "無"),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "SDGs相關:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(team.sdgs),
                                  ), 
                                ],
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "相關文件:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    [
                                      if (team.workIntroduction.isNotEmpty) "作品說明書: ${team.workIntroduction}",
                                      if (team.workConsent.isNotEmpty) "個資同意書: ${team.workConsent}",
                                      if (team.workAffidavit.isNotEmpty) "提案切結書: ${team.workAffidavit}",
                                    ].join("\n"),
                                  ),
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