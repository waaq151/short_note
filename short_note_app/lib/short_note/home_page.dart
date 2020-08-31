import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_note_app/short_note/detail_page.dart';

import 'data.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title="11";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static List<Data> _data =[Data()];
  static List<Data> _oldData =[Data()];
  TextStyle _textStyleLarge = TextStyle(fontSize: 24,color: Colors.black);
  TextStyle _textStyleSmall = TextStyle(fontSize: 18,color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 10), //内边距
        alignment: Alignment.center, //内容位置
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/sun.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context,index){
            return Dismissible(
              // Key
              key: Key('key${_data[index].id}'),
              // Child
              child: _getDataBar(index),
              onDismissed: (direction){
                Scaffold.of(this.context).hideCurrentSnackBar();
                Scaffold.of(this.context).showSnackBar(
                    SnackBar(
//                      padding:EdgeInsets.fromLTRB(120, 0, 0, 0),
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
                        duration: Duration(milliseconds: 500),
                        content: Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text('已删除：${_data[index].title}',style:TextStyle(fontSize: 18,color: Colors.white70),),
                        )
                    )
                );
                // 删除后刷新列表，以达到真正的删除
                setState(() {
                  _delNote(index);
                });

              },
              background: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerLeft,
                color: Color.fromRGBO(240, 190, 190, 0.3),
                child: Icon(Icons.delete, color: Colors.deepOrangeAccent,size: 30,),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerRight,
                color: Color.fromRGBO(240, 190, 190, 0.3),
                child: Icon(Icons.delete, color: Colors.deepOrangeAccent,size: 30),
              ),
            );
//              _getTimeBar(index);
          },
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "添加",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push( // 跳转页面
              MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(Data());
                  }
              )
          ).then((value) {
            if (value == null) return;
            setState(() {
              _addNote(value);
            });
          }
          );
        },
        foregroundColor: Colors.white70,
        backgroundColor: Color.fromRGBO(0, 194 , 219, 0.5),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getDataBar(int index){
    return Container(
      height: 90.0,
      child: Stack(
        alignment: Alignment.center, // 堆叠位置方式
        children: <Widget>[
          Align( // 调整方位
              alignment: Alignment.centerLeft,
              child: Builder(
                  builder: (BuildContext context) {
                    return ListTile(
//                      hoverColor: Colors.red,
//                      focusColor: Colors.amberAccent,
//                      selectedTileColor: Colors.blue,
//                      tileColor: Color.fromRGBO(255, 255, 255, 0.01),
//                       leading: Icon(Icons.alarm_on, color:  Colors.cyan),
                      title: Text("${_data[index].title}",
                        style: _textStyleLarge,),
                      subtitle: Text(
                        "${_data[index].data}", style: _textStyleSmall, overflow: TextOverflow.ellipsis, ),//文本过长时的显示方式)
                      onTap: () {
                        Navigator.of(context).push( // 跳转页面
                            MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(_data[index]);
                                }
                            )
                        ).then((value) {
                          (context as Element).markNeedsBuild();
                          if (value == null) return;
                          _updateNote(index,value);
                        }
                        );
                      },
                      onLongPress: () {
                        //长按删除
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
                                  title: Text(
                                      '删除${_data[index].title}?'),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () =>
                                            Navigator.of(context).pop()),
                                    FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () {
                                          setState(() {
                                            _delNote(index);
                                          });
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                      },
                    );
                  }
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Divider(),
          )

        ],

      ),
    );

  }

  void _delNote (int index) async{
    _oldData.add(_data[index]);
    _data.removeAt(index);

    // 保存到本地
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setStringList("AlarmIDList", );
    // prefs.setStringList(alarm.alarmID, alarm.transAll2Str());

  }

  void _addNote (Data data) async{
    _data.add(data);
  }
  void _updateNote(int index,Data data){
    _data[index]=data;
  }
}
