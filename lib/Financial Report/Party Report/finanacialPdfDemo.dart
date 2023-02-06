import 'dart:ui';
import 'package:easycare/Financial%20Report/Party%20Report/partyReportScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../mobilepdf.dart';
import 'Services/reportApi.dart';

// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

Future<void> generateInvoice() async {

  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  final PdfGrid grid = getGrid();

  final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  //Draw grid
  drawGrid(page, grid, result);


  final List<int> bytes = document.save();


  document.dispose();


  await saveAndLaunchFile(bytes, 'PartyInvoice.pdf');
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
  //Draw rectangle
  
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
  //Draw string
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
      'Printed Data: ${format.format(DateTime.now())}\r\n\r\nPrinted By:${partyReport.first.createdByUserName.toString()}';
  final Size contentSize = contentFont.measureString(date);
  // ignore: leading_newlines_in_multiline_strings
  String address =
  '''Date Range:${StartdateController.text} to ${EnddateController.text} \r\n\r\n
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



//Create PDF grid and return
PdfGrid getGrid() {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 6);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Name';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
  // headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Total amount';
  headerRow.cells[2].value = 'Refund';
  headerRow.cells[3].value = 'Return';
  headerRow.cells[4].value = 'Paid';
  headerRow.cells[5].value = 'Due';
  // headerRow.cells[5].value = 'Grand Total';
 total();

  //Add rows
  for (var i =0;i<partyReport.length;i++){
    partyRow(
        partyReport[i].name.toString(),
        partyReport[i].totalAmount.toString(),
        partyReport[i].refundAmount.toString(),
        partyReport[i].returnedAmount.toString(),
        partyReport[i].paidAmount.toString(),
        partyReport[i].dueAmount.toString(),


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
void partyRow(String name, String totalAmount, String refund,
    String returnAmount,String paid,  String due, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = name;
  row.cells[1].value = totalAmount;
  row.cells[2].value = refund;
  row.cells[3].value = returnAmount;
  row.cells[4].value = paid;
  row.cells[5].value = due;
  // row.cells[5].value = grandTotal.toString();
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
  for (int i = 0; i < partyReport.length; i++) {
    grandTotal += double.parse(partyReport[i].totalAmount!);
    totalRefund += double.parse(partyReport[i].refundAmount!);
    totalReturn += double.parse(partyReport[i].returnedAmount!);
    totalPaid += double.parse(partyReport[i].paidAmount!);
    totalDue += double.parse(partyReport[i].dueAmount!);
  }
}