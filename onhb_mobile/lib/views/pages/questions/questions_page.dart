import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/storage_system.dart';

enum QuestionsEnum { question1, question2, question3, question4, question5 }

class _QuestionCell extends StatefulWidget {
  final String questionText;
  final int questionIndex;
  final Function(int, int) callback;

  const _QuestionCell({
    required this.questionText,
    required this.callback,
    required this.questionIndex,
  });

  @override
  State<_QuestionCell> createState() => _QuestionCellState();
}

class _QuestionCellState extends State<_QuestionCell> {
  int? selectedValue; // Initialize to a default value

  var alphaMap = {1: 'A', 2: 'B', 3: 'C', 4: 'D', 5: 'E'};

  Radio<int> _createQuestionRadioCell(int value) {
    return Radio<int>(
      value: value,
      groupValue: selectedValue,
      onChanged: (int? newValue) {
        if (newValue == null) return;
        setState(() {
          selectedValue = newValue;
        });
        widget.callback(widget.questionIndex, newValue);
      },
    );
  }

  List<Row> _createQuestionsRow(int numberOfQuestions) {
    return List.generate(numberOfQuestions, (int idx) {
      idx++;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(alphaMap[idx]!), _createQuestionRadioCell(idx)],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Card(
            margin: EdgeInsets.only(bottom: 15, top: 8),
            color: Theme.of(context).primaryColor,

            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                widget.questionText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            bool isRow = constraints.maxWidth > 350;

            return isRow
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _createQuestionsRow(5),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _createQuestionsRow(5),
                );
          },
        ),
      ],
    );
  }
}

class _QuestionCellWrapper extends StatelessWidget {
  final String questionText;
  final int questionIndex;
  final Function(int, int) callback;

  const _QuestionCellWrapper({
    required this.questionText,
    required this.questionIndex,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: _QuestionCell(
          questionText: questionText,
          callback: callback,
          questionIndex: questionIndex,
        ),
      ),
    );
  }
}

class QuestionsPage extends StatefulWidget {
  final int numberOfQuestions;

  const QuestionsPage({super.key, required this.numberOfQuestions});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _answers = <int, int>{};

  void _submitForm() {
    GabaritoStorageSystem.saveGabarito(_answers);
  }

  void _setAnswer(int questionIndex, int value) {
    setState(() {
      _answers[questionIndex] = value;
      debugPrint(_answers.toString());
    });
  }

  void _callback(int questionIndex, int value) {
    _setAnswer(questionIndex, value);
    StorageSystem.saveMap<int, int>(StorageSystem.gabaritoKey, _answers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),

          Expanded(
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    widget.numberOfQuestions,
                    (index) => _QuestionCellWrapper(
                      questionText: 'Questão ${index + 1}',
                      callback: _callback,
                      questionIndex: index,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 5),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 100),
            child: Divider(thickness: 2, color: Theme.of(context).primaryColor),
          ),

          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text("Salvar Gabarito"),
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
