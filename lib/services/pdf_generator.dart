import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import '../models/appliance.dart';
import 'database_helper.dart';

class PdfGenerator {
  static Future<void> generatePDF() async {
    final pdf = pw.Document();

    // Obter aparelhos do banco de dados
    List<Appliance> appliances = await DatabaseHelper.instance.getAppliances();

    // Calcular consumo total
    double totalConsumption = appliances.fold(0.0, (sum, appliance) {
      return sum + (appliance.power * appliance.hoursPerDay);
    });

    // Criar o conteúdo do PDF
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
            child: pw.Text('Relatório de Consumo de Energia',
                style: pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Consumo Total: ${totalConsumption.toStringAsFixed(2)} Wh',
              style: pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 20),
          pw.Text('Detalhes dos Aparelhos:', style: pw.TextStyle(fontSize: 18)),
          pw.Table.fromTextArray(
            headers: ['Aparelho', 'Potência (W)', 'Horas/Dia', 'Consumo (Wh)'],
            data: appliances.map((appliance) {
              double consumption =
                  appliance.power * appliance.hoursPerDay;
              return [
                appliance.name,
                appliance.power.toStringAsFixed(2),
                appliance.hoursPerDay.toStringAsFixed(2),
                consumption.toStringAsFixed(2),
              ];
            }).toList(),
          ),
        ],
      ),
    );

    // Salvar o PDF no diretório temporário
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/relatorio.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
