class MyProjectDataModel {
  int bids, client_review_count, client_review_average;
  late String title, description, projectType, status, client_id;
  late String noOfProposal;
  late String budget;
  late String skills;
  late String slug;
  late String publishedAt;
  MyProjectDataModel({
    required this.bids,
    required this.client_review_count,
    required this.client_review_average,
    required this.title,
    required this.description,
    required this.projectType,
    required this.status,
    required this.client_id,
    required this.noOfProposal,
    required this.budget,
    required this.slug,
    required this.skills,
    required this.publishedAt
  });

  factory MyProjectDataModel.fromJson(Map<String, dynamic> json) {
    return MyProjectDataModel(
      bids: json['bids'] ?? 0,
      client_review_count: json['client_review_count'] ?? 0,
      client_review_average: json['client_review_average'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      projectType: json['projectType'] ?? '',
      status: json['status'] ?? '',
      client_id: json['client_id'] ?? '',
      noOfProposal: json['noOfProposal'] ?? '',
      budget: json['budget'] ?? '',
      slug: json['slug'] ?? '',
      skills: json["skills"] ?? '',
      publishedAt: json['created_at'] ?? '',
    );
  }
}