import 'package:front_end/features/domain/entity/SdgItem.dart';

const String APIBaseURL = 'http://se_final_project_backend.local:8081/api';

const HumanitiesAndSocialSciences = ['西洋語文學系', '運動健康與休閒學系', '東亞語文學系', '運動競技學系', '建築學系', '工藝與創意設計學系'];
const Law = ['法律學系', '政治法律學系', '財經法律學系', '法學院博士班'];
const Management = ['應用經濟學系', '亞太工商管理學系', '財務金融學系', '資訊管理學系'];
const Science = ['應用數學系', '生命科學系', '應用化學系', '應用物理學系', '統計學研究所'];
const Enginerring = ['電機工程學系', '土木與環境工程學系', '化學工程及材料工程學系', '資訊工程學系'];
const grade = ['大一','大二','大三', '大四', '大五', '大六','碩一','碩二','碩三','碩四'];
final List<SdgsItem> sdgsList = [
  SdgsItem(id: 1, name: '消除貧窮', imagePath: 'assets/images/sdgs/SDGs_1.png'),
  SdgsItem(id: 2, name: '消除飢餓', imagePath: 'assets/images/sdgs/SDGs_2.png'),
  SdgsItem(id: 3, name: '良好健康和福祉', imagePath: 'assets/images/sdgs/SDGs_3.png'),
  SdgsItem(id: 4, name: '優質教育', imagePath: 'assets/images/sdgs/SDGs_4.png'),
  SdgsItem(id: 5, name: '性別平等', imagePath: 'assets/images/sdgs/SDGs_5.png'),
  SdgsItem(id: 6, name: '潔淨水與衛生', imagePath: 'assets/images/sdgs/SDGs_6.png'),
  SdgsItem(id: 7, name: '可負擔的潔淨能源', imagePath: 'assets/images/sdgs/SDGs_7.png'),
  SdgsItem(id: 8, name: '尊嚴就業與經濟發展', imagePath: 'assets/images/sdgs/SDGs_8.png'),
  SdgsItem(id: 9, name: '產業創新與基礎設施', imagePath: 'assets/images/sdgs/SDGs_9.png'),
  SdgsItem(id: 10, name: '減少不平等', imagePath: 'assets/images/sdgs/SDGs_10.png'),
  SdgsItem(id: 11, name: '永續城市與社區', imagePath: 'assets/images/sdgs/SDGs_11.png'),
  SdgsItem(id: 12, name: '負責任的消費與生產', imagePath: 'assets/images/sdgs/SDGs_12.png'),
  SdgsItem(id: 13, name: '氣候行動', imagePath: 'assets/images/sdgs/SDGs_13.png'),
  SdgsItem(id: 14, name: '水下生命', imagePath: 'assets/images/sdgs/SDGs_14.png'),
  SdgsItem(id: 15, name: '陸域生命', imagePath: 'assets/images/sdgs/SDGs_15.png'),
  SdgsItem(id: 16, name: '和平正義與有力的制度', imagePath: 'assets/images/sdgs/SDGs_16.png'),
  SdgsItem(id: 17, name: '夥伴關係', imagePath: 'assets/images/sdgs/SDGs_17.png'),
];