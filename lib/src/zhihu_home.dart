import 'package:flutter/material.dart';
import './slide.dart';
import 'dart:convert';
import 'dart:io';

//const DATA =[{
//      "image": "https://pic1.zhimg.com/v2-f2822a917d63b5852bd2b1c42d75ae30.jpg",
//      "id": 9689108,
//      "title": "本周热门精选 · 热血漫画一样的比赛"
//    },
//    {
//      "image": "https://pic1.zhimg.com/v2-b7f18474894be76bdb2439b6d954a53c.jpg",
//      "id": 9689102,
//      "title": "普吉沉船幸存者：一家五口，只剩我一个；而我们当时什么都不知道"
//    },
//    {
//      "image": "https://pic3.zhimg.com/v2-60203aa6aae05cbb32bff35343fc86a6.jpg",
//      "id": 9689097,
//      "title": "英格兰等了 28 年，再度打入世界杯四强；这次他们离大力神杯还有多远？"
//    },
//    {
//      "image": "https://pic1.zhimg.com/v2-cdf1a3a325ba6418e6546307b1edfae0.jpg",
//      "id": 9689053,
//      "title": "人类祖先一拍脑门的决定，诞生了一夫一妻制的婚姻，还有白头偕老的爱情"
//    },
//    {
//      "image": "https://pic1.zhimg.com/v2-d978ef5f7f6f67e43b351faee54451c4.jpg",
//      "id": 9668185,
//      "title": "知道哪些医学上的小常识可以保护自己？"
//    }
//  ];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '知乎日报',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String title = '首页';
  List data = [];

  getData() async {
    var url = 'http://news-at.zhihu.com/api/4/stories/latest';
    var httpClient = new HttpClient();
    var data;
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      data = jsonDecode(json);
    }

    if (!mounted) return;

    setState(() {
      this.data = data['top_stories'];
      print(this.data);
    });
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        elevation: 2.0,
      ),
      appBar: new AppBar(
        title: new Text(
          this.title,
          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.notifications),
            tooltip: '消息',
            onPressed: () {},
          ),
          new PopupMenuButton(
            icon: new Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuItem>[
                  new PopupMenuItem(
                    value: 'A',
                    child: new Text('关于'),
                  ),
                ],
          ),
        ],
      ),
      body: new Slide(data),
    );
  }
}
