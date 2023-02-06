import 'dart:developer';

import 'dart:ui';
import 'package:easycare/Financial%20Report/Party%20Report/partyReportScreen.dart';
import 'package:easycare/Financial%20Report/Quotation%20Report/reportAPI.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../Party Report/Services/reportApi.dart';
import '../mobilepdf.dart';


// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

Future<void> generateInvoice( username,quotationno) async {
  log(username.toString());
  String? userName =username;

  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  final PdfGrid grid = getGrid();

  final PdfLayoutResult result = drawHeader(page, pageSize, grid,username,quotationno);
  //Draw grid
  drawGrid(page, grid, result);


  final List<int> bytes = document.save();
  document.dispose();
  await saveAndLaunchFile(bytes, 'Quotation.pdf');
}
//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid , String username,String quotationno) {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
  //Draw string
  page.graphics.drawString('''                          Soori Technology Pvt Ltd
                                     Quotation  ''',
      PdfStandardFont(PdfFontFamily.helvetica, 20 ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(25, 0, pageSize.width, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));


  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String date =
      'Data: ${format.format(DateTime.now())}\r\n\r\n Quotation No:${quotationno}  ';
  final Size contentSize = contentFont.measureString(date);
  // ignore: leading_newlines_in_multiline_strings
  String address =
  '''Soori Technology Pvt ltd\nKalika\nKathmandu\nContact: +977-9808445666\ndaman@sooritechnology.com\n\n\nTo: ${username}\r\n\r\n
       ''';

  PdfTextElement(text: date, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120));

      // .add()
      // .graphics
      // .drawImage(PdfBitmap(imageData), Rect.fromLTWH(0, 0, 100, 100));

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
  grid.columns.add(count: 4);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(255,255,0));
  // PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold);
  headerRow.style.font =   PdfStandardFont(PdfFontFamily.helvetica, 11, style: PdfFontStyle.bold);
  headerRow.style.textBrush = PdfBrushes.black;
  headerRow.cells[0].value = 'Name';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Qty';
  headerRow.cells[2].value = 'Sale Cost';
  headerRow.cells[3].value = 'Cancelled';
  total();
  for (var i =0;i<quotationReport.length;i++){
    partyRow(
      quotationReport[i].itemName.toString(),
  quotationReport[i].qty.toString(),
      quotationReport[i].saleCost.toString(),
        quotationReport[i].cancelled.toString(),
      grid,
    );
  }
  totalProduct(
    "Rs.${grandTotal.toString()}",
    grid,
  );
  grandTotal = 0.0;

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
void partyRow(String name, String qty,String saleCost,String cancelled,  PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = name;
  row.cells[1].value = qty;
  row.cells[2].value = saleCost;
  row.cells[3].value = cancelled;

  // row.cells[5].value = grandTotal.toString();
}
void totalProduct(String grandTotal, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[2].value = grandTotal;

}


//calculate total
double grandTotal = 0.0;



total() {
  for (int i = 0; i < quotationReport.length; i++) {
    grandTotal += double.parse(quotationReport[i].saleCost!);
  }
  log(grandTotal.toString());
}



