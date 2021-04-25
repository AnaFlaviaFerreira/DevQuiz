import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:dev_quiz/challenge/widgets/next__button/next_button_widget.dart';
import 'package:dev_quiz/core/app_images.dart';
import 'package:dev_quiz/core/app_text_styles.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int lenght;
  final int result;
  final int resultWrong;

  const ResultPage({
    Key? key,
    required this.title,
    required this.lenght,
    required this.result,
    required this.resultWrong,
  }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(result == 0 ? AppImages.error : AppImages.trophy),
              Column(
                children: [
                  Text.rich(TextSpan(text: result == 0 && resultWrong == 0 ? 'Não desista, faça as questões' : result == 0 ? 'Não desista, você pode melhorar!' : 'Parabéns!', style: AppTextStyles.heading40),textAlign: TextAlign.center),
                  SizedBox(height: 16,),
                  Text.rich(TextSpan(text: result == 0 && resultWrong == 0 ? 'Você não respondeu' : result == 0 ? "Você não concluiu" : "Você concluiu", style: AppTextStyles.body, children: [
                    TextSpan(text: "\n$title", style: AppTextStyles.bodyBold),
                    TextSpan(text: result == 0 && resultWrong == 0 ? '\ncom 0 de $lenght questões respondidas' : result == 0 ? '\ncom $resultWrong de $lenght erros' : '\ncom $result de $lenght acertos' , style: AppTextStyles.body),
                  ]), textAlign: TextAlign.center,),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 68),
                        child: NextButtonWidget.purple(label: "Compartilhar", onTap: (){
                          Share.share('DevQuiz NLW 5 Fluttert: \nResultado do Quiz: $title \nObtive:${result/lenght}% aproveitamento!');
                        }),
                      ))
                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 68),
                        child: NextButtonWidget.white(label: "Voltar ao início", onTap: (){
                          Navigator.pop(context);
                        }),
                      ))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
