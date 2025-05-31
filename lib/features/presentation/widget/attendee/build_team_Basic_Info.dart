import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_event.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_textField.dart';
import 'package:front_end/features/presentation/widget/basic/basic_web_dropdownButtonFormField.dart';

Widget buildTeamBasicInfo(BuildContext context, SignUpCompetitionState state){
    final ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 352,
              child: BasicTextfield(
                hintText: '隊伍名稱',
                controller: TextEditingController(text: state.teamName)..selection = TextSelection.collapsed(offset: state.teamName.length),
                onChanged: (value){
                  context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('teamName', value));
                },
              ),
            ),
            SizedBox(
              width: 352,
              child: BasicWebDropdownbuttonFormField(
                hint: Text('參賽組別'),
                items: [
                  const DropdownMenuItem<String>(
                    value: '創意發想組',
                    child: Text('創意發想組', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  const DropdownMenuItem<String>(
                    value: '創業實作組',
                    child: Text('創業實作組', style: TextStyle(fontWeight: FontWeight.bold))
                  )
                ], 
                onChanged:(value){
                  context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('teamType', value));
                }
              ),
            ),
            SizedBox(
              width: 352,
              child: BasicTextfield(
                hintText: '作品名稱',
                controller: TextEditingController(text: state.projectName)..selection = TextSelection.collapsed(offset: state.projectName.length),
                onChanged: (value){
                  context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('projectName', value));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        BasicTextfield(
          hintText: '作品摘要',
          controller: TextEditingController(text: state.projectAbstract)..selection = TextSelection.collapsed(offset: state.projectAbstract.length),
          onChanged: (value){
            context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('projectAbstract', value));
          },
          maxLines: 5,
        ),
        SizedBox(height: 12),
        BasicTextfield(
          hintText: 'YouTube連結',
          controller: TextEditingController(text: state.ytUrl)..selection = TextSelection.collapsed(offset: state.ytUrl.length),
          onChanged: (value){
            context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('ytUrl', value));
          },
        ),
        SizedBox(height: 12),
        BasicTextfield(
          hintText: 'Github連結',
          controller: TextEditingController(text: state.githubUrl)..selection = TextSelection.collapsed(offset: state.githubUrl.length),
          onChanged: (value){
            context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('githubUrl', value));
          },
        ),
        SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: Text("SDGs相關",style: TextStyle(fontSize: 18),)),
        Scrollbar(
          controller: _scrollController,
          thumbVisibility: true, 
          trackVisibility: true, 
          interactive: true,
          thickness: 6,          
          radius: Radius.circular(4),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
            children: sdgsList.map((sdgs) {
              final isSelected = state.sdgs.contains(sdgs.id);
        
              return GestureDetector(
                onTap: () {
                  final Set<int> updatelist = Set.from(state.sdgs);
                  if (isSelected) {
                    updatelist.remove(sdgs.id);
                  } else {
                    updatelist.add(sdgs.id);
                  }
                  context.read<SignUpCompetitionBloc>().add(UpdateFieldEvent('sdgs', updatelist));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.transparent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(sdgs.imagePath,width: 100,height: 100),
                ),
              );
            }).toList(),
            )
          )
        )
      ],
    );
  }