import 'package:animate_do/animate_do.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../utils/literals.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/combos/selection_combo.dart';
import '../../widgets/containers/limite_pendientes_container.dart';
import '../../widgets/drawers/header_drawer.dart';
import '../../widgets/drawers/item_drawer.dart';
import '../../widgets/forms/ajustes_form.dart';
import '../../widgets/forms/pendientes_listado_form.dart';
import '../../widgets/forms/reportes_servidor.dart';
import '../../widgets/forms/sin_internet_form.dart';
import '../../widgets/forms/sin_reportes_local_form.dart';
import '../../widgets/forms/sin_reportes_servidor.dart';
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
            /*actions: c.menuIndex == 0 ? <Widget>[
              PopupMenuButton(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return c.opcionesConsulta.map((opcion) {
                    return PopupMenuItem(
                      onTap: () {
                        c.operacionPopUp(opcion.id);
                      },
                      labelTextStyle: WidgetStateProperty.all(
                        TextStyle(
                          color: Color(ColorList.sys[0]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          opcion.icono,
                          color: Color(ColorList.sys[0]),
                        ),
                        title: Text(opcion.value!,),
                      ),
                    );
                  }).toList();
                }
              ),
            ] : null,*/
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Versión: ${Literals.version}",
                      style: TextStyle(
                        color: Color(0xFFAEB6BF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
            physics: NeverScrollableScrollPhysics(),
            controller: c.menuController,
            onPageChanged: c.menuPageChanged,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DateTextform(
                          ltrbp: [10, 5, 10, 0],
                          height: 50,
                          controller: c.fechaBusqueda,
                          focusNode: c.fechaBusquedaFocus,
                          dateSelected: c.dateSelected,
                          text: 'Fecha consulta',
                          formato: 'dd/MM/yyyy',
                        ),
                      ),
                      Expanded(
                        child: SelectionCombo(
                          ltrb: [10, 5, 10, 0],
                          height: 50,
                          titulo: "- Filtrar por tipo -",
                          controller: c.tipoReporteBusqueda,
                          values: c.listaTiposReportes,
                          icono: MaterialIcons.list_alt,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: SelectionCombo(
                            ltrb: [10, 0, 10, 0],
                            height: 45,
                            titulo: "- Filtrar por usuario -",
                            controller: c.usuariosBusqueda,
                            values: c.listaUsuarios,
                            icono: MaterialIcons.person_search,
                          ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if(!c.cargandoReportes) {
                          if(c.conInternet) {
                            if(c.reportesServidor!.isNotEmpty) {
                              return ReportesServidorForm(
                                scrollController: c.servidorScrollController,
                                reportesServidor: c.reportesServidor,
                                abrirReporte: c.abrirReporteServidor,
                              );
                            } else {
                              return SinReportesServidorForm();
                            }
                          } else {
                            return SinInternetForm(
                              recargar: () {},
                              mostrarBoton: false,
                            );
                          }
                        } else {
                          return Center(
                            child: SpinKitThreeInOut(
                              color: Color(ColorList.sys[1]),
                            ).fadeIn(delay: 0.5.seconds,),
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
                        LimitePendientesContainer(
                          reportesLocalSize: c.reportesLocalSize,
                          reportesLocalSizeLimit: c.reportesLocalSizeLimit,
                        ),
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
                          onPressed: c.subirTodosReportesPendientes, 
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
                obtenerFirmas: c.obtenerFirmas,
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