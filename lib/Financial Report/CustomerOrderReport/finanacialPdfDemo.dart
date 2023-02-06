import 'dart:io';
import 'dart:ui';
import 'package:charts_flutter/flutter.dart';
import 'package:easycare/Financial%20Report/CustomerOrderReport/customerOrderReportUi.dart';
import 'package:easycare/Financial%20Report/CustomerOrderReport/services/customerOrderReportAPI.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../mobilepdf.dart';

// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

Future<void> generateInvoice(String username) async {

  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  final PdfGrid grid = getGrid();

  final PdfLayoutResult result = drawHeader(page, pageSize, grid,username);
  //Draw grid
  drawGrid(page, grid, result);

  drawFooter(page, pageSize);


  final List<int> bytes = document.save();


  document.dispose();


  await saveAndLaunchFile(bytes, 'PartyInvoice.pdf');
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,String username) {
  //Draw rectangle

  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
  //Draw string
  // page.graphics.drawImage(
  //
  //     PdfBitmap(File("").readAsBytesSync()),
  //     Rect.fromLTWH(
  //         0, 0, page.getClientSize().width, page.getClientSize().height));
  page.graphics.drawString('''                            Soori IMS
                      Dillibazar, Kathmandu
                      Party Report (Summary) ''',

      PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(25, 0, pageSize.width, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String date =
      'Printed Data: ${format.format(DateTime.now())}\r\n\r\nPrinted By: ${username.toUpperCase()}';
  final Size contentSize = contentFont.measureString(date);
  // ignore: leading_newlines_in_multiline_strings
  String address =
  '''Date Range:${StartdateController.text} to ${EnddateController.text} \r\n\r\n
      ${DateTime.now()} ''';

  PdfTextElement(text: date, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120));

  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120))!;
}


//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  Rect? totalPriceCellBounds;
  Rect? quantityCellBounds;
  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;


}
void drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
  PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  //Draw line
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100));

  const String footerContent =
  // ignore: leading_newlines_in_multiline_strings
  '''Soori Technology\r\n\r\nDillibazar, Kathmandu,
         +977-9808445666\r\n\r\nAny Questions? Mail @daman@sooritechnology.com''';

  //Added 30 as a margin for the layout
  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));


}



//Create PDF grid and return
PdfGrid getGrid() {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 5);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Order No';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Customer';
  headerRow.cells[2].value = 'Sub Total';
  headerRow.cells[3].value = 'Grand Total';
  headerRow.cells[4].value = 'Purchase Order Type';

  // headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;



  // headerRow.cells[5].value = 'Grand Total';
 total();

  //Add rows
  for (var i =0;i<customerOrderReport.length;i++){
    partyRow(
      customerOrderReport[i].orderNo.toString(),
      customerOrderReport[i].customerFirstName.toString()+customerOrderReport[i].customerLastName.toString(),
      customerOrderReport[i].subTotal.toString(),
      customerOrderReport[i].grandTotal.toString(),
      customerOrderReport[i].statusDisplay.toString(),

        grid,
    );
  }
  totalProduct(

    "Rs.${grandTotal.toString()}",
    "Rs.${totalSub.toString()}",

    grid,
  );
  grandTotal = 0.0;
      totalSub = 0.0;

   // log(partyReport[0].name.toString());
  //Apply the table built-in style
  // grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  //Set gird columns width
  grid.columns[0].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.left;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;

}

//Create and row for the grid.
void partyRow(String OrderNo, String Customer,String SubTotal,String GrandTotal,String PackingType,  PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = OrderNo;
  row.cells[1].value = Customer;
  row.cells[2].value = SubTotal;
  row.cells[3].value = GrandTotal;
  row.cells[4].value = PackingType;


  // row.cells[5].value = grandTotal.toString();
}

void totalProduct(String grandtotal, String totalSub, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[2].value = grandtotal;
  row.cells[3].value = totalSub;

}

//calculate total
double grandTotal = 0.0,
    totalSub = 0.0;


total() {
  for (int i = 0; i < customerOrderReport.length; i++) {
    grandTotal += double.parse(customerOrderReport[i].grandTotal!);
    totalSub += double.parse(customerOrderReport[i].subTotal!);


  }
}

//calculate total

