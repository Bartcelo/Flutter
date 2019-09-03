import 'dart:io';
import 'package:onibus2/helper/contact_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'contac_page.dart';

class Pdf {

  ContactHelper helper = ContactHelper();
  List <Contact> contacts =[];



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
      build: (Context context,) => <Widget>[
            Header(
                level: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Portable Document Format', textScaleFactor: 2),
                      PdfLogo()
                    ])),
Table.fromTextArray(context: context, data: <List<String>>[
              <String>['P', 'Nome', 'RG/RA','P', 'Nome', 'RG/RA'],
              <String>['1' ,'Marcelo Gonzaga','328407148','2','Raiane Gonzaga','098129430'],
              
              
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

