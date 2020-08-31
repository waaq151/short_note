import 'package:flutter/material.dart';
import 'data.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  Data _data;
  DetailPage(this._data,{Key key}) : super(key: key);

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  var _title = TextEditingController();
  var _data = TextEditingController();
  bool _isChanged = false;
  @override
  void initState(){
    super.initState();
    _title.text = widget._data.title;
    _data.text = widget._data.data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑"),
        leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //           backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
              //           title: Text(
              //               '取消修改${widget._data.title}?'),
              //           actions: <Widget>[
              //             FlatButton(
              //                 child: Text('Cancel'),
              //                 onPressed: (){
              //                     _isChanged =false;
              //                     Navigator.of(context).pop(null);
              //                     Navigator.of(this.context).pop(null);
              //                 },
              //             ),
              //             FlatButton(
              //                 child: Text('Yes'),
              //                 onPressed: (){
              //                   _isChanged = true;
              //                   _updateData();
              //                   Navigator.of(context).pop(null);
              //                   Navigator.of(this.context).pop(widget._data);
              //                 },
              //             )
              //           ]);
              //     });
              _updateData();
              Navigator.of(context).pop(widget._data);
            }
        ),
        backgroundColor: Color.fromRGBO(241 , 180, 180, 0.8),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check),
              onPressed: (){
                _updateData();
                Navigator.of(context).pop(widget._data);
              })
        ],

      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: "标题",
              ),
              style: TextStyle(fontSize: 24,fontStyle: FontStyle.italic),
              controller: _title,
              onChanged: (value){
                setState(() {
                  _isChanged = true;
                  _title.text = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "内容",
              ),
              maxLines: 100,
              style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),
              controller: _data,
              onChanged: (value){
                setState(() {
                  _isChanged = true;
                  _data.text = value;
                });
              },
            ),
          ],
        ),
      )
    );

  }

  _updateData(){
    widget._data.title = _title.text;
    widget._data.data = _data.text;
  }
}