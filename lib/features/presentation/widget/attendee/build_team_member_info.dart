 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_event.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:file_picker/file_picker.dart';

Future<String?> _showInputDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  String? errorText;

  return showDialog<String>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('輸入隊員帳號'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '例如 a123456',
                errorText: errorText,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext), // 取消回傳 null
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  final input = controller.text.trim();
                  if (input.isEmpty) {
                    setState(() {
                      errorText = '帳號不能為空';
                    });
                  } else {
                    Navigator.pop(dialogContext, input); // ✅ 回傳輸入值
                  }
                },
                child: Text('確認'),
              ),
            ],
          );
        },
      );
    },
  );
}


Widget buildTeamMemberInfo(BuildContext context, SignUpCompetitionState state){

  Future<PlatformFile?> pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    return result?.files.first;
  }
  final test = [
    Attendee(uid: 'A1115524',name: '黃大禎',department: '資訊工程學系',grade: '大三',email: 'a1115524@gmail.com',phone: '0911122233'),
    Attendee(uid: 'A1115566',name: '黃大禎',department: '資訊工程學系',grade: '大三',email: 'a1115524@gmail.com',phone: '0911122233'),
    Attendee(uid: 'A1115577',name: '黃大禎',department: '資訊工程學系',grade: '大三',email: 'a1115524@gmail.com',phone: '0911122233'),
  ];
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text('隊員人數 ${state.members.length} 人',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          ),
          if(state.members.length <= 6)
            BasicWebButton(
              onPressed:() async {
                final result = await _showInputDialog(context);
                
                if (result != null) {
                  print("使用者輸入了：$result");
                  final checkuidlist = state.members.map((s) => s.uid).toList();
                  if(checkuidlist.contains(result)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('該隊員已在隊伍中'),
                      ),
                    );
                  }else{
                    context.read<SignUpCompetitionBloc>().add(AddTeammateEvent(result));
                  }
                }
              },
              title: '新增隊員',
              fontSize: 16,
              width: 60,
              height: 40,
            )
        ],
      ),
      SizedBox(height: 12,),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.members.length,
        itemBuilder: (context, index) {
          final member = state.members[index];
          final isLeader = index == 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('隊員 ${index + 1}${isLeader ? "（代表人）" : ""}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  if(isLeader == false) 
                    BasicWebButton(
                      width: 60,
                      height: 40,
                      onPressed: (){},
                      title: '刪除隊員',
                      fontSize: 16,
                      backgroundColor: Color(0xffF96D4E),
                    )
                ],
              ),
              SizedBox(height: 12,),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('姓名',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.name)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('學號',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.uid)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('系所',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.department)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('年級',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.grade)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('電子信箱',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.email)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            // color: Color(0xffd9d9d9),
                            border: Border(right: BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)
                            ),
                          ),
                          child: Text('手機號碼',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withAlpha(30),
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: member.phone)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                // color: Color(0xffd9d9d9),
                                border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: state.studentCard[index] == null ? Radius.circular(8) :  Radius.circular(0),
                                  bottomRight: state.studentCard[index] == null ? Radius.circular(0) :  Radius.circular(8)
                                ),
                              ),
                              child: Text('學生證',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                              width: 150,
                              child: BasicWebButton(
                                onPressed: () async {
                                  final file = await pickImageFile();
                                  if (file != null) {
                                    context.read<SignUpCompetitionBloc>().add(UploadStudentCard(index, file));
                                  }
                                },
                                title: '點擊上傳',
                                fontSize: 14,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        if(state.studentCard[index] != null) 
                          Image.memory(state.studentCard[index]!.bytes!,height: 200,)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          );
        },
      )

    ],
  );
}

