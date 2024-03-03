import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


TextEditingController importFormField = TextEditingController();
TextEditingController exportFormField = TextEditingController();
PlatformFile? globalSelectedTXT;
String? globalContent;
List<String> linhas = [];
List<Text> linhasText = [];
//List<Map<String, dynamic>> objList = [];

List<String> jsonList = [];
class _HomeScreenState extends State<HomeScreen> {



  Future<List<String>> getFileAndResolve() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      linhas.clear();
      linhasText.clear();
      jsonList.clear();
      //objList.clear();
      globalSelectedTXT = result.files.single;
      globalContent = await File(result.files.single.path as String).readAsString();
    } else {
      return [];
    }

    //linhas = LineSplitter.split(globalContent as String).toList();
    //debugPrint(LineSplitter.split(globalContent as String).toList().toString());
    List<String> listTest = LineSplitter.split(globalContent as String).toList();
    for (int i = 0; i < listTest.length; i++) {
      linhasText.add(Text(listTest[i]));
      addToObjList(listTest[i], i);
      debugPrint('[DEBUG][INDEX - $i]: ${listTest[i]} - charSize ${listTest[i].length}');
    }

    return listTest;

  }

  void objPreviewPopup(int index) {

    String element = linhas[index];

    String codUnidadeGestora = element.substring(0, 6); //1, 6
    String mesReferencia = element.substring(6, 8);//codUnidadeGestora.length, codUnidadeGestora.length + 2); //7, 8
    String codigoFarmacia = element.substring(8, 15); //9, 16
    String codigoProduto = element.substring(15, 29); //17, 31
    String descricao = element.substring(29, 89); //32, 92
    String unidade_medida = element.substring(89, 99);//element.length - 26, (element.length - 26) + 10); //93, 103
    String quantidade = element.substring(99, 115);//element.length - 16, element.length);// 104, 120

    //debugPrint('[DEBUG] cnes: $codUnidadeGestora, mesReferencia: $mesReferencia, codigoFarmacia: $codigoFarmacia, codigoProduto: $codigoProduto, descricao: $descricao, unidade_medida: $unidade_medida}');

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(linhas[index]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Text>[
            Text('charSize [6/${codUnidadeGestora.length}] codigoUnidadeGestora: $codUnidadeGestora'),
            Text('charSize [2/${mesReferencia.length}] mesReferencia: $mesReferencia'),
            Text('charSize [7/${codigoFarmacia.length}] codigoFarmacia: $codigoFarmacia'),
            Text('charSize [14/${codigoProduto.length}] codigoProduto: $codigoProduto'),
            Text('charSize [60/${descricao.length}] descricao: ${descricao.replaceAll(RegExp("-"), "")}'),
            Text('charSize [10/${unidade_medida.length}] unidade_medida: ${unidade_medida.replaceAll(RegExp("-"), "")}'),
            Text('charSize [16/${quantidade.length}] quantidade: $quantidade'),
          ],
        ),
      );
    });

  }

  void addToObjList(String element, int index) {

    String codUnidadeGestora = element.substring(0, 6); //1, 6
    String mesReferencia = element.substring(6, 8);//codUnidadeGestora.length, codUnidadeGestora.length + 2); //7, 8
    String codigoFarmacia = element.substring(8, 15); //9, 16
    String codigoProduto = element.substring(15, 29); //17, 31
    String descricao = element.substring(29, 89); //32, 92
    String unidade_medida = element.substring(89, 99);//element.length - 26, (element.length - 26) + 10); //93, 103
    String quantidade = element.substring(99, 115);//element.length - 16, element.length);// 104, 120

    Map<String, dynamic> j = ({
      'codUnidadeGestora': codUnidadeGestora,
      'mesReferencia': mesReferencia,
      'codigoFarmacia': codigoFarmacia,
      'codigoProduto': codigoProduto,
      'descricao': descricao.replaceAll(RegExp("-"), ""),
      'unidade_medida': unidade_medida.replaceAll(RegExp("-"), ""),
      'quantidade': quantidade,
    });

    jsonList.add(jsonEncode(j));

    return;
  }
  Future<void> exportButton() async {

    /*debugPrint(jsonList.toString());

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text(''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Text>[
            Text(jsonList.toString()),
          ],
        ),
      );
    });*/


    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'exportedMedicamentod.json',
    );

    if (outputFile == null) {
      return;
    }

    File arquivo = File(outputFile);

    arquivo.writeAsString(jsonDecode(jsonEncode(jsonList)).toString());



    //debugPrint(objList.toString());


    return;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            MaterialButton(
              child: const Row(
                children: [
                  Icon(Icons.file_open),
                  Text('Abrir TXT'),
                ],
              ),
              onPressed: () async {

                getFileAndResolve().then((value) {
                  setState(() {
                    globalSelectedTXT;
                    linhas = value;
                  });
                });
              },
            ),

            MaterialButton(
              child: const Row(
                children: <Widget>[
                  Icon(Icons.refresh),
                  Text('Refresh'),
                ],

              ),
              onPressed: () {
                setState(() {
                  importFormField;
                  exportFormField;
                  linhas;
                });
              },
            ),

            MaterialButton(
              child: const Row(
                children: <Widget>[
                  Icon(Icons.open_in_new),
                  Text('Exportar'),
                ],

              ),
              onPressed: () async {
                await exportButton();
              },
            ),

            Text('Selected: ${globalSelectedTXT.toString()}'),

          ],
        ),
      ),
      body: ListView(

          children: <ListTile>[

            for(int i = 0; i < linhas.length; i++) ListTile(
              title: Row(
                children: [

                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: linhas[i]));
                    },
                  ),
                  Text('charSize [${linhas[i].length}] - ${linhas[i]}'),
                ],
              ),
              onTap: () {
                objPreviewPopup(i);
              },
            ),
          ]
      ),
    );
  }
}
