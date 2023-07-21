import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizes/layout/home/getx/quiz_controller.dart';
import 'package:quizes/models/question_model.dart';
import 'package:quizes/shared/components/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 140,
  }) : super(key: key);
  final Function() onPressed;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: HexColor('000028'),
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: onPressed,
        label: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
class AnswerOption extends StatelessWidget {
  const AnswerOption({
    Key? key,
    required this.text,
    required this.index,
    required this.questionId,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int index;
  final int questionId;
  final Function() onPressed;
//هنا الويدجت بتاععت الاجابات
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: Get.find<QuizController>(),
      builder: (controller) => InkWell(
          onTap: controller.checkIsQuestionAnswered(questionId) ? null : onPressed,
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                Border.all(width: 3, color: controller.getColor(index))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${index + 1}. ',
                        style: Theme.of(context).textTheme.headline6,
                        children: [
                          TextSpan(
                            text: text,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ]),
                  ),
                  if (controller.checkIsQuestionAnswered(questionId) &&
                      controller.selectAnswer == index)
                    Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.getColor(index),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            shape: BoxShape.circle),
                        child: Icon(
                          controller.getIcon(index),
                          color: Colors.white,
                        ))
                ],
              ),
            ),
          )),
    );
  }
}
class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.sec.value / 15),
              color: HexColor('000028'),
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.sec.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: KPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.sizeOf(context).height*0.5,
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionModel.question,
                  style: Theme.of(context).textTheme.headline6,
                ),
                //const SizedBox(height: 15),
                const Spacer(
                  flex: 1,
                ),
                ...List.generate(
                    questionModel.options.length,
                        (index) => Column(
                      children: [
                        AnswerOption(
                            questionId: questionModel.id,
                            text: questionModel.options[index],
                            index: index,
                            onPressed: () => Get.find<QuizController>()
                                .checkAnswer(questionModel, index)),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    )),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          )),
    );
  }
}