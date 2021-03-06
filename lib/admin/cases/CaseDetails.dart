import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/filters/UpdateFilter.dart';
import 'package:purifiercompanyapp/admin/technicien/UpdateTechnicien.dart';

import 'UpdateCase.dart';
class CaseDetails extends StatefulWidget {

  String case_id;
  String casetype ;
  String scheduledate ;
  String time;
  String action;
  String suggest;
  String comment;
  bool iscompleted;
  String handledby;
  List filters;
  List machines;
  String tocken;
  String userId;

  CaseDetails({this.machines,this.handledby,this.time,this.scheduledate,this.tocken,this.userId,this.suggest,this.iscompleted,this.filters,
  this.action,this.casetype,this.comment,this.case_id});
  @override
  _CaseDetailsState createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  Map<String, String> typeOfMachine = {'WPU': 'Water Purifier', 'U': 'Under Sink', 'F': 'Filter'};
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);
  Widget managementOfFilters(){
    if (widget.filters.isEmpty){
      return SizedBox();
    }else{
      return  Row(
        children: <Widget>[
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:widget.filters.length,
              itemBuilder: (BuildContext ctxt, int index) =>
                   Text(widget.filters[index]["filtercode"]),
            ),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                    SizedBox(height: 50,),
                                    Icon(FontAwesomeIcons.screwdriver, size: 130, color: color,),
                                    SizedBox(height: 50),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[FlatButton.icon(
                                        icon: Icon(FontAwesomeIcons.idCard, color: color,
                                        ),
                                        label: Flexible(
                                          child: Text(widget.casetype,
                                            style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[FlatButton.icon(
                                        icon: Icon(FontAwesomeIcons.calendarAlt, color: color,
                                        ),
                                        label: Flexible(
                                          child: Text(widget.scheduledate,
                                            style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      ],
                                    ),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[FlatButton.icon(
                                                              icon: Icon(FontAwesomeIcons.userCog, color: color,
                                                              ),
                                                              label: Flexible(
                                                                child: Text(widget.handledby,
                                                                style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                                              ),
                                                              ),
                                          ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[FlatButton.icon(
                                        icon: Icon(
                                          FontAwesomeIcons.mapMarkerAlt, color: color,
                                        ),
                                        label: Flexible(
                                          child: Text(widget.machines[0]["installaddress1"],
                                            style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      ],
                                    ),
                                    SizedBox(height: 11,),
                            Column(
                              children: <Widget>[
                                ListView.builder(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        shrinkWrap: true,
                                        itemCount:widget.machines?.length??0,
                                        itemBuilder: (BuildContext ctxt, int index) =>  Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                          Icon(FontAwesomeIcons.robot,color: Colors.blue,),
                                                          SizedBox(width: 20,),
                                                          Text(widget.machines[index]["machineid"],softWrap: true,style: style,overflow: TextOverflow.ellipsis),
                                                          SizedBox(width: 20,),
                                                          Text(typeOfMachine[widget.machines[index]["producttype"]] ,softWrap: true,style: style,overflow: TextOverflow.ellipsis),
                                                          SizedBox(height: 39,),
                                                          ],
                                                          ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  shrinkWrap: true,
                                  itemCount:widget.filters?.length??0,
                                  itemBuilder: (BuildContext ctxt, int index) =>  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.filter,color: Colors.blue,),
                                      SizedBox(width: 20,),
                                      Text(widget.filters[index]["filtercode"]??"",softWrap: true,style: style,overflow: TextOverflow.ellipsis),
                                      SizedBox(width: 20,),
                                      Text(widget.filters[index]["filtername"]??"",softWrap: true,style: style,overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 39,),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.checkDouble, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.iscompleted.toString(),
                                        style: style,softWrap: true,overflow: TextOverflow.ellipsis,),
                                    ),
                                  ),
                                  ],
                                ),
                              ],
                            ),
                              // managementOfFilters(),
                              Center(
                                  child:ProgressButton(
                                    borderRadius: 20,
                                    color: color,
                                    defaultWidget: const Text('Update',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),),
//  progressWidget: const CircularProgressIndicator(),
                                    progressWidget:SpinKitRotatingCircle   (
                                      color: Colors.red,
                                      size: 50.0,
                                    ) ,
                                    width: 120,
                                    height: 50,
                                    onPressed: () async {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              UpdateCase(tocken: widget.tocken,
                                                  case_id: widget.case_id,
                                          userId:widget.userId,scheduledate: widget.scheduledate,
                                              action: widget.action,comment: widget.comment,
                                              iscompleted: widget.iscompleted,
                                              suggest: widget.suggest,time: widget.time,))
                                      );
// After [onPressed], it will trigger animation running backwards, from end to beginning
                                      return () {
// Optional returns is returning a function that can be called
// after the animation is stopped at the beginning.
// A best practice would be to do time-consuming task in [onPressed],
// and do page navigation in the returned function.
// So that user won't missed out the reverse animation.
                                      };
                                    },
                                  )


                              ),


                            ],
                            )),
        ),
      ),
    );
  }
}
