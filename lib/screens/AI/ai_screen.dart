import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/screens/AI/ai_response_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/button_width.dart';
import '../../componnets/functions.dart';
import '../../resources/color_manager.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({Key? key}) : super(key: key);

  @override
  State<AIScreen> createState() => _AIScreenState();
}

bool tapped = false;
List arabicList = [
  "وجع بطن",
  "الحيض غير الطبيعي",
  "حموضة",
  "فشل الكبد الحاد",
  "حاسة متغيرة",
  "قلق",
  "ألم في الظهر",
  "ألم في البطن",
  "الرؤوس السوداء",
  "انزعاج المثانة",
  "بثرة",
  "الدم في البلغم",
  "براز مدمي",
  "عدم وضوح الرؤية ومشوهة",
  "ضيق التنفس",
  "أظافر هشة",
  "كدمات",
  "حرق التبول",
  "ألم صدر",
  "قشعريرة",
  "الأيدي والأقدام الباردة",
  "غيبوبة",
  "ازدحام",
  "إمساك",
  "الشعور المستمر بالبول",
  "العطس المستمر",
  "سعال",
  "تشنجات",
  "البول الداكن",
  "تجفيف",
  "اكتئاب",
  "إسهال",
  "بقع ديكروميك",
  "انتفاخ البطن",
  "دوخة",
  "تجفيف ووخز الشفاه",
  "تضخم الغدة الدرقية",
  "الجوع المفرط",
  "اتصالات زوجية اضافية",
  "تاريخ العائلة",
  "معدل ضربات القلب السريع",
  "تعب",
  "الزائد السوائل",
  "رائحة البول الكريهة",
  "صداع",
  "ارتفاع درجة الحرارة",
  "آلام مفصل الورك",
  "تاريخ استهلاك الكحول",
  "زيادة الشهية",
  "عسر الهضم",
  "الأظافر الالتهابية",
  "حكة داخلية",
  "مستوى السكر غير المنتظم",
  "التهيج",
  "تهيج في فتحة الشرج",
  "الم المفاصل",
  "ألم الركبة",
  "قلة التركيز",
  "الخمول",
  "فقدان الشهية",
  "فقدان التوازن",
  "فقدان الرائحة",
  "توعك",
  "حمى خفيفة",
  "تقلب المزاج",
  "تصلب الحركة",
  "البلغم المخاطي",
  "ألم عضلي",
  "الهزال العضلي",
  "ضعف العضلات",
  "غثيان",
  "الم الرقبة",
  "الانفجارات الجلدية العقدية",
  "بدانة",
  "ألم خلف العينين",
  "الألم أثناء حركات الأمعاء",
  "ألم في منطقة الشرج",
  "المشي المؤلم",
  "خفقان",
  "مرور الغازات",
  "بقع في الحلق",
  "البلغم",
  "بوال",
  "عروق بارزة في ربلة الساق",
  "منتفخ الوجه والعينين",
  "البثور المملوءة بالقيح",
  "تلقي نقل الدم",
  "تلقي الحقن غير المعقمة",
  "قرحة حمراء حول الأنف",
  "بقع حمراء على الجسم",
  "احمرار العيون",
  "الأرق",
  "سيلان الأنف",
  "البلغم الصدئ",
  "طارد",
  "يرتجف",
  "الفضة مثل الغبار",
  "ضغط الجيوب الأنفية",
  "تقشير الجلد",
  "الطفح الجلدي",
  "كلام غير واضح",
  "خدوش صغيرة في الأظافر",
  "حركات الغزل",
  "اكتشاف التبول",
  "تصلب الرقبة",
  "نزيف في المعدة",
  "آلام في المعدة",
  "العيون الغارقة",
  "التعرق",
  "تضخم العقد الليمفاوية",
  "تورم المفاصل",
  "تورم المعدة",
  "تورم الأوعية الدموية",
  "الأطراف المتورمة",
  "تورم الساقين",
  "تهيج الحلق",
  "المظهر السام (التيفوس)",
  "تقرحات على اللسان",
  "عدم الثبات",
  "اضطرابات بصرية",
  "القيء",
  "سقي من العيون",
  "ضعف في الأطراف",
  "ضعف أحد جانبي الجسم",
  "زيادة الوزن",
  "فقدان الوزن",
  "ناز القشرة الصفراء",
  "البول الأصفر",
  "اصفرار العيون",
  "جلد مصفر",
  "مثير للحكة"
];
List englishList = [
  "abdominal_pain",
  "abnormal_menstruation",
  "acidity",
  "acute_liver_failure",
  "altered_sensorium",
  "anxiety",
  "back_pain",
  "belly_pain",
  "blackheads",
  "bladder_discomfort",
  "blister",
  "blood_in_sputum",
  "bloody_stool",
  "blurred_and_distorted_vision",
  "breathlessness",
  "brittle_nails",
  "bruising",
  "burning_micturition",
  "chest_pain",
  "chills",
  "cold_hands_and_feets",
  "coma",
  "congestion",
  "constipation",
  "continuous_feel_of_urine",
  "continuous_sneezing",
  "cough",
  "cramps",
  "dark_urine",
  "dehydration",
  "depression",
  "diarrhoea",
  "dischromic_patches",
  "distention_of_abdomen",
  "dizziness",
  "drying_and_tingling_lips",
  "enlarged_thyroid",
  "excessive_hunger",
  "extra_marital_contacts",
  "family_history",
  "fast_heart_rate",
  "fatigue",
  "fluid_overload",
  "foul_smell_of_urine",
  "headache",
  "high_fever",
  "hip_joint_pain",
  "history_of_alcohol_consumption",
  "increased_appetite",
  "indigestion",
  "inflammatory_nails",
  "internal_itching",
  "irregular_sugar_level",
  "irritability",
  "irritation_in_anus",
  "joint_pain",
  "knee_pain",
  "lack_of_concentration",
  "lethargy",
  "loss_of_appetite",
  "loss_of_balance",
  "loss_of_smell",
  "malaise",
  "mild_fever",
  "mood_swings",
  "movement_stiffness",
  "mucoid_sputum",
  "muscle_pain",
  "muscle_wasting",
  "muscle_weakness",
  "nausea",
  "neck_pain",
  "nodal_skin_eruptions",
  "obesity",
  "pain_behind_the_eyes",
  "pain_during_bowel_movements",
  "pain_in_anal_region",
  "painful_walking",
  "palpitations",
  "passage_of_gases",
  "patches_in_throat",
  "phlegm",
  "polyuria",
  "prominent_veins_on_calf",
  "puffy_face_and_eyes",
  "pus_filled_pimples",
  "receiving_blood_transfusion",
  "receiving_unsterile_injections",
  "red_sore_around_nose",
  "red_spots_over_body",
  "redness_of_eyes",
  "restlessness",
  "runny_nose",
  "rusty_sputum",
  "scurring",
  "shivering",
  "silver_like_dusting",
  "sinus_pressure",
  "skin_peeling",
  "skin_rash",
  "slurred_speech",
  "small_dents_in_nails",
  "spinning_movements",
  "spotting_urination",
  "stiff_neck",
  "stomach_bleeding",
  "stomach_pain",
  "sunken_eyes",
  "sweating",
  "swelled_lymph_nodes",
  "swelling_joints",
  "swelling_of_stomach",
  "swollen_blood_vessels",
  "swollen_extremeties",
  "swollen_legs",
  "throat_irritation",
  "toxic_look_(typhos)",
  "ulcers_on_tongue",
  "unsteadiness",
  "visual_disturbances",
  "vomiting",
  "watering_from_eyes",
  "weakness_in_limbs",
  "weakness_of_one_body_side",
  "weight_gain",
  "weight_loss",
  "yellow_crust_ooze",
  "yellow_urine",
  "yellowing_of_eyes",
  "yellowish_skin",
  "itching"
];
List<bool> boolList = List<bool>.filled(englishList.length, false);
List recom = [];

