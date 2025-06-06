// lib/features/presentation/pages/admin/user_modify_page.dart

import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';

class UserModifyPage extends StatefulWidget {
  final String userId; // 透過路由參數傳入
  const UserModifyPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserModifyPageState createState() => _UserModifyPageState();
}

class _UserModifyPageState extends State<UserModifyPage> {
  final _formKey = GlobalKey<FormState>();

  // 先用 TextEditingController 示意，值可在 initState 中根據 userId 拿真實資料並設定
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    // 假資料示意：實際可依 userId 去後端拿資料後再填充
    final dummyData = {
      '1': {'name': 'Alice', 'email': 'alice@example.com'},
      '2': {'name': 'Bob', 'email': 'bob@example.com'},
      '3': {'name': 'Charlie', 'email': 'charlie@example.com'},
    };

    final data = dummyData[widget.userId] ?? {'name': '', 'email': ''};

    _nameController = TextEditingController(text: data['name']);
    _emailController = TextEditingController(text: data['email']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 標題
            Text(
              '修改使用者資料 (ID: ${widget.userId})',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Form
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // 姓名欄位
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: '姓名',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入姓名';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email 欄位
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: '電子郵件',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入電子郵件';
                        }
                        if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
                          return '請輸入有效的電子郵件';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // 儲存按鈕
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: 將 _nameController.text 與 _emailController.text 提交給後端更新
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('已送出更新請求')),
                            );
                            Navigator.pop(context, true); // 回列表頁
                          }
                        },
                        child: const Text('儲存'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
