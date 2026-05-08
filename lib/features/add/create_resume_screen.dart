import 'package:flutter/material.dart';

class CreateResumeScreen extends StatelessWidget {
  const CreateResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeatureScaffold(title: 'Create Resume');
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
