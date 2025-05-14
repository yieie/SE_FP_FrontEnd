import 'package:flutter/material.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/presentation/widget/basic/basic_scaffold.dart';


/// 詳細公告頁面 
class DetailAnnPage extends StatelessWidget {
  final int aid;

  const DetailAnnPage({super.key, required this.aid});

  // 測試假資料
  static final AnnouncementModel fakeAnnouncement = AnnouncementModel(
    aid: 101,
    title: '2025 春季活動公告',
    content: '''
親愛的同學們您好：

為了迎接充滿活力的春季時光，我們將舉辦「2025 春季成長營」，內容包含專題講座、實作工作坊、跨領域團隊挑戰等多項精彩活動，誠摯邀請大家踴躍參與！

📌 活動時間：2025 年 5 月 20 日至 5 月 24 日  
📍 地點：本校創新學院與綜合大樓  
📝 報名方式：請於 5 月 10 日前填寫線上表單  
🔗 表單連結：https://example.com/signup

注意事項：  
1. 活動全程免費，含午餐與課程材料  
2. 名額有限，額滿為止  
3. 報名成功者將另行通知

敬請把握難得機會，一起激發創意、拓展視野！

學務處 敬上
''',
    time: '2025-05-05 10:30:00',
    uid: 'admin001',
      posterUrl: [
        'https://example.com/posters/spring2025_1.png',
        'https://example.com/posters/spring2025_2.png',
      ],
      file: [
        (fileName: '活動簡章.pdf', fileUrl: 'https://example.com/files/spring2025.pdf'),
        (fileName: '報名表.docx', fileUrl: 'https://example.com/files/signup.docx'),
      ],
  );

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 標題
            Text(
              fakeAnnouncement.title ?? '(無標題)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),

            // 時間
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(
                  fakeAnnouncement.time ?? '-',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 內容
            Text(
              fakeAnnouncement.content ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}