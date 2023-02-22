class HomeModel
{
  String? title,description,time,month,day;
  int? id;

  HomeModel({this.title, this.description, this.time, this.month, this.day, this.id});

  HomeModel fromMap(Map map)
  {
    HomeModel homeModel = HomeModel(
        title: map['title'],
        description: map['usertext'],
        month: map['month'],
        day: map['date'],
        time: map['time'],
        id: map['id'],
    );

    return homeModel;
  }
}