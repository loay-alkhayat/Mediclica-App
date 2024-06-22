import 'package:flutter/material.dart';
import 'package:mediclica/models/MainScreensModels/ai_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/button_width.dart';
import '../../resources/color_manager.dart';

class AiRecommendationScreen extends StatelessWidget {
  final AIModel? aiModel;

  const AiRecommendationScreen({Key? key, this.aiModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Medical AI",
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: aiModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          final recommendation = aiModel!.data![index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommendation ${index + 1}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    title: "Your Chances: ",
                    value: recommendation.chances.toString(),
                  ),
                  _buildInfoRow(
                    title: "Disease: ",
                    value: recommendation.disease!,
                  ),
                  _buildInfoRow(
                    title: "Specialist: ",
                    value: recommendation.specialist!,
                  ),
                  _buildDescription(recommendation.description!),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            widthButton(
              textButton: "Done",
              onPress: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description: ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
