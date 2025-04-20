import 'package:animate_do/animate_do.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/combos/selection_combo.dart';
import '../../widgets/drawers/header_drawer.dart';
import '../../widgets/drawers/item_drawer.dart';
import '../../widgets/forms/ajustes_form.dart';
import '../../widgets/forms/pendientes_listado_form.dart';
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
            title: SizedBox.shrink(),
            backgroundColor: Color(ColorList.ui[1]),
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
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: c.menuIndex,
            onItemSelected: c.menuItemSelected,
            showElevation: false,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: Text('Consultar'),
                icon: Icon(Icons.manage_search_outlined),
                activeColor: Color(ColorList.sys[0]),
              ),
              BottomNavyBarItem(
                title: Text('Pendientes'),
                icon: Icon(Icons.pending_actions_rounded),
                activeColor: Color(ColorList.sys[0]),
              ),
              BottomNavyBarItem(
                title: Text('Ajustes'),
                icon: Icon(Icons.settings),
                activeColor: Color(ColorList.sys[0]),
              ),
            ],
          ),
          body: PageView(
            controller: c.menuController,
            onPageChanged: c.menuPageChanged,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DateTextform(
                          height: 70,
                          controller: c.fechaBusqueda,
                          focusNode: c.fechaBusquedaFocus,
                          dateSelected: c.dateSelected,
                          text: 'Fecha consulta',
                          formato: 'dd/MM/yyyy',
                        ),
                      ),
                      Expanded(
                        child: SelectionCombo(
                          titulo: "- Tipo reporte -",
                          controller: c.tipoReporteBusqueda,
                          values: c.listaTiposReportes,
                          icono: MaterialIcons.list_alt,
                        ),
                      ),
                    ],
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
                        PendientesListadoForm(
                          scrollController: c.pendientesScrollController,
                          reportesLocal: c.reportesLocal,
                          abrirReporte: c.gestionarReporteLocal,
                          subirReportePendiente: c.subirReportePendiente,
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
              AjustesForm(
                idUsuarioMenu: c.idUsuarioMenu,
                usuarioMenu: c.usuarioMenu,
                nombreMenu: c.nombreMenu,
                perfilMenu: c.perfilMenu,
                scrollController: c.ajustesScrollController,
                cambiarPasswordForm: c.cambiarPasswordForm,
                reestablcerAplicacion: c.reestablcerAplicacion,
                esMayusculas: c.mayusculas,
                configMayusculas: c.configMayusculas,
                verFirma: c.verFirma,
                configFirma: c.configFirma,
                isAdmin: c.isAdmin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}