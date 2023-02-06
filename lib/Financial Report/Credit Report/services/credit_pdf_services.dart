import 'dart:ui';

import 'package:easycare/Financial%20Report/Credit%20Report/credit_report_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' show get;
import 'credit_report_services.dart';
import '../../mobilepdf.dart';

Future<void> generateCreditReport() async {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();

  //Generate PDF grid.
  final PdfGrid grid = getGrid();
  final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  //Draw grid
  drawGrid(page, grid, result);
  //Save the PDF document
  drawFooter(page, pageSize);
  final List<int> bytes = document.save();
  document.dispose();
  final DateFormat format = DateFormat.yMMMMd('en_US');

  await saveAndLaunchFile(
      bytes, 'CreditPayment${format.format(DateTime.now())}.pdf');
}



//Draws the credit report header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
  //Draw string
  page.graphics.drawString('''                            Soori IMS
                      Dillibazar, Kathmandu
                      Credit Report (Summary) ''',

      PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(25, 0, pageSize.width, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));


  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String date =
      'Printed Data: ${format.format(DateTime.now())}\r\n\r\nPrinted By:${creditReport.first.createdByUserName} ';
  final Size contentSize = contentFont.measureString(date);
  // ignore: leading_newlines_in_multiline_strings
  String address =
      '''Date Range:${startDateController.text} to ${endDateController.text} \r\n\r\n
       ''';

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

  grid.columns.add(count: 6);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Customer';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Grand Total';
  headerRow.cells[2].value = 'Paid Amount';
  headerRow.cells[3].value = 'Refund Amount ';
  headerRow.cells[4].value = 'Returned Amount';
  headerRow.cells[5].value = 'Due Amount';

  //Add rows
  total();

  for (var i = 0; i < creditReport.length; i++) {
    addProducts(
      creditReport[i].firstName.toString(),
      creditReport[i].totalAmount.toString(),
      creditReport[i].paidAmount.toString(),
      creditReport[i].refundAmount.toString(),
      creditReport[i].returnedAmount.toString(),
      creditReport[i].dueAmount.toString(),
      grid,
    );
  }
  totalProduct(
    "Rs.${grandTotal.toString()}",
    "Rs.${totalRefund.toString()}",
    "Rs.${totalReturn.toString()}",
    "Rs.${totalPaid.toString()}",
    "Rs.${totalDue.toString()}",
    grid,
  );

  grandTotal = 0.0;
  totalRefund = 0.0;
  totalReturn = 0.0;
  totalPaid = 0.0;
  totalDue = 0.0;

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
void addProducts(String name, String totalAmount, String paidAmount,
    String refundAmount, String returnAmount, String dueAmount, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = name;
  row.cells[1].value = totalAmount;
  row.cells[4].value = paidAmount.toString();
  row.cells[2].value = refundAmount;
  row.cells[3].value = returnAmount;
  row.cells[5].value = dueAmount.toString();
}

void totalProduct(String grandtotal, String totalRefund, String totalReturn,
    String totalPaid, String totalDue, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[1].value = grandtotal;
  row.cells[2].value = totalRefund;
  row.cells[3].value = totalReturn;
  row.cells[4].value = totalPaid;
  row.cells[5].value = totalDue;
}

//calculate total
double grandTotal = 0.0,
    totalRefund = 0.0,
    totalReturn = 0.0,
    totalPaid = 0.0,
    totalDue = 0.0;

total() {
  for (int i = 0; i < creditReport.length; i++) {
    grandTotal += double.parse(creditReport[i].totalAmount!);
    totalRefund += double.parse(creditReport[i].refundAmount!);
    totalReturn += double.parse(creditReport[i].returnedAmount!);
    totalPaid += double.parse(creditReport[i].paidAmount!);
    totalDue += double.parse(creditReport[i].dueAmount!);
  }
}
