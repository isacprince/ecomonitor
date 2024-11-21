import 'package:flutter/material.dart';
import '../services/pdf_generator.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportsScreen extends StatelessWidget {
  void generatePDFReport(BuildContext context) async {
    await PdfGenerator.generatePDF();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Relatório PDF gerado com sucesso!')),
    );
    // Abrir o PDF
    final output = await getTemporaryDirectory();
    final filePath = "${output.path}/relatorio.pdf";
    await OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => generatePDFReport(context),
          child: Text('Gerar Relatório em PDF'),
        ),
      ),
    );
  }
}
