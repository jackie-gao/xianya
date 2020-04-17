import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<HomePage> {
  var mapss = Map();
  var contents = '快来测一测你的运势吧！';
  String dropdownValue1 = '双鱼座';
  String dropdownValue2 = 'today';
  String jhsj_key = '9387871d574a3a4143c36ce52b66ae64'; //聚合数据的key

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: Listviews(context),
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

  Widget Listviews(BuildContext context) {
    return ListView(
      children: <Widget>[
        header(context),
        header2(context),
        header3(context),
        header4(context),
        header5(context),
      ],
    );
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }

  Widget header2(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue1,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue1 = newValue;
            loadData();
          });
        },
        items: <String>[
          '白羊座',
          '金牛座',
          '双子座',
          '巨蟹座',
          '狮子座',
          '处女座',
          '天枰座',
          '天蝎座',
          '射手座',
          '魔蝎座',
          '水瓶座',
          '双鱼座',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget header3(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue2,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue2 = newValue;
            loadData();
          });
        },
        items: <String>['today', 'tomorrow', 'week', 'month', 'year']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget header4(BuildContext context) {
    if (mapss["name"] != null) {
      if (dropdownValue2 == "today" || dropdownValue2 == "tomorrow") {
        contents = "星座名称:" +
            mapss["name"].toString() +
            "\n\n"
                "日期:" +
            mapss["datetime"].toString() +
            "\n\n"
                "幸运色:" +
            mapss["color"].toString() +
            "\n\n"
                "健康指数:" +
            mapss["health"].toString() +
            "\n\n"
                "爱情指数:" +
            mapss["love"].toString() +
            "\n\n"
                "财运指数:" +
            mapss["money"].toString() +
            "\n\n"
                "幸运数字:" +
            mapss["number"].toString() +
            "\n\n"
                "速配星座:" +
            mapss["QFriend"].toString() +
            "\n\n"
                "工作指数:" +
            mapss["work"].toString() +
            "\n\n"
                "综合指数:" +
            mapss["all"].toString() +
            "\n\n"
                "今日概述:" +
            mapss["summary"].toString() +
            "\n\n";
      } else if (dropdownValue2 == "week") {
        contents = "星座名称:" +
            mapss["name"].toString() +
            "\n\n"
                "日期:" +
            mapss["date"].toString() +
            "\n\n"
                "今年第" +
            mapss["weekth"].toString() + "周"
            "\n\n"
                "爱情指数:" +
            mapss["love"].toString() +
            "\n\n"
                "财运指数:" +
            mapss["money"].toString() +
            "\n\n"
                "工作指数:" +
            mapss["work"].toString() +
            "\n\n";
      } else if (dropdownValue2 == "month") {
        contents = "星座名称:" +
            mapss["name"].toString() +
            "\n\n"
                "日期:" +
            mapss["date"].toString() +
            "\n\n"
                "健康运势:" +
            mapss["health"].toString() +
            "\n\n"
                "爱情运势:" +
            mapss["love"].toString() +
            "\n\n"
                "财运运势:" +
            mapss["money"].toString() +
            "\n\n"
                "工作运势:" +
            mapss["work"].toString() +
            "\n\n"
                "综合运势:" +
            mapss["all"].toString() +
            "\n\n";

      } else if (dropdownValue2 == "year") {

        contents = "星座名称:" +
            mapss["name"].toString() +
            "\n\n"
                "日期:" +
            mapss["date"].toString() +
            "\n\n"
                "幸运石头:" +
            mapss["luckeyStone"].toString() +
            "\n"
                "年度密码:" +
            mapss["mima"]["info"].toString() +
            "\n\n"
                "年度密码详解:" +
            mapss["mima"]["text"].toString() +
            "\n\n"
                "健康上:" +
            mapss["health"].toString() +
            "\n\n"
                "事业运:" +
            mapss["career"].toString() +
            "\n\n"
                "感情运:" +
            mapss["love"].toString() +
            "\n\n"
                "财运:" +
            mapss["finance"].toString() +
            "\n\n";

      } else {}
    } else {}

    return new Container(
      child: Text(
        contents,
        style: TextStyle(fontFamily: 'RobotoMono'),
      ),
    );
  }

  Widget header5(BuildContext context) {
    return new MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: new Text('点我'),
      onPressed: () {
        loadData();
      },
    );
  }

  loadData() async {
    String dataURL =
        "http://web.juhe.cn:8080/constellation/getAll?consName=${dropdownValue1}&type=${dropdownValue2}&key=${jhsj_key}";
    http.Response response = await http.get(dataURL);
    setState(() {
//    print("返回来啥：${json.decode(response.body)}");
      mapss = json.decode(response.body);
      print("返回：${mapss}");
    });
  }
}

