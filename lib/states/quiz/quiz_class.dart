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
    picture:
        'illustrations%2Fquiz1.png?alt=media&token=822df9e3-8fc5-421a-a721-a50594342b03',
  ),
  Quiz(
    id: 2,
    description: 'Random Variable',
    picture:
        'illustrations%2Fquiz2.png?alt=media&token=8b5a7491-effe-4dbc-b210-3ebafe525cfe',
  ),
  Quiz(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture:
        'illustrations%2Fquiz4.png?alt=media&token=9a6cf6dc-d55e-4d8c-a6d7-2fb09917f088',
  ),
  Quiz(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture:
        'illustrations%2Fquiz3.png?alt=media&token=bf21ad83-c8a8-4647-b0c5-cff1f53c61d1',
  ),
  Quiz(
    id: 5,
    description: 'Sampling Distribution',
    picture:
        'illustrations%2Fquiz5.png?alt=media&token=94743a7a-f1b3-46bf-b763-4663e32fb31d',
  ),
  Quiz(
    id: 6,
    description: 'Estimation',
    picture:
        'illustrations%2Fquiz6.png?alt=media&token=96c90f58-9a14-457e-801d-002b1fd31f05&_gl=1*14fm27e*_ga*MTc1MjE1OTY4NS4xNjY2MDcyOTUx*_ga_CW55HF8NVT*MTY5NjI0MDc5Mi4xMjYuMS4xNjk2MjQyMDYyLjQ1LjAuMA..',
  ),
  Quiz(
    id: 7,
    description: 'Hypothesis Testing',
    picture:
        'illustrations%2Fquiz7.png?alt=media&token=5e337b08-4040-451a-b991-9688ea9cae90&_gl=1*1nbhl9f*_ga*MTc1MjE1OTY4NS4xNjY2MDcyOTUx*_ga_CW55HF8NVT*MTY5NjI0MDc5Mi4xMjYuMS4xNjk2MjQyMDcyLjM1LjAuMA..',
  ),
  Quiz(
    id: 8,
    description: 'Chi-Square Test',
    picture:
        'illustrations%2Fquiz8.png?alt=media&token=e689995b-75c2-4ee2-9cd6-f375e422e63b&_gl=1*o5lkca*_ga*MTc1MjE1OTY4NS4xNjY2MDcyOTUx*_ga_CW55HF8NVT*MTY5NjI0MDc5Mi4xMjYuMS4xNjk2MjQyMDc1LjMyLjAuMA..',
  ),
  Quiz(
    id: 9,
    description: 'Regression Analysis and Correlation Analysis',
    picture:
        'illustrations%2Fquiz9.png?alt=media&token=39f22b11-c6b0-4440-b43c-e08693108d5f&_gl=1*1d92npi*_ga*MTc1MjE1OTY4NS4xNjY2MDcyOTUx*_ga_CW55HF8NVT*MTY5NjI0MDc5Mi4xMjYuMS4xNjk2MjQyMDc5LjI4LjAuMA..',
  ),
  Quiz(
    id: 10,
    description: 'Analysis of Variance (ANOVA)',
    picture:
        'illustrations%2Fquiz10.png?alt=media&token=57e31135-5817-4ce8-900d-d55067ef88a6&_gl=1*98wz6f*_ga*MTc1MjE1OTY4NS4xNjY2MDcyOTUx*_ga_CW55HF8NVT*MTY5NjI0MDc5Mi4xMjYuMS4xNjk2MjQyMDkwLjE3LjAuMA..',
  ),
];
