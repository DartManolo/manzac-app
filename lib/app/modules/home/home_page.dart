import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/buttons/circular_buttons.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/containers/card_container.dart';
import '../../widgets/drawers/header_drawer.dart';
import '../../widgets/drawers/item_drawer.dart';
import '../../widgets/forms/sin_reportes_local_form.dart';
import '../../widgets/textforms/date_textform.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget with WidgetsBindingObserver {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(ColorList.ui[1]),
          appBar: AppBar(
            title: Text(''),
            backgroundColor: Color(ColorList.ui[1]),
            bottom: TabBar(
              onTap: c.cambiarOpcionMenu,
              dividerColor: Colors.transparent,
              labelColor: Color(ColorList.sys[0]),
              indicatorColor: Color(ColorList.sys[0]),
              unselectedLabelColor: Color(ColorList.theme[4]),
              tabs: [
                Tab(
                  text: 'Reportes',
                ),
                Tab(
                  text: 'Pendientes',
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                HeaderDrawer(
                  nombre: c.nombreMenu,
                  usuario: c.usuarioMenu,
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: c.menuOpciones.map((opcion) {
                      return ItemDrawer(
                        icon: opcion.icono!,
                        text: opcion.titulo,
                        accion: opcion.accion,
                      );
                    }).toList(),
                  ),
                Expanded(child: SizedBox()),
                Divider(),
                ItemDrawer(
                  icon: MaterialIcons.logout,
                  text: 'Cerrar sesión',
                  accion: c.cerrarSesion,
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  DateTextform(
                    height: 70,
                    controller: c.fechaBusqueda,
                    focusNode: c.fechaBusquedaFocus,
                    dateSelected: c.dateSelected,
                    text: 'Fecha consulta',
                    formato: 'dd/MM/yyyy',
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if(!c.cargandoReportes) {
                          return SizedBox();
                        } else {
                          return Center(
                            child: SpinKitThreeInOut(
                              color: Color(ColorList.sys[1]),
                            ).fadeIn(delay: 1.seconds,),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  if(c.reportesLocal!.isNotEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: 10,),
                        Expanded(
                          child: Column(
                            children: c.reportesLocal!.map((reporte) {
                              var fecha = "";
                              if(reporte.reporteEntrada != null) {
                                fecha = reporte.reporteEntrada!.fecha!;
                              } else if(reporte.reporteSalida != null) {
                                fecha = reporte.reporteSalida!.fecha!;
                              }
                              return CardContainer(
                                fondo: 0xFFC9CBCD,
                                padding: const EdgeInsets.all(15),
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Tipo reporte:  ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ColorList.sys[0]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  reporte.tipo!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(ColorList.sys[0]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text(
                                                  'Fecha creacion:  ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ColorList.sys[0]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  fecha,
                                                  minFontSize: 7,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(ColorList.sys[0]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                        child: Column(
                                          children: [
                                            CircularButton(
                                              color: ColorList.sys[0],
                                              colorIcono: ColorList.sys[3],
                                              icono: Octicons.file_symlink_file,
                                              onPressed: () => c.abrirReporte(reporte),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        SolidButton(
                          ltrbm: [0, 20, 10, 0],
                          fondoColor: ColorList.sys[1],
                          textoColor: ColorList.sys[3],
                          icono: MaterialIcons.upload_file,
                          texto: "Subir todos los pendientes",
                          onPressed: () {}, 
                          onLongPress: () {},
                        ),
                      ],
                    );
                  } else {
                    return SinReportesLocalForm(
                      onPressed: c.recargarReportesLocal,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}