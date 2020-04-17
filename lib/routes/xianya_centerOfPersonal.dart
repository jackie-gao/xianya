import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class centerOfPersonal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<centerOfPersonal> {
  var mapss = Map();
  var widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: LisViews(context),
    );
  }

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.keyboard),
    new Icon(Icons.print),
    new Icon(Icons.router),
    new Icon(Icons.pages),
    new Icon(Icons.zoom_out_map),
    new Icon(Icons.zoom_out),
    new Icon(Icons.youtube_searched_for),
    new Icon(Icons.wifi_tethering),
    new Icon(Icons.wifi_lock),
    new Icon(Icons.widgets),
    new Icon(Icons.weekend),
    new Icon(Icons.web),
    new Icon(Icons.accessible),
    new Icon(Icons.ac_unit),
  ];

  Widget LisViews(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < widgets.length; i++)
          buildListData(context, i, iconItems[i]),
        for (int i = 0; i < widgets.length; i++) header(context),
      ],
    );
  }

  Widget buildListData(BuildContext context, int i, Icon iconItem) {
    return new ListTile(
      isThreeLine: false,
      leading: iconItem,
      title: new Text(widgets[i]["year"] +
          "年" +
          widgets[i]["month"] +
          "月" +
          widgets[i]["day"] +
          "日 " +
          widgets[i]["title"]),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text(
                '内容详情',
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ),
              content: new Text(widgets[i]["content"]),
            );
          },
        );
      },
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: const Text(
        '闲雅',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }

  loadData() async {
    String dataURL =
        "https://api.jisuapi.com/todayhistory/query?appkey=d52273a85bbe39fd%20&month=1&day=7";
    http.Response response = await http.get(dataURL);
    setState(() {
//      widgets = json.decode(response.body);
      print("返回来啥：${json.decode(response.body)}");
      mapss = json.decode(response.body);
      widgets = mapss["result"];
      print("返回来啥：${widgets}");
    });
  }
}
