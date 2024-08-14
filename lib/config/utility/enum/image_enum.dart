import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageEnum {
  bienConnectLogo('bien_connect_logo'),
  barGroup("bar_group"),
  ayarlar("ayarlar"),
  eFaturaGelen("e_fatura_gelen"),
  eFaturaGiden("e_fatura_giden"),
  eFaturaTaslak("e_fatura_taslak"),
  eFaturaOlusturma("e_fatura_olusturma"),
  mukellefSorgulama("mukellef_sorgulama"),
  document("document"),
  //!Drawer
  drawerEmm("drawer_emm"),
  drawerEsmm("drawer_esmm"),
  drawerInvoice("drawer_invoice"),
  drawerSettings("drawer_settings"),
  drawerTaxpayer("drawer_taxpayer"),
  drawerWaybill("drawer_waybill"),
  drawerUser("drawer_user"),
  //!Step
  stepGeneral("step_general"),
  stepInvoiceLine("step_invoice_line"),
  //!Create Invoice
  addressInfo("address_info"),
  generalInfo("general_info"),
  invoiceLine("invoice_line"),
  noteInfo("note_info"),
  totalInfo("total_info"),
  ;

  final String value;
  const ImageEnum(this.value);

  String get toPng => 'assets/images/$value.png';
  String get toSvg => 'assets/svg/$value.svg';

  Image get toPngImage => Image.asset(toPng);
  SvgPicture get toSvgImage => SvgPicture.asset(toSvg);
}
