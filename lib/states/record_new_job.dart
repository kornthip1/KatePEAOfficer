import 'package:flutter/material.dart';
import 'package:katepeaofficer/models/job_model.dart';

class RecordNewJob extends StatefulWidget {
  final JobModel jobModel;
  RecordNewJob({@required this.jobModel});
  @override
  _RecordNewJobState createState() => _RecordNewJobState();
}

class _RecordNewJobState extends State<RecordNewJob> {

  JobModel jobModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobModel = widget.jobModel;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(jobModel.menuMainName),),
    );
  }
}