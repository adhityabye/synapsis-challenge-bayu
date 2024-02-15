import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:synapsis_challenge/src/question/presentation/view/question_detail.dart';
import 'package:synapsis_challenge/src/survey/domain/entities/assessment.dart';

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


    //Unauthorized... keep getting 401
    final uri = Uri.parse(
        'https://dev-api-lms.apps-madhani.com/v1/assessments?page=1&limit=1');

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
      print('Error making HTTP request: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to fetch data.'),
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
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionDetail()),
                      ),
                      child: Container(
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Image.asset(
                                    'assets/survey.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ],
                            ),
                            const Column(
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

                                //The API keep returning unauthorized :(
                                Text("Created At: 23 Jan 2021"),
                                Text("Last Updated: 01-01-2021")
                              ],
                            ),
                          ],
                        ),
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
