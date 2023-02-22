import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notes/Screens/HomeScreen/Model/HomeModel.dart';
import 'package:notes/Utils/DBHelper/DBHelper.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    homeController.GetData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade100,
              pinned: true,
              title: Obx(
                    () => Container(
                      width: Get.width/3,
                      child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      IconButton(
                        onPressed: (){
                          homeController.index.value = 0;
                        },
                        icon: Icon(Icons.book_sharp,color:  homeController.index.value == 0 ? Colors.amber:Colors.grey,size: 21.sp,),
                      ),
                      SizedBox(width: Get.width/21,),
                      IconButton(
                        onPressed: (){
                          homeController.index.value = 1;
                        },
                        icon: Icon(Icons.check_box_outlined,
                          color:  homeController.index.value == 1 ? Colors.amber : Colors.grey,size: 21.sp,),
                      ),
                  ],
                ),
                    ),
              ),
              actions: [
                Padding(
                  padding:  EdgeInsets.only(right: Get.width/30),
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.settings_rounded,color: Colors.grey.shade700,size: 21.sp,),
                  ),
                ),
              ],
              centerTitle: true,
            ),
            SliverAppBar(
              snap: false,
              pinned: false,
              floating: true,
              backgroundColor: Colors.grey.shade100,
              title: Container(
                height: Get.height/18,
                width: Get.width/1.1,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.only(top: Get.height/500),
                child: TextField(
                  controller: homeController.txtSearch.value,
                  cursorColor: Colors.amber,
                  onChanged: (value) {
                    homeController.txtSearch.value = TextEditingController(text: value);
                    homeController.GetSearchData(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Search Notes Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => Container(
                  height: Get.height,
                  width: Get.width,
                  margin: EdgeInsets.only(left: Get.width/21,right: Get.width/21,top: Get.height/45),
                  child: homeController.txtSearch.value.text.isEmpty
                      ? GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: homeController.NotesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: Get.height/4.4,mainAxisSpacing: Get.width/48,crossAxisSpacing: Get.width/45),
                    itemBuilder: (context, index) {
                      return FocusedMenuHolder(
                          child: GestureDetector(
                            onTap: (){
                              homeController.insertupdate.value = 1;
                              homeController.NotesIndex.value = index;
                              homeController.txtupTitle.value = TextEditingController(text: homeController.NotesList[index].title);
                              homeController.txtupUserType.value = TextEditingController(text: homeController.NotesList[index].description);
                              Get.toNamed('NoteAdd');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width/30,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height/25,
                                      width: Get.width/6,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "${homeController.NotesList[index].title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height/7,
                                      width: Get.width,
                                      alignment: Alignment.topLeft,
                                      // color: Colors.red,
                                      padding: EdgeInsets.only(top: Get.height/90),
                                      child: Text(
                                        "${homeController.NotesList[index].description}",
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height/25,
                                      width: Get.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${homeController.NotesList[index].time}     ${homeController.NotesList[index].day} ${homeController.NotesList[index].month}",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onPressed: (){},
                          menuItems: [
                            FocusedMenuItem(
                                title: Text("Delete"),
                                trailingIcon: Icon(Icons.delete_outline,color: Colors.black,),
                                onPressed: (){
                                  DBHelper.dbHelper.DeleteData(id: homeController.NotesList[index].id!);
                                  homeController.GetData();
                                  Get.back();
                                }
                            )
                          ]
                      );
                    },
                  )
                      :GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: homeController.SearchNotesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: Get.height/4.4,mainAxisSpacing: Get.width/48,crossAxisSpacing: Get.width/45),
                    itemBuilder: (context, index) {
                      return FocusedMenuHolder(
                          child: GestureDetector(
                            onTap: (){
                              homeController.insertupdate.value = 1;
                              homeController.NotesIndex.value = index;
                              homeController.txtupTitle.value = TextEditingController(text: homeController.SearchNotesList[index].title);
                              homeController.txtupUserType.value = TextEditingController(text: homeController.SearchNotesList[index].description);
                              Get.toNamed('NoteAdd');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width/30,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height/25,
                                      width: Get.width/6,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "${homeController.SearchNotesList[index].title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height/7,
                                      width: Get.width,
                                      alignment: Alignment.topLeft,
                                      // color: Colors.red,
                                      padding: EdgeInsets.only(top: Get.height/90),
                                      child: Text(
                                        "${homeController.SearchNotesList[index].description}",
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height/25,
                                      width: Get.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${homeController.SearchNotesList[index].time}     ${homeController.SearchNotesList[index].day} ${homeController.SearchNotesList[index].month}",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onPressed: (){},
                          menuItems: [
                            FocusedMenuItem(
                                title: Text("Delete"),
                                trailingIcon: Icon(Icons.delete_outline,color: Colors.black,),
                                onPressed: (){
                                  DBHelper.dbHelper.DeleteData(id: homeController.SearchNotesList[index].id!);
                                  homeController.GetData();
                                  Get.back();
                                }
                            )
                          ]
                      );
                    },
                  ),
                )
              ),
            )
          ],
        ),
        floatingActionButton: Padding(
          padding:  EdgeInsets.only(right: Get.width/21,bottom: Get.height/35),
          child: FloatingActionButton(
            onPressed: () {
              homeController.txtTitle.value.clear();
              homeController.txtUserType.value.clear();
              homeController.insertupdate.value = 0;
              Get.toNamed('NoteAdd');
            },
            backgroundColor: Colors.amber,
            child: Icon(Icons.add,color: Colors.white,size: 26.sp),
          ),
        ),
      ),
    );
  }
}
/*
SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                            childCount: 15,
                            (context, index) => FocusedMenuHolder(
                                child: GestureDetector(
                                  onTap: (){
                                    homeController.insertupdate.value = 1;
                                    homeController.NotesIndex.value = index;
                                    homeController.txtupTitle.value = TextEditingController(text: homeController.NotesList[index].title);
                                    homeController.txtupUserType.value = TextEditingController(text: homeController.NotesList[index].description);
                                    Get.toNamed('NoteAdd');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Get.width/30,),
                                      // child: Column(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Container(
                                      //       height: Get.height/25,
                                      //       width: Get.width/6,
                                      //       alignment: Alignment.bottomLeft,
                                      //       child: Text(
                                      //         "${homeController.NotesList[index].title}",
                                      //         style: TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 13.sp,
                                      //             overflow: TextOverflow.ellipsis,
                                      //             fontWeight: FontWeight.w400
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       height: Get.height/7,
                                      //       width: Get.width,
                                      //       alignment: Alignment.topLeft,
                                      //       // color: Colors.red,
                                      //       padding: EdgeInsets.only(top: Get.height/90),
                                      //       child: Text(
                                      //         "${homeController.NotesList[index].description}",
                                      //         maxLines: 4,
                                      //         style: TextStyle(
                                      //             color: Colors.grey.shade700,
                                      //             fontSize: 10.sp,
                                      //             overflow: TextOverflow.ellipsis,
                                      //             fontWeight: FontWeight.w400
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       height: Get.height/25,
                                      //       width: Get.width,
                                      //       alignment: Alignment.centerLeft,
                                      //       child: Text(
                                      //         "${homeController.NotesList[index].time}     ${homeController.NotesList[index].day} ${homeController.NotesList[index].month}",
                                      //         style: TextStyle(
                                      //             color: Colors.grey.shade700,
                                      //             fontSize: 10.sp,
                                      //             overflow: TextOverflow.ellipsis,
                                      //             fontWeight: FontWeight.w400
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ),
                                onPressed: (){},
                                menuItems: [
                                  FocusedMenuItem(
                                      title: Text("Delete"),
                                      trailingIcon: Icon(Icons.delete_outline,color: Colors.black,),
                                      onPressed: (){
                                        DBHelper.dbHelper.DeleteData(id: homeController.NotesList[index].id!);
                                        homeController.GetData();
                                        Get.back();
                                      }
                                  )
                                ]
                            )
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: Get.height/4.4,mainAxisSpacing: Get.width/48,crossAxisSpacing: Get.width/45)
                ),
* */
