import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notes/Screens/HomeScreen/Model/HomeModel.dart';
import 'package:notes/Utils/DBHelper/DBHelper.dart';
import 'package:sizer/sizer.dart';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({Key? key}) : super(key: key);

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    homeController.GetMonth();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
          ),
          elevation: 0,
          actions: [
            Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                (homeController.insertupdate.value == 0 ? (homeController.txtTitle.value.text.isNotEmpty || homeController.txtUserType.value.text.isNotEmpty) : (homeController.txtupTitle.value.text.isNotEmpty || homeController.txtupUserType.value.text.isNotEmpty))
                    ? IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.ios_share_rounded,color: Colors.black,),
                )
                    :Text(""),
                SizedBox(width: Get.width/60,),
                (homeController.insertupdate.value == 0 ? (homeController.txtTitle.value.text.isNotEmpty || homeController.txtUserType.value.text.isNotEmpty) : (homeController.txtupTitle.value.text.isNotEmpty || homeController.txtupUserType.value.text.isNotEmpty))
                    ? IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.person_outline,color: Colors.black,),
                )
                    :Text(""),
                SizedBox(width: Get.width/60,),
                (homeController.insertupdate.value == 0 ? (homeController.txtTitle.value.text.isNotEmpty || homeController.txtUserType.value.text.isNotEmpty) : (homeController.txtupTitle.value.text.isNotEmpty || homeController.txtupUserType.value.text.isNotEmpty))
                    ? IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_vert,color: Colors.black,),
                )
                    :Text(""),
                SizedBox(width: Get.width/60,),
                (homeController.insertupdate.value == 0 ? (homeController.txtTitle.value.text.isNotEmpty || homeController.txtUserType.value.text.isNotEmpty) : (homeController.txtupTitle.value.text.isNotEmpty || homeController.txtupUserType.value.text.isNotEmpty))
                    ? IconButton(
                  onPressed: (){
                    HomeModel homeModel = HomeModel(
                        title: homeController.insertupdate.value == 0 ? homeController.txtTitle.value.text : homeController.txtupTitle.value.text,
                        description: homeController.insertupdate.value == 0 ? homeController.txtUserType.value.text : homeController.txtupUserType.value.text,
                        day: homeController.day.value,
                        month: homeController.month.value,
                        time: homeController.time.value,
                    );
                    homeController.insertupdate.value == 0 ? DBHelper.dbHelper.InsertData(homeModel):DBHelper.dbHelper.UpdateData(homeModel: homeModel, id: homeController.NotesList[homeController.NotesIndex.value].id!);
                    homeController.GetData();
                    Get.back();
                  },
                  icon: Icon(Icons.check,color: Colors.black,),
                )
                    :Text(""),
                SizedBox(width: Get.width/30,),
              ],
            ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: Get.width/21),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: Get.height/18,
                  color: Colors.grey.shade100,
                  alignment: Alignment.center,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      homeController.insertupdate.value == 0
                          ? homeController.txtTitle.value = TextEditingController(text: "$value")
                          : homeController.txtupTitle.value = TextEditingController(text: "$value");
                    },
                    controller: homeController.insertupdate.value==0?homeController.txtTitle.value:homeController.txtupTitle.value,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp
                    ),
                     cursorColor: Colors.amber,
                     cursorHeight: 33,
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20.sp
                      ),
                      border: InputBorder.none
                    ),
                  ),
                ),
                Container(
                  height: Get.height/30,
                  color: Colors.grey.shade100,
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      "${homeController.day}  ${homeController.month}  ${homeController.time}   |    ${homeController.txtTitle.value.text.length + homeController.txtUserType.value.text.length}  characters",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 9.sp
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height/1.5,
                   //color: Colors.red,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    textInputAction: TextInputAction.newline,
                    maxLines: 15,
                    controller: homeController.insertupdate.value==0?homeController.txtUserType.value:homeController.txtupUserType.value,
                    onChanged: (value) {
                      homeController.insertupdate.value == 0
                          ? homeController.txtUserType.value = TextEditingController(text: "$value")
                          : homeController.txtupUserType.value = TextEditingController(text: "$value");
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp
                    ),
                    cursorColor: Colors.amber,
                    cursorHeight: 23,
                    decoration: InputDecoration(
                        hintText: "Start typing",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15.sp
                        ),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
