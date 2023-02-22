import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/Screens/HomeScreen/Model/HomeModel.dart';
import 'package:notes/Utils/DBHelper/DBHelper.dart';

class HomeController extends GetxController
{
  RxInt index = 0.obs;
  RxInt NotesIndex = 0.obs;
  RxInt insertupdate = 0.obs;
  RxString month = "".obs;
  RxString time = "".obs;
  RxString day = "".obs;
  RxList<HomeModel> NotesList = <HomeModel>[].obs;
  RxList<HomeModel> SearchNotesList = <HomeModel>[].obs;
  Rx<TextEditingController> txtTitle = TextEditingController().obs;
  Rx<TextEditingController> txtUserType = TextEditingController().obs;
  Rx<TextEditingController> txtupTitle = TextEditingController().obs;
  Rx<TextEditingController> txtupUserType = TextEditingController().obs;
  Rx<TextEditingController> txtSearch = TextEditingController().obs;




  void GetData() async
  {
    NotesList.value = await DBHelper.dbHelper.ReadData();
  }

  void GetSearchData(String search) async
  {
    SearchNotesList.value = await DBHelper.dbHelper.SearchData(search);
  }
  void GetMonth()
  {
    day.value = "${DateTime.now().day}";
    time.value = "${DateTime.now().hour}:${DateTime.now().minute<10?"0${DateTime.now().minute}":"${DateTime.now().minute}"} ${DateTime.now().hour<12?"AM":"PM"}";
    if(DateTime.now().month == 1)
      {
        month.value = "January";
      }
    else if(DateTime.now().month == 2)
      {
        month.value = "February";
      }
    else if(DateTime.now().month == 3)
    {
      month.value = "March";
    }
    else if(DateTime.now().month == 4)
    {
      month.value = "April";
    }
    else if(DateTime.now().month == 5)
    {
      month.value = "May";
    }
    else if(DateTime.now().month == 6)
    {
      month.value = "June";
    }else if(DateTime.now().month == 7)
    {
      month.value = "July";
    }
    else if(DateTime.now().month == 8)
    {
      month.value = "August";
    }
    else if(DateTime.now().month == 9)
    {
      month.value = "September";
    }
    else if(DateTime.now().month == 10)
    {
      month.value = "October";
    }
    else if(DateTime.now().month == 11)
    {
      month.value = "November";
    }
    else if(DateTime.now().month == 12)
    {
      month.value = "December";
    }

  }
}