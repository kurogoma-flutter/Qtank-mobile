// 📦 Package imports:
class QaListModel {
  QaListModel({
    required this.question,
    required this.answer,
  });

  factory QaListModel.fromMap(Map<String, dynamic> data) => QaListModel(
        question: data['question'],
        answer: data['answer'],
      );

  factory QaListModel.initialData() => QaListModel(
        question: '',
        answer: '',
      );

  final String question;
  final String answer;

  Map<String, dynamic> toMap() => {
        'question': question,
        'answer': answer,
      };
}
