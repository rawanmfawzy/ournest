class OnboardingRequest {
  final bool isDoctor;
  final String role;
  final bool isPregnant;
  final double height;
  final double weight;
  final bool isFirstChild;
  final String knowledgeType;
  final String? lastMenstrualDate;
  final int? gestationalWeeks;
  final int? gestationalDays;
  final String? conceptionDate;
  final String dateOfBirth;

  OnboardingRequest({
    required this.isDoctor,
    required this.role,
    required this.isPregnant,
    required this.height,
    required this.weight,
    required this.isFirstChild,
    required this.knowledgeType,
    this.lastMenstrualDate,
    this.gestationalWeeks,
    this.gestationalDays,
    this.conceptionDate,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      "isDoctor": isDoctor,
      "role": role,
      "isPregnant": isPregnant,
      "height": height,
      "weight": weight,
      "isFirstChild": isFirstChild,
      "knowledgeType": knowledgeType,
      "lastMenstrualDate": lastMenstrualDate,
      "gestationalWeeks": gestationalWeeks,
      "gestationalDays": gestationalDays,
      "conceptionDate": conceptionDate,
      "dateOfBirth": dateOfBirth,
    };
  }
}