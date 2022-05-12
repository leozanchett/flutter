import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:hutcidade/classes/onibus.dart';
import 'package:hutcidade/controller/config-controller.dart';
import 'package:hutcidade/controller/onibus-controller.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigController _cfgController = Get.find<ConfigController>();
    return GetX<OnibusController>(
      init: OnibusController(),
      initState: (_) async {
        print('Init state OnibusController');
        await _cfgController.fetchConfig().whenComplete(
              () => {
                if (_.mounted) {_.controller!.fetch_lista_horarios_bus(_cfgController.config.value)}
              },
            );
      },
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
                  _busController.fetch_lista_horarios_bus(_cfgController.config.value);
                },
                locale: 'pt_BR',
              )),
              _busController.loading.value
                  ? Expanded(
                      child: SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: Get.height / 1.5,
                      child: ListWheelScrollView(
                        itemExtent: 60,
                        diameterRatio: 1.5,
                        perspective: RenderListWheelViewport.defaultPerspective,
                        children: <Widget>[
                          for (Onibus bus in _busController.listaOnibus)
                            SizedBox(
                              width: Get.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListTile(
                                  title: Text(bus.hora),
                                  leading: const Icon(
                                    Icons.access_time_sharp,
                                    color: Colors.black87,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(bus.rota, style: const TextStyle(fontSize: 16)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.directions_outlined,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
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
