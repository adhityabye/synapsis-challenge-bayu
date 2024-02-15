class Assessment {
  final String id;
  final String name;
  final DateTime assessmentDate;
  final String description;
  final String type;
  final int roleAssessor;
  final String roleAssessorName;
  final int roleParticipant;
  final String roleParticipantName;
  final String departementId;
  final String departementName;
  final String siteLocationId;
  final String siteLocationName;
  final String image;
  final List<dynamic> participants;
  final dynamic assessors;
  final String createdAt;
  final String updatedAt;
  final dynamic downloadedAt;
  final bool hasResponses;

  Assessment({
    required this.id,
    required this.name,
    required this.assessmentDate,
    required this.description,
    required this.type,
    required this.roleAssessor,
    required this.roleAssessorName,
    required this.roleParticipant,
    required this.roleParticipantName,
    required this.departementId,
    required this.departementName,
    required this.siteLocationId,
    required this.siteLocationName,
    required this.image,
    required this.participants,
    required this.assessors,
    required this.createdAt,
    required this.updatedAt,
    required this.downloadedAt,
    required this.hasResponses,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'],
      name: json['name'],
      assessmentDate: DateTime.parse(json['assessment_date']),
      description: json['description'],
      type: json['type'],
      roleAssessor: json['role_assessor'],
      roleAssessorName: json['role_assessor_name'],
      roleParticipant: json['role_participant'],
      roleParticipantName: json['role_participant_name'],
      departementId: json['departement_id'],
      departementName: json['departement_name'],
      siteLocationId: json['site_location_id'],
      siteLocationName: json['site_location_name'],
      image: json['image'],
      participants: json['participants'],
      assessors: json['assessors'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      downloadedAt: json['downloaded_at'],
      hasResponses: json['has_responses'],
    );
  }
}
