import 'package:dev_quiz/challenge/challenge_controller.dart';
import 'package:dev_quiz/challenge/widgets/next__button/next_button_widget.dart';
import 'package:dev_quiz/challenge/widgets/question_indicator/question_indicator.dart';
import 'package:dev_quiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  ChallengePage({Key? key, required this.questions}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage(){
    if(controller.currentPage < widget.questions.length)
      pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.linear);//opção de criar a animação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: SafeArea(top: true, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            IconButton(icon: Icon(Icons.close), onPressed: () { Navigator.pop(context); }),
            ValueListenableBuilder<int>(valueListenable: controller.currentPageNotifier, builder: (context,value,_) => QuestionIndicatorWidget(
              currentPage: value,
              lenght: widget.questions.length
            )),
          ]
        )),//deixa uma área segura no top, por causa da appBar
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),//bloqueando o sccroll para os lados
        controller: pageController,
        children: widget.questions.map((e) => QuizWidget(question: e, onChange: nextPage)).toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier, 
                builder: (context, value,_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(value < widget.questions.length)
                      Expanded(child: NextButtonWidget.white(label: "Pular", onTap: nextPage,)),
                    if(value == widget.questions.length)
                      Expanded(child: NextButtonWidget.green(label: "Confirmar", onTap: () {Navigator.pop(context);})),
                  ],
                )
              ),
        ),
      ),
    );
  }
}