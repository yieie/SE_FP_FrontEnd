// lib/features/presentation/pages/admin/user_list_page.dart

import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 假資料示意
    final dummyUsers = [
      {'id': '1', 'name': 'Alice', 'email': 'alice@example.com'},
      {'id': '2', 'name': 'Bob', 'email': 'bob@example.com'},
      {'id': '3', 'name': 'Charlie', 'email': 'charlie@example.com'},
    ];

    return BasicScaffold(
      child: Column(
        children: [
          // 標題列 + 新增按鈕
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '使用者列表',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text('新增使用者'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/user_add');
                  },
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 模擬列表
          Expanded(
            child: ListView.separated(
              itemCount: dummyUsers.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user = dummyUsers[index];
                return ListTile(
                  title: Text(user['name']!),
                  subtitle: Text(user['email']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: '修改',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/admin/user_modify',
                            arguments: user['id'],
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: '刪除',
                        onPressed: () {
                          // 這裡不做實際刪除，只示意
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('確認刪除'),
                              content: Text('確定要刪除 ${user['name']} 嗎？'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    // 真實邏輯留待日後補
                                  },
                                  child: const Text('刪除'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
