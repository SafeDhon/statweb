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
    picture: 'illustrations%2Fquiz1.png?alt=media&token=822df9e3-8fc5-421a-a721-a50594342b03',
  ),
   Quiz(
    id: 2,
    description: 'Random Variable',
    picture: 'illustrations%2Fquiz2.png?alt=media&token=8b5a7491-effe-4dbc-b210-3ebafe525cfe',
  ),
   Quiz(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: 'illustrations%2Fquiz3.png?alt=media&token=bf21ad83-c8a8-4647-b0c5-cff1f53c61d1',
  ),
   Quiz(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: 'illustrations%2Fquiz4.png?alt=media&token=9a6cf6dc-d55e-4d8c-a6d7-2fb09917f088',
  ),
   Quiz(
    id: 5,
    description: 'Sampling Distribution',
    picture: 'illustrations%2Fquiz5.png?alt=media&token=94743a7a-f1b3-46bf-b763-4663e32fb31d',
  ),
];
