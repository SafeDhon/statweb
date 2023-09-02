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
    picture: '1kzj9zzgny0l3xgKK9p_5RMC3Vm1W2Dpu',
  ),
   Quiz(
    id: 2,
    description: 'Random Variable',
    picture: '16bbIvEcA_jYpSTTmHTC5uAQPTmoCsBDj',
  ),
   Quiz(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: '1vFsv-V73MwAtQ3qgFM_Ns_VIh4wtn30Q',
  ),
   Quiz(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: '18xvNN2wCVAgNBTV5A8xzaGqDgZIvknx2',
  ),
   Quiz(
    id: 5,
    description: 'Sampling Distribution',
    picture: '1vAayJ5VlZ_dez_QrOk1CvupeJkKYM4cP',
  ),
];
