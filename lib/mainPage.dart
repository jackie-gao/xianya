import 'package:flutter/material.dart';
import 'package:xianya/routes/xianya_centerOfPersonal.dart';
import 'package:xianya/routes/xianya_homePage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        //主题
        theme: new ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false, //去掉右上角DEBUG标签
        home: MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['今日运势', '历史今天'];

  /*
   * 存放两个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff96D264)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [
        getTabImage('res/images/home.png'),
        getTabImage('res/images/home_selected.png')
      ],
      [
        getTabImage('res/images/mine.png'),
        getTabImage('res/images/mine_selected.png')
      ],
    ];
    /*
     * 两个子界面
     */
    _pageList = [
      new HomePage(),
      new centerOfPersonal(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //初始化数据
    initData();
    return Scaffold(
        body: _pageList[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中主页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }
}
