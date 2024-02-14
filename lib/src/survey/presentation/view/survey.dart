import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:synapsis_challenge/src/survey/presentation/utils/global.dart';

class SurveyQue extends StatefulWidget {
  const SurveyQue({super.key});

  @override
  State<SurveyQue> createState() => _SurveyQueState();
}

class _SurveyQueState extends State<SurveyQue> {
  List<Assessment> assessments = [];

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    // Construct the URL using Uri.parse()
    final uri = Uri.parse('${GVariable.api_dev}/assessments?page=1&limit=10');

    try {
      final response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);

        final list = json['data'] as List;

        setState(() {
          assessments = list.map((e) => Assessment.fromJson(e)).toList();
        });
      }
    } catch (e) {
      print('Error while making HTTP request: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to fetch data. Please try again later.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future<void> syncData() async {
    fetchData(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Halaman Survey",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Image.asset(
                                  'assets/survey.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Survey A",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text("Created At: 23 Jan 2021"),
                                Text("Last Updated: 01-01-2021")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

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
