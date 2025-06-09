  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_event.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:web/web.dart' as web;

Future<String?> _showInputDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  String? errorText;

  return showDialog<String>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('輸入指導教授/顧問帳號'),
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



Widget buildTeacherInfoWithFiles(BuildContext context, SignUpCompetitionState state,{bool editmode = false}){
    final AddTeacherIsAble = state.teacherID == '';

    Future<PlatformFile?> pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
         allowedExtensions: ['pdf'],
        withData: true,
      );

      return result?.files.first;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatefulBuilder(
          builder:(context, setState) {
            return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('指導老師/顧問', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
              if(AddTeacherIsAble && !editmode)
                BasicWebButton(
                  onPressed:() async {
                    final result = await _showInputDialog(context);
                    
                    if (result != null) {
                      print("使用者輸入了：$result");
                      context.read<SignUpCompetitionBloc>().add(AddTeacherEvent(result));
                    }
                  },
                  title: '新增指導老師/顧問',
                  fontSize: 16,
                  width: 100,
                  height: 40,
                )
              else
                BasicWebButton(
                  onPressed:()=>_showInputDialog(context),
                  title: '刪除指導老師/顧問',
                  fontSize: 16,
                  width: 100,
                  height: 40,
                )
            ],
          );
        }),
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
                      controller: TextEditingController(text: state.teacherName)
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
                    child: Text('職稱',style: TextStyle(fontWeight: FontWeight.bold)),
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
                      controller: TextEditingController(text: state.teacherTitle)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 600,
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
                    child: Text('所屬機構(學校)/單位(系所)',style: TextStyle(fontWeight: FontWeight.bold)),
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
                      controller: TextEditingController(text: '${state.teacherOrganization}/${state.teacherDepartment}')
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Text('檔案上傳區', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
            Container(
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
                    child: Text('作品說明書',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  if(state.introductionFile != null)
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withAlpha(30),
                          border: InputBorder.none, 
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        readOnly: true,
                        controller: TextEditingController(text: state.introductionFile!.name)
                      ),
                    )
                  else if(state.cloudIntroductionFile != null && editmode)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          web.window.open(state.cloudIntroductionFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('作品說明書(點擊查看)'),
                      )
                    ),
                  SizedBox(
                    width: 150,
                    child: BasicWebButton(
                      onPressed: () async {
                        final file = await pickFile();
                        if (file != null) {
                          context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('introduction', file));
                        }
                      },
                      title: '點擊上傳',
                      fontSize: 14,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
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
                    child: Text('提案切結書',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  if(state.affidavitFile != null)
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withAlpha(30),
                          border: InputBorder.none, 
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        readOnly: true,
                        controller: TextEditingController(text: state.affidavitFile!.name)
                      ),
                    )
                  else if(state.cloudAffidavitFile != null && editmode)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          web.window.open(state.cloudAffidavitFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('提案切結書(點擊查看)'),
                      )
                    ),
                  SizedBox(
                    width: 150,
                    child: BasicWebButton(
                      onPressed: () async {
                        final file = await pickFile();
                        if (file != null) {
                          context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('affidavit', file));
                        }
                      },
                      title: '點擊上傳',
                      fontSize: 14,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    child: Text('個資同意書',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  if(state.consentFile != null)
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withAlpha(30),
                          border: InputBorder.none, 
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        readOnly: true,
                        controller: TextEditingController(text: state.consentFile!.name)
                      ),
                    )
                  else if(state.cloudConsentFile != null && editmode)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          web.window.open(state.cloudConsentFile!, '_blank');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, 
                        ),
                        child: Text('個資同意書(點擊查看)'),
                      )
                    ),
                  SizedBox(
                    width: 150,
                    child: BasicWebButton(
                      onPressed: () async {
                        final file = await pickFile();
                        if (file != null) {
                          context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('consent', file));
                        }
                      },
                      title: '點擊上傳',
                      fontSize: 14,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
