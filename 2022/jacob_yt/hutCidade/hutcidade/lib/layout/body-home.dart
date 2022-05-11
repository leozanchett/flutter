import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.95),
      child: Column(
        children: [
          SizedBox(
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              inactiveDates: [DateTime.now().add(Duration(days: 3)), DateTime.now().add(Duration(days: 4)), DateTime.now().add(Duration(days: 7))],
              onDateChange: (date) {
                print(date);
              },
              locale: 'pt_BR',
            ),
          ),
          SizedBox(
            height: Get.height / 1.5,
            child: ListWheelScrollView(
              itemExtent: 60,
              diameterRatio: 1.5,
              perspective: RenderListWheelViewport.defaultPerspective,
              children: <Widget>[
                for (int i = 0; i < 44; i++)
                  SizedBox(
                    width: Get.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const ListTile(
                        title: Text('Estrelatur'),
                        leading: Text('Horário'),
                        trailing: Text('Data'),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
