import 'package:flutter/material.dart';

class CandidateTrackingScreen extends StatelessWidget {
  const CandidateTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeatureScaffold(title: 'Candidate Tracking');
  }
}

class _FeatureScaffold extends StatelessWidget {
  const _FeatureScaffold({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
