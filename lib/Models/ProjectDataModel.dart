class ProjectDataModel {
  late String title, description, projectType;
  late String noOfProposal;
  late String price;
  late String skills;
  late String slug;
  late String publishedAt;
  ProjectDataModel({
    required this.title,
    required this.description,
    required this.projectType,
    required this.noOfProposal,
    required this.price,
    required this.slug,
    required this.skills,
    required this.publishedAt
  });
}