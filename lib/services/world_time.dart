import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for UI
  late String time; //time of that location
  late String flag; //url to an asset flag icons
  late String url; // this is the location
  late bool isDaytime; // true or false of dy time or not



  WorldTime({required this.location, required this.flag, required this.url});



  Future<void> getTime() async {

    try {
      // Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
      // Map data = jsonDecode(response.body);
      // print(data);
      // print(data['title']);


      //Make request.
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      //Get property.
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //Create a DateTime object.
      DateTime now = DateTime.parse(datetime);
      now =  now.add(Duration(hours: int.parse(offset)));

      //Set time property.
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e) {
      print('caught error $e');
      time = 'could not get time data';
    }





  }

}

