import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/horario.dart';
import 'package:hutcidade/controller/config-controller.dart';
import 'package:hutcidade/controller/horarios-controller.dart';
import 'package:hutcidade/services/adMob.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigController _cfgController = Get.find<ConfigController>();
    final ADMobService _adMobService = Get.find<ADMobService>();
    return GetX<HorarioController>(
      init: HorarioController(),
      initState: (_) async {
        if (!_adMobService.bannerAdIsReady.value) {
          _adMobService.loadBannerAd();
        }
        await _cfgController.fetchConfig().whenComplete(() => {
              if (_.mounted)
                {
                  _.controller!.fetch_lista_horarios(_cfgController.config.value),
                }
            });
      },
      builder: (_horarioController) {
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
                  _horarioController.fetch_lista_horarios(_cfgController.config.value);
                  _adMobService.showInterstitialAd();
                },
                locale: 'pt_BR',
              )),
              _horarioController.loading.value
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
                          // Obx(
                          //   () => (!_adMobService.bannerAdIsReady.value)
                          //       ? SizedBox(
                          //           width: Get.width,
                          //           child: Card(
                          //             shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(20),
                          //             ),
                          //             child: SizedBox(
                          //               width: _adMobService.bannerAd.size.width.toDouble(),
                          //               height: _adMobService.bannerAd.size.height.toDouble(),
                          //               child: AdWidget(
                          //                 ad: _adMobService.bannerAd,
                          //               ),
                          //             ),
                          //           ),
                          //         )
                          //       : Container(
                          //           width: 0,
                          //           color: Colors.transparent,
                          //         ),
                          // ),
                          for (Horarios horario in _horarioController.listaHorarios)
                            SizedBox(
                              width: Get.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListTile(
                                  title: Text(horario.hora),
                                  leading: const Icon(
                                    Icons.access_time_sharp,
                                    color: Colors.black87,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(horario.rota, style: const TextStyle(fontSize: 16)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _cfgController.config.value.selectedRequest == SelectedRequest.bus
                                          ? const Icon(
                                              Icons.directions_outlined,
                                              color: Colors.black87,
                                            )
                                          : const Icon(
                                              Icons.delete_outlined,
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
