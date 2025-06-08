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
  final List<int> sdgs;//sdgs
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



class Member {
  final String department; // 系所
  final String name;      // 名字

  Member(this.department, this.name);

  @override
  String toString() => "$department $name";
}

class teacher_project_view_list {
  final List<teamInfo> team_Info;
  final List<advisorInfo> advisor_Info;
  final List<memberInfo> member_Info;

  teacher_project_view_list({
    required this.team_Info,
    required this.advisor_Info,
    required this.member_Info,
  });
}

final List<teacher_project_view_list> test2 = [
  teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
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


  teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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

    teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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

    teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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

    teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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

    teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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

    teacher_project_view_list(
    team_Info: [
      teamInfo(
        "待上傳", 
        "對對隊", 
        "創意發想組", 
        "作品名稱", 
        "作品摘要",
        ["https://example.com/work1", "https://example.com/work2"],
        [1, 2], // SDGs 列表
        "作品說明書檔案路徑",
        "個資同意書檔案路徑",
        "提案切結書檔案路徑"
      )
    ],
    advisor_Info: [
      advisorInfo(
        "黃老師",
        [
          teacherInfo("指導老師", "資訊工程系", "高雄大學")
        ]
      )
    ],
    member_Info: [
      memberInfo(
        "a1115511",
        "陳大明",
        "a1115511@gmail.com",
        "0912345678",
        [
          studentInfo("資訊工程系", "大一")
        ],
        [
          attendeeInfo("student_card_path_1.jpg", "2025team123", "2025work456")
        ]
      ),
      memberInfo(
        "a1115522",
        "張四",
        "a1115522@gmail.com",
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






class TeacherViewProjectPage extends StatefulWidget {
  const TeacherViewProjectPage({super.key});

  @override
  State<TeacherViewProjectPage> createState() => _TeacherViewProjectPageState();
}

class _TeacherViewProjectPageState extends State<TeacherViewProjectPage> {
  int currentPage = 1;
  final int itemsPerPage = 5;

  int get totalPages => (test2.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    final currentItems = test2.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
    
    return BasicScaffold(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 750),
              child: Text(
                "指導隊伍列表",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 900,
              height: 400,
              child: ListView.builder(
                itemCount: currentItems.length,
                itemBuilder: (context, index) {
                  final project = currentItems[index];
                  return Container(
                    width: 900,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 原有内容保持不变...
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "參賽年度：${project.member_Info.first.attendee_Info.first.workId.substring(0, 4)}", 
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child:Text("參賽組別：${project.team_Info.map((team) => team.teamType).join(", ")}",
                                style: TextStyle(fontSize: 16), 
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Text("隊伍名稱：${project.team_Info.map((team) => team.teamName).join(", ")}"
                          ,style: TextStyle(fontSize: 16)),

                        SizedBox(height: 4),

                        Text("作品名稱：${project.team_Info.map((team) => team.workName).join(", ")}"
                          ,style: TextStyle(fontSize: 16)),

                        SizedBox(height: 8),

                                                  //隊員2個2個排
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("隊員：", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //project.team_Info.map((team) => team.teamName
                                    if (project.team_Info.isNotEmpty && project.team_Info.first.teamName.isNotEmpty)
                                        Text(
                                          project.member_Info.take(2).map((m) => 
                                            "${m.student_Info.first.department} ${m.name}"
                                          ).join("、"),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                    
                                    // 後續行
                                    ...List.generate(
                                      ((project.member_Info.length - 1) / 2).ceil(),
                                      (rowIndex) {
                                        final startIndex = rowIndex * 2 + 2;
                                        final endIndex = (startIndex + 2) > project.member_Info.length
                                            ? project.member_Info.length
                                            : (startIndex + 2);
                                        final rowMembers = project.member_Info.sublist(startIndex, endIndex);
                                        
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            rowMembers.map((m) => 
                                              "${m.student_Info.first.department} ${m.name}"
                                            ).join("、"),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            // 分頁按鈕
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: currentPage > 1
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                      ),
                      Text('$currentPage / $totalPages'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: currentPage < totalPages
                            ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}