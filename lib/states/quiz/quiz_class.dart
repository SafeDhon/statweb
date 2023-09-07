// ignore_for_file: non_constant_identifier_names

class Quiz {
  int id;
  String description;
  String picture;
  Quiz({
    required this.id,
    required this.description,
    required this.picture,
  });
}

List<Quiz> quiz_units = [
  Quiz(
    id: 1,
    description: 'Probability',
    picture: 'quiz1.png',
  ),
   Quiz(
    id: 2,
    description: 'Random Variable',
    picture: 'quiz2.png',
  ),
   Quiz(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: 'quiz3.png',
  ),
   Quiz(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: 'quiz4.png',
  ),
   Quiz(
    id: 5,
    description: 'Sampling Distribution',
    picture: 'quiz5.png',
  ),
];
