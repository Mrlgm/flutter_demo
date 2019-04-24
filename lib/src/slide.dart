import 'package:flutter/material.dart';
import 'dart:async';
import 'array.dart';

class Slide extends StatefulWidget {
  final List data;

  Slide(this.data);

  @override
  _SlideState createState() => new _SlideState();
}

// 轮播图组件
class _SlideState extends State<Slide> {
  int index = 0; // 当前位置
  PageController controller = new PageController();
  bool isRun = false;

  // 圆点
  Widget dot(bool action) {
    return new Container(
      height: 7.0,
      width: 7.0,
      margin: new EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
        color: action
            ? Color.fromRGBO(255, 255, 255, 0.82)
            : Color.fromRGBO(255, 255, 255, 0.36),
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
    );
  }

  // 轮播
  void run() async {
    print('启动轮播');
    this.isRun = true;
    while (this.isRun) {
      await Future.delayed(new Duration(seconds: 5));
      this.setState(() {
        this.index = this.index == widget.data.length - 1 ? 0 : this.index + 1;
        this.controller.animateToPage(
          this.index,
          duration: new Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.run();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 220.0,
      color: Colors.black12,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new PageView.custom(
            controller: this.controller,
            onPageChanged: (index) {
              this.setState(() {
                this.index = index;
              });
            },
            // 内容
            childrenDelegate: new SliverChildBuilderDelegate(
              (context, index) {
                var item = widget.data[index];
                return new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Image.network(
                      item['image'],
                      fit: BoxFit.cover,
                    ),
                    // 遮罩层
                    new Container(
                      color: Colors.black26,
                      alignment: Alignment.bottomCenter,
                      padding: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 24.0),
                      child: new Text(
                        item['title'],
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: widget.data.length,
            ),
          ),
          new Container(
            height: 25.0,
            alignment: Alignment.center,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Array.map<Widget>(widget.data, (item, index) {
                return dot(index == this.index);
              }),
            ),
          )
        ],
      ),
    );
  }
}
