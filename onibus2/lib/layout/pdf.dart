import 'dart:io';

import 'package:flutter/material.dart' as prefix0;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'contac_page.dart';

class Pdf {


  PaginaContato aviso = PaginaContato();

Future main() async {
  final Document pdf = Document();

  pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('Portable Document Format',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
            Header(
                level: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Portable Document Format', textScaleFactor: 2),
                      PdfLogo()
                    ])),
Table.fromTextArray(context: context, data: const <List<String>>[
              <String>['P', 'Nome', 'RG/RA','P', 'Nome', 'RG/RA'],
              <String>['1993', 'PDF 1.0', 'Acrobat 1'],
              <String>['1994', 'PDF 1.1', 'Acrobat 2'],
              <String>['1996', 'PDF 1.2', 'Acrobat 3'],
              <String>['1999', 'PDF 1.3', 'Acrobat 4'],
              <String>['2001', 'PDF 1.4', 'Acrobat 5'],
              <String>['2003', 'PDF 1.5', 'Acrobat 6'],
              <String>['2005', 'PDF 1.6', 'Acrobat 7'],
              <String>['2006', 'PDF 1.7', 'Acrobat 8'],
              <String>['2008', 'PDF 1.7', 'Acrobat 9'],
              <String>['2009', 'PDF 1.7', 'Acrobat 9.1'],
              <String>['2010', 'PDF 1.7', 'Acrobat X'],
              <String>['2012', 'PDF 1.7', 'Acrobat XI'],
              <String>['2017', 'PDF 2.0', 'Acrobat DC'],
            ]),
            Padding(padding: const EdgeInsets.all(10)),
            Paragraph(
                text:
                    'Text is available under the Creative Commons Attribution Share Alike License.')
          ]));


  final output = await getExternalStorageDirectory() ;
  final file = File ("${output.path}/exemplo.pdf");
  await file.writeAsBytes(pdf.save());

}
}