///*今日或明日运势格式*/
//{
//"name": "狮子座",/*星座名称*/
//"datetime": "2014年06月27日",/*日期*/
//"date": 20140627,
//"all": "89%", /*综合指数*/
//"color": "古铜色", /*幸运色*/
//"health": "95%", /*健康指数*/
//"love": "80%",/*爱情指数*/
//"money": "84%",/*财运指数*/
//"number": 8,/*幸运数字*/
//"QFriend": "处女座",/*速配星座*/
//"summary": "有些思考的小漩涡，可能让你忽然的放空，生活中许多的细节让你感触良多，五味杂陈，
//常常有时候就慢动作定格，想法在某处冻结停留，陷入一阵自我对话的沉思之中，这个时候你不喜欢被打扰
//或询问，也不想让某些想法曝光，个性变得有些隐晦。",/*今日概述*/
//"work": "80%"/*工作指数*/
//"error_code": 0/*返回码*/
//}
//
//
///*本周运势格式*/
//{
//"name": "白羊座",
//"date": "2014年06月29日-2014年07月05日",
//"weekth": 27,
//"health": "健康：内心有焦躁，但身体拒绝过劳求舒适。容易有胃部不适。",
//"job": "求职：虽有新想法，但心态求稳当，容易低就。但较有可能从家人处获得的机会。",
//"love": "恋情：之前积累的想法和感受，本周选择说出来。沟通机会增多，亦有可能以争吵的方式出现。
//单身的，在聚会闲谈中可望获得更多缘分。",
//"money": "财运：虽有自己的理财想法，但总体受控于家人或家族的财务计划。受木星支撑，有机会得到
//家人的支援。但是土逆仍然显示你有债务加大的风险。置业房产出现时机，较大可能是家人出首期，你来月
//供。",
//"work": "工作：水逆在本周结束，之前耽误、错过的出现弥补机会。职场进入休整状态，有调部门或岗位
//的可能。",
//"resultcode": "200",
//"error_code": 0
//}
///*本年运势*/
//{
//"name":"白羊座",
//"date":"2016年",
//"year":2016,
//"resultcode":"200",
//"error_code":0,
//"mima":{/*年度密码*/
//"info":"变身完成的调整之年",/*概述*/
//"text":[/*说明*/
//"2016年将会是白羊座暂时放缓节奏，开始调整个人生活作息以及细分工作内容的一年。土星
//来到射手座对白羊座而言实际属于利好，让你们可以更加客观地看待当下面临的问题，并根据现状调整预
//期，为今后相当长一段时间（可能影响未来10年）做好最合适的计划和目...
//]
//},
//"career":[/*事业运*/
//"土星的移位意味着你们的工作重心会有所转移，从前的忙乱筹备已经落实到目标更加明确的层
//面。对创业者而言，前景目标相对比较明确，只要按预期计划踏踏实实执行下去就可以。你也可以将更多精
//力投入于长远规划以及专业研究、发行出版、异域涉外等方面去，都会获得行业认可的业绩，在相关行业崭
//露头角，奠定行业地位。自由职业者则有机会产出一些惊为天人的作品，叫.....
//],
//"love":[/*感情运*/
//"上半年，木星仍然停留在白羊座的恋爱宫，感情将继续精彩纷呈，尤其容易与旧人擦出火花，展
//开异地恋情，同学聚会及老友聚会都是桃花高爆区域，也要小心计划外怀孕。单身人士不乏追求对象，尤其
//在3月间可能出现让自己一见钟情的人，但极有可能只是昙花一现的惊心动魄，更像是一场因果牵引的缘分重
//聚。4月上旬到中旬则是另一个值得注意的时段，有对象的个人在这两段时间都容....
//],
//"finance":[/*财运*/
//"上半年木星落在投资宫，会给你们带来很好的偏财运。但年后开始的一个月，.......
//],
//}
//
///*本月运势*/
//{
//"date":"2016年12月",/*日期*/
//"name":"白羊座",/*名称*/
//"all":"本月运势有两个重要的节点，一个是在上旬，水星进入事业宫，更加关注事业发展，目标性加
//强；而金星随之离开事业宫，原先的经验不能再为你赢得加分，反而是人脉上。。。",/*综合运势*/
//"happyMagic":"",
//"health":"上旬和中旬，运动能量高，适合开展锻炼计划，尤其是练习耐力的运动。下旬，水逆开启，出行要小心意外了。/*健康运势*/
//"love":"现实的比较太累，你更喜欢朋友式的轻松相处，如果和爱人之间做不到，你会更眷恋友人的陪
//伴。因而本月“友情已达，恋人未满”的状况，会有更大的发生几率。/*爱情运势*/
//"money":"人际生财，多往人气旺的地方是有利打听到财富资讯，广开财路的。虽然人际开销也会增多
//，但可以当做是投资。/*财运运势*/
//"month":12,/*月份*/
//"work":"本月的目标性和计划性都很强，两个阶段的区别在于行动力。上旬和中旬，行动力分散，下
//旬，行动力足够，但受水逆影响，意外多。/*工作运势*/
//"resultcode":"200",
//"error_code":0
//}
