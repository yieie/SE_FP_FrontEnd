import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/error/handleError.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_event.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_state.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_button.dart';
import 'package:front_end/injection_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:web/web.dart' as web;
import 'package:go_router/go_router.dart';
import 'dart:typed_data';

class AnnouncementAddOrModifyPage extends StatefulWidget{
  final int? aid;
  const AnnouncementAddOrModifyPage({super.key, this.aid});

  @override
  _AnnouncementAddOrModifyPageState createState() => _AnnouncementAddOrModifyPageState();
}

class _AnnouncementAddOrModifyPageState extends State<AnnouncementAddOrModifyPage>{
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();
  List<String> originalPoster=[];
  List<String> deletePoster=[];
  List<({String fileName, String fileUrl})> originalFile=[];
  List<({String fileName, String fileUrl})> deleteFile=[];
  List<PlatformFile> newPoster=[];
  List<PlatformFile> newFile=[];

  Future<PlatformFile?> pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    return result?.files.first;
  }

  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
        allowedExtensions: ['pdf'],
      withData: true,
    );

    return result?.files.first;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.aid!=null){
      return BlocProvider<AnnBloc>(
        create: (context) => sl()..add(GetDetailAnnouncement(widget.aid!)),
        child: BlocProvider<AnnModifyAddBloc>(
          create: (context) => sl(),
          child: BasicScaffold(
            child: _buildBody(context)
          ),
        )
        
      );
    }
    else{
      return BlocProvider<AnnModifyAddBloc>(
        create: (context) => sl(),
        child: BasicScaffold(
          child: _buildBody(context)
        )
      );
    }
  }

  Widget _buildBody(BuildContext context){
    return MultiBlocListener(
      listeners: [
        BlocListener<AnnModifyAddBloc,AnnModifyAddState>(
          listener: (context,state){
            if(state is AnnOperateSubmitting){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('送出請求中'),
                ),
              );
            }
            if(state is AnnOperateFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(handleDioError(state.error)),
                ),
              );
            }
            if(state is AnnOperateSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('新增/修改公告成功，將重導至公告列表'),
                ),
              );
              Future.delayed(Duration(seconds: 1));
              context.go('/annManageList/1');
            }
          },
        ),
        if(widget.aid != null)
          BlocListener<AnnBloc,AnnState>(
            listener: (context,state){
              if(state is AnnouncementDetailDone){
                setState(() {
                  titleCtrl.text = state.announcementDetail!.title!;
                  contentCtrl.text = state.announcementDetail!.content!;
                  originalFile = state.announcementDetail!.file!;
                  originalPoster = state.announcementDetail!.posterUrl!;
                });
                print(originalPoster);
                print(originalFile);
              }
            },
          )
      ],
      child: BlocBuilder<AnnModifyAddBloc,AnnModifyAddState>(
        builder: (context,state){
          return SizedBox(
            width: 1120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.go('/annManageList/1'), 
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, 
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left),
                          Text('返回公告列表',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      )
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: BasicWebButton(
                        onPressed: () {
                          final authState  = context.read<AuthBloc>().state;
                          if(authState is Authenticated){
                            final adminid = authState.uid;
                            if(widget.aid == null){
                              context.read<AnnModifyAddBloc>().add(SubmitNewAnnEvent(title: titleCtrl.text, content: contentCtrl.text, poster: newPoster, file: newFile, adminid: adminid));
                            }else{
                              context.read<AnnModifyAddBloc>().add(EditOldAnnEvent(aid: widget.aid!, title: titleCtrl.text, content: contentCtrl.text, poster: newPoster, file: newFile, deletePoster: deletePoster, deleteFile: deleteFile, adminid: adminid));
                            }
                          }
                        },
                        title: widget.aid == null ? '新增公告': '修改公告',
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text("公告標題",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextField(
                  controller:titleCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText:  '標題'
                  ),
                ),
                SizedBox(height: 10,),
                Text("公告內文",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextField(
                  controller: contentCtrl,
                  minLines: 10,
                  maxLines: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: '內文'
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            child: Text('附加檔案',style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: 150,
                            child: BasicWebButton(
                              onPressed: () async {
                                final file = await pickFile();
                                if (file != null) {
                                  setState(() {
                                    newFile.add(file);
                                  });
                                }
                              },
                              title: '點擊上傳',
                              fontSize: 14,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      ...originalFile.map((file) =>
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                web.window.open(file.fileUrl, '_blank');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, 
                              ),
                              child:Text(file.fileName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  deleteFile.add(file);
                                  originalFile.remove(file);
                                });
                              }, 
                              icon: Icon(Icons.delete_forever_outlined)
                            )
                          ]
                        )
                      ),
                      ...newFile.map((file) =>
                        Row(
                          children: [
                            Text(file.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  newFile.remove(file);
                                });
                              }, 
                              icon: Icon(Icons.delete_forever_outlined)
                            )
                          ]
                        )
                      ),
                    ],
                  )
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            child: Text('海報圖片',style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: 150,
                            child: BasicWebButton(
                              onPressed: () async {
                                final file = await pickImageFile();
                                if (file != null) {
                                  setState(() {
                                    newPoster.add(file);
                                  });
                                }
                              },
                              title: '點擊上傳',
                              fontSize: 14,
                              height: 40,
                            ),
                          ),
                          
                        ],
                      ),
                      ...originalPoster.map((url) => 
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(url,width: 500,),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    deletePoster.add(url);
                                    originalPoster.remove(url);
                                  });
                                }, 
                                icon: Icon(Icons.delete_forever_outlined)
                              )
                            ],
                          ),
                        )
                      ),
                      ...newPoster.map((file) => 
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.memory(file.bytes!,width: 500,),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    newPoster.remove(file);
                                  });
                                }, 
                                icon: Icon(Icons.delete_forever_outlined)
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}