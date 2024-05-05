import 'package:flutter/material.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customPageAppBar(context, 'Transfer'),]),
      ),
    );
  }
}