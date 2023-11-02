class ProjectDataModel {
  late String title, description, projectType;
  late int noOfProposal;
  late double price;
  late String skills;
  late String publishedAt;
  ProjectDataModel({
    required this.title,
    required this.description,
    required this.projectType,
    required this.noOfProposal,
    required this.price,
    required this.skills,
    required this.publishedAt
  });
}