// lib/features/presentation/pages/admin/user_add_page.dart

import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';

class UserAddPage extends StatefulWidget {
  const UserAddPage({Key? key}) : super(key: key);

  @override
  _UserAddPageState createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '新增使用者',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // 姓名
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

                    // Email
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
                    const SizedBox(height: 16),

                    // 密碼
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: '密碼',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return '至少 6 個字元';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // 送出按鈕
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: 提交 _nameController.text、_emailController.text、_passwordController.text
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('已送出新增請求')),
                            );
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text('送出'),
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