class _AIScreenState extends State<AIScreen> {
  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Medical AI",
            style: TextStyle(
                color: ColorManager.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: OverlayLoaderWithAppIcon(
          borderRadius: 90.w,
          appIconSize: 20.w,
          appIcon: ClipRRect(
              borderRadius: BorderRadius.circular(20.w),
              child: Image.asset("assets/Mediclica.jpg")),
          overlayBackgroundColor: ColorManager.white,
          circularProgressColor: ColorManager.grey,
          isLoading: state is GetAiLoadingState,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionPanelList(
                  animationDuration: Duration(seconds: 1),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      tapped = isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(" Choose What You Feel..!"),
                        );
                      },
                      body: Container(
                        height: 100.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          // Remove the inner SingleChildScrollView
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: false,
                          itemCount: arabicList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                englishList[index],
                                style: TextStyle(
                                    color: boolList[index] == true
                                        ? ColorManager.primary
                                        : Colors.grey),
                              ),
                              onTap: () {
                                setState(() {
                                  boolList[index] = !boolList[index];
                                });
                                if (boolList[index] == true) {
                                  recom.add(englishList[index]);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      isExpanded: tapped,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            children: [
              widthButton(
                textButton: "Ask Us",
                onPress: () async {
                  tapped = false;
                  boolList = List<bool>.filled(englishList.length, false);
                  await LayoutCubit.get(context).aiRecom(reco: recom);
                },
              ),
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if (state is GetAiSucsessState) {
          Functions.navigatorPush(
              context,
              AiRecommendationScreen(
                aiModel: cubit.aiModel!,
              ));
        }
      },
    );
  }
}
