class ExperienceModel {
  int? id;
  String? title, companyName, webSite, duration, description;

  ExperienceModel({
    this.id,
    this.title,
    this.companyName,
    this.webSite,
    this.duration,
    this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'],
      title: json['title'],
      companyName: json['companyName'],
      webSite: json['webSite'],
      duration: json['duration'],
      description: json['description'],
    );
  }
}