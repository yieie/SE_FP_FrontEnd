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



class data {

  final int rank; //名次

  final String teamName; //隊伍名稱
  final String teamType; //參賽組別
  final String workName; //作品名稱
  final String workAbstract;//作品摘要
  final String sdgs;//SDGs
  final String workIntro;//作品說明書檔案路徑
  final List<String> workUrls;//yt、github連結
  data({required this.rank,required this.teamName,required this.teamType,
  required this.workName,required this.workAbstract,
  required this.sdgs,required this.workIntro,required this.workUrls});
}

final List<data> test = [
  data(rank:1,
  teamName: "隊伍名稱",
  teamType: "參賽組別",
  workName: "作品名稱",
  workAbstract: "作品摘要",
  sdgs: "1, 2",
  workIntro: "作品說明書檔案路徑",
  workUrls: ["youtube連結","github連結"]),
];

class Member {
  final String department; //科系
  final String name;      //隊員名字
  Member(this.department,this.name);
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