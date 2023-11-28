class EducationModel {
  int? id;
  String? title, duration, uni, description;

  EducationModel({
    this.id,
    this.title,
    this.duration,
    this.uni,
    this.description,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      uni: json['uni'],
      description: json['description'],
    );
  }
}