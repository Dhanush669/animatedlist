import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Animatedlist(),
    debugShowCheckedModeBanner: false,
  ));
}
class Animatedlist extends StatefulWidget {
  @override
  _AnimatedlistState createState() => _AnimatedlistState();
}

class _AnimatedlistState extends State<Animatedlist> {
  GlobalKey<AnimatedListState> _key=new GlobalKey<AnimatedListState>();

  List<Modellist> listitem=[Modellist("Title 1","https://cdn.vox-cdn.com/thumbor/"
      "3SDag4_szhZrsfE86H7OGXcesxs=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/"
      "file/19395168/vpavic_191118_3800_0122.jpg"),
    Modellist("Title 2","https://cdn.mos.cms.futurecdn.net/gPvyaz76tASn87RCGuSdDc.jpg"),
    Modellist("Title 3","https://cdn57.androidauthority.net/wp-content/uploads/2017/11/pubg-mobile.png"),
    Modellist("Title 4","https://i.gadgets360cdn.com/large/cod_mobile_main_1570103396815.jpg"),
    ];

  Widget builditem(Modellist ml,int index,Animation<dynamic> animation){
    return ScaleTransition(
        scale: animation,
        child: Card(
          color: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(ml.title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
            subtitle: Text("Description of the title......",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70
            ),),
            leading: CircleAvatar(
              radius: 28.0,
              backgroundImage: NetworkImage(ml.url),
            ),
            onTap: ()=> removeItem(index),
          ),
        ),
    ),
    );
  }

  void removeItem(int index){
    final item=listitem.removeAt(index);
    _key.currentState.removeItem(index, (context, animation) => builditem(item, index, animation));
  }

  void insertItem(int index){
    String title="Title "+(listitem.length+1).toString();
    Modellist ml=new Modellist(title, "https://cdn57.androidauthority.net/wp-content/uploads/2017/11/pubg-mobile.png");
    listitem.insert(index, ml);
    _key.currentState.insertItem(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedList"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  insertItem(listitem.length);
                },
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Container(
        color: Colors.black26,
        child: AnimatedList(
          key: _key,
          initialItemCount: listitem.length,
          itemBuilder: (BuildContext context, int index, Animation<double> animation) {
            return builditem(listitem[index], index, animation);
          },
        ),
      ),
    );
  }
}

class Modellist{
  final String title,url;

  Modellist(this.title, this.url);

}