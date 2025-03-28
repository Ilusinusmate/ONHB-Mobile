import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/widgets/bars/back_app_bar.dart';

class GabaritoEditPage extends StatefulWidget {
  final String teamName;
  final int numberOfQuestions;

  const GabaritoEditPage({
    super.key,
    required this.teamName,
    this.numberOfQuestions = 10,
  });

  @override
  State<GabaritoEditPage> createState() => _GabaritoEditPageState();
}

class _GabaritoEditPageState extends State<GabaritoEditPage> {
  late Map<int, int> _gabarito;

  @override
  void initState() {
    super.initState();
    // Initialize with empty answers
    _gabarito = {for (int i = 0; i < widget.numberOfQuestions; i++) i: 0};
  }

  void _updateAnswer(int questionIndex, int answer) {
    setState(() {
      _gabarito[questionIndex] = answer;
    });
  }

  Future<void> _saveGabarito() async {
    // Check if all questions have been answered
    if (_gabarito.values.any((answer) => answer == 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, responda todas as questões'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Save the gabarito
    TeamStorageSystem.updateTeamGabarito(widget.teamName, _gabarito);

    // Show success message and pop the page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gabarito para ${widget.teamName} atualizado'),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pop(_gabarito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: widget.numberOfQuestions,
          itemBuilder: (context, index) {
            return _QuestionCard(
              questionNumber: index + 1,
              currentAnswer: _gabarito[index] ?? 0,
              onAnswerSelected: (answer) => _updateAnswer(index, answer),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveGabarito,
        child: Icon(Icons.save),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final int questionNumber;
  final int currentAnswer;
  final Function(int) onAnswerSelected;

  const _QuestionCard({
    required this.questionNumber,
    required this.currentAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Questão $questionNumber',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(5, (index) {
                final optionValue = index + 1;
                return ChoiceChip(
                  label: Text(String.fromCharCode(64 + optionValue)),
                  selected: currentAnswer == optionValue,
                  onSelected: (_) => onAnswerSelected(optionValue),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
