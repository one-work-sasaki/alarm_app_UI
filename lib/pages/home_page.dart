import 'package:alarm_a/alarm.dart';
import 'package:alarm_a/pages/add_edit_alarm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Alarm> alarmList = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: Colors.black,
            largeTitle: Text('アラーム',style: TextStyle(color: Colors.white),),
            trailing: GestureDetector(
              child: Icon(Icons.add,color: Colors.orange,),
              onTap: ()async{
                await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditAlarmPage(alarmList)));
                setState((){
                  alarmList.sort((a,b) => a.alarmTime.compareTo(b.alarmTime));
                });
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index){
                Alarm alarm = alarmList[index];
                return Column(
                  children: [
                    if(index == 0) Divider(color: Colors.grey,height: 1,),
                    Slidable(
                      child: ListTile(
                        title: Text(
                          DateFormat('H:mm').format(alarm.alarmTime),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        trailing: CupertinoSwitch(
                          value: alarm.isActive,
                          onChanged: (newValue) {
                            setState(() {
                              alarm.isActive = newValue;
                            });
                          },
                        ),
                        onTap: ()async{
                          await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditAlarmPage(alarmList,index: index,)));
                          setState((){
                            alarmList.sort((a,b) => a.alarmTime.compareTo(b.alarmTime));
                          });
                        },
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_){
                              alarmList.removeAt(index);
                              setState((){});
                            },
                            icon: Icons.delete,
                            label: '削除',
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                  ],
                );
              },
              childCount: alarmList.length,
            ),
          ),
        ],
      ),
    );
  }
}
