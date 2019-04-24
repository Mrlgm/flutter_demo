import 'package:flutter/material.dart';
import 'array.dart';

class ListNews extends StatefulWidget {
  final List data;

  ListNews(this.data);

  @override
  _ListNewsState createState() => new _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  Widget renderItem(item, index) {
    return new Container(
      padding: new EdgeInsets.all(12.0),
      margin: new EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
// 圆角和阴影
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(const Radius.circular(2.0)),
        boxShadow: [
          new BoxShadow(
            offset: new Offset(0.0, 1.2),
            blurRadius: 1.0,
            color: const Color(0xaadddddd),
          ),
        ],
      ),
// 内容
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 顶端对齐
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: new EdgeInsets.only(right: 12.0),
              child: new Text(item['title']),
            ),
          ),
// 圆角的图片
          new Container(
            width: 72.0,
            height: 64.0,
            decoration: new BoxDecoration(
              color: Colors.black12,
              image: new DecorationImage(
                image: new NetworkImage(item['images'][0]),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Flex(
      direction: Axis.vertical,
      children: Array.map<Widget>(widget.data, (item, index) {
        return renderItem(item, index);
      }),
    );
  }
}
