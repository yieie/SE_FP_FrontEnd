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




class Member2 {
  final String department; //科系
  final String name;      //隊員名字
  Member2(this.department,this.name);
}

class PastProjectDetail {
  final String advisor_name;//指導老師名字
  final String advisor_title;//指導老職稱
  final String advisor_school; //指導老師所屬機構
  final List<Member> members; //成員的各個資訊

  final int rank;
  final String group; //參賽組別
  final String team_name; //團隊名稱
  final String project_name; //團隊名稱
  final String summary; //摘要
  final String yt_url; //youtube連結
  final String github_url; //github連結
  final List<String> sdgs;//sdgs
  final List<String> files;//相關文件

  PastProjectDetail({
    required this.advisor_name,
    required this.advisor_title,
    required this.advisor_school,
    required this.members,

    required this.rank,
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

class PastProjectDetailPage extends StatefulWidget {
  const PastProjectDetailPage({super.key});

  @override
  State<PastProjectDetailPage> createState() => _PastProjectDetailPageState();
}

class _PastProjectDetailPageState extends State< PastProjectDetailPage> {

  // 測試假資料
  final List<PastProjectDetail> test = [
    PastProjectDetail(
      advisor_name: "老師名字test1",
      advisor_title: "老師職稱test1",
      advisor_school: "老師所屬機構test1",
      members: [
        Member("資訊工程學系","學生1"),
        Member("資訊工程學系","學生2"),
        Member("資訊工程學系","學生3"),
      ], 

      rank:1,
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


@override
Widget build(BuildContext context) {
  return BasicScaffold(
    child: Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 參賽組別
                  _buildInfoRow("名次:", "第${['一','二','三'][test[0].rank-1]}名"),
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
                  
                  // 參賽組別
                  _buildInfoRow("參賽組別:", test[0].group),
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
                      Text(
                        test[0].files.join("\n"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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