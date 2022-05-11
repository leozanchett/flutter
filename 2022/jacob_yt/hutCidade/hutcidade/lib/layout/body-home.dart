import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:hutcidade/controller/config-controller.dart';
import 'package:hutcidade/controller/onibus-controller.dart';
import 'package:intl/intl.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigController _cfgController = Get.find<ConfigController>();
    return GetX<OnibusController>(
      init: OnibusController(),
      initState: (_) {},
      builder: (_busController) {
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
                onDateChange: (date) {
                  _cfgController.setDataRequest(date);
                  _busController.makeFirebaseRequest(_cfgController.config.value);
                },
                locale: 'pt_BR',
              )),
              SizedBox(
                height: Get.height / 1.5,
                child: ListWheelScrollView(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  perspective: RenderListWheelViewport.defaultPerspective,
                  children: <Widget>[
                    for (int i = 0; i < _busController.listaOnibus.length; i++)
                      SizedBox(
                        width: Get.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const ListTile(
                            title: Text('13:30'),
                            leading: Icon(
                              Icons.access_time_sharp,
                              color: Colors.black87,
                            ),
                            trailing: Text('Estrelatur'),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
