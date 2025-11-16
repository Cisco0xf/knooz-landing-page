import 'package:flutter/material.dart';
import 'package:knooz_docs_api/constants/assets.dart';

class AboutModel {
  final String icon;
  final double rate;
  final Color color;
  final String title;
  final String darkImage;
  final String lightImage;
  final List<String> about;

  const AboutModel({
    required this.lightImage,
    required this.darkImage,
    required this.about,
    required this.title,
    required this.color,
    required this.rate,
    required this.icon,
  });
}

const List<AboutModel> aboutSections = [
  AboutModel(
    title: "الرئيسية",
    icon: AppImage.home,
    color: Colors.green,
    rate: 0.95,
    about: [
      "واجهة منظمة تجمع كل ما تحتاجه في مكان واحد",
      "خمسة أقسام رئيسية: الأذكار، العبادات، الأحاديث والكتب، الأربعونيات، والهدي النبوي",
      "رياض الصالحين، الشمائل المحمدية، بلوغ المرام، والأدب المفرد",
      "مواقيت الصلاة الدقيقة حسب موقعك الجغرافي",
      "الوصول السريع لكل أقسام التطبيق من شاشة واحدة",
      "تجربة سلسة بدون إعلانات مزعجة",
    ],
    darkImage: AppImage.darkmainHome,
    lightImage: AppImage.lightmainHome,
  ),
  AboutModel(
    title: "القرآن",
    color: Colors.blue,
    icon: AppImage.quran,
    rate: 0.9,
    about: [
      "القرآن الكريم كاملاً بخط واضح ومُنسَّق",
      "البحث عن أي سورة، آية، جزء أو تفسير بسهولة",
      "التفسير المدمج لفهم معاني الآيات الكريمة",
      "الاستماع للآيات بالضغط عليها مباشرة",
      "التمرير التلقائي للقراءة المريحة",
      "التحكم الكامل في إعدادات الخط والحجم",
      "حفظ علامات مرجعية للآيات للرجوع إليها بسهولة",
    ],
    darkImage: AppImage.darkmainQuran,
    lightImage: AppImage.lightmainQuran,
  ),
  AboutModel(
    title: "فيديوهات",
    color: Colors.red,
    icon: AppImage.videos,
    rate: 0.88,
    about: [
      "مقاطع إسلامية قصيرة من يوتيوب مُنتقاة بعناية",
      "خالية تماماً من التبرج والموسيقى والمحتوى المخالف",
      "بدون إعلانات نهائياً - احتراماً لوقتك",
      "خوارزميات ذكية لتصفية المحتوى وضمان جودته",
      "التحكم في عدد المقاطع التي تريد مشاهدتها",
      "محتوى نافع ومفيد يثري معلوماتك الدينية",
    ],
    darkImage: AppImage.darkVideos,
    lightImage: AppImage.lightVideos,
  ),
  AboutModel(
    title: "الحديث",
    color: Colors.amber,
    icon: AppImage.hadith,
    rate: 0.8,
    about: [
      "البحث في ثمانية كتب من أمهات كتب الحديث",
      "يشمل: صحيح البخاري، صحيح مسلم، موطأ مالك، ومسند أحمد",
      "مصادر موثوقة من كتب أهل السنة والجماعة",
    ],
    darkImage: AppImage.darkHadith,
    lightImage: AppImage.lightHadith,
  ),
  AboutModel(
    title: "المسبحة",
    color: Colors.blueGrey,
    icon: AppImage.misbaha,
    rate: 0.7,
    about: [
      "مسبحة إلكترونية لعدّ الأذكار بسهولة",
      "مجموعة رائعة ومنظمة من الأذكار المختارة",
      "تشمل: التسبيح، التحميد، التهليل، والاستغفار",
      "التحكم في اعدادات المسبحة بسهولة",
      "واجهة بسيطة وسهلة الاستخدام",
    ],
    darkImage: AppImage.darkMisbaha,
    lightImage: AppImage.lightMisbaha,
  ),
  AboutModel(
    title: "أوقات الصلاة",
    icon: AppImage.watch,
    color: Colors.purple,
    rate: 0.75,
    about: [
      "مواقيت الصلاة الخمسة حسب موقعك الجغرافي بدقة عالية",
      "معرفة أوقات الليل وأقسامه من الثلث الأول و الخير",
      "تحديد موقعك تلقائياً للحصول على أدق الأوقات",
      "عرض الوقت المتبقي للصلاة القادمة",
      "واجهة واضحة وسهلة القراءة",
    ],
    darkImage: AppImage.darkPrayer,
    lightImage: AppImage.lightPrayer,
  ),
];
