import '/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int whatOptionAlmoxarifado = 1;
bool naoEscolheuAlmoxarifado = true;
bool isMaterial = false;
bool isReagente = false;
bool isControle = false;

class Almoxarifado extends StatefulWidget {
  @override
  _AlmoxarifadoState createState() => _AlmoxarifadoState();
}

class _AlmoxarifadoState extends State<Almoxarifado> {
  final String baseUrl =
      "https://script.google.com/macros/s/AKfycbwVRfI8u87rBLEzZD_3pnPP-YnqOZ_iijWygPUGfUlTluMkOH6rJEfGQLuskRMlAp5_/exec";
  final String deleteUrl =
      "https://script.google.com/macros/s/AKfycbz60IyC55k4qZ5K0f87vkR2nuE1xsIy6rRCgII5741aYJrjN-6bnAJYzDr7y-g18o9_lg/exec";

  List<dynamic> orders = [];
  List<dynamic> fetchedData = [];

  TextEditingController productIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();

//-~---~-~~-~-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-

  Future<void> fetchDataReagentes() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbwB2uhI7cmKGDDLNYey-v_uW5ROMCHgs3eRv2CGM85ChSc5qnmFT7YiVQ80TJB2YeAmHQ/exec'));
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          final jsonData = json.decode(response.body);
          fetchedData = List<dynamic>.from(jsonData['user']);
        });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataMateriais() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbwR9dF2PSHcHPFtcFzE-kg37m-n1ChVtiVhgWN1GbWkU4HdBf8yZ238f8KkkFMTRmrd/exec'));
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          final jsonData = json.decode(response.body);
          fetchedData = List<dynamic>.from(jsonData['user']);
        });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataControle() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbwJ8oCPStR969P7UULnOQX8k-_5mJ6ZAKO0wrm0YG-SRUc5hudzAXD56idAVkGb6vFM/exec'));
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          final jsonData = json.decode(response.body);
          fetchedData = List<dynamic>.from(jsonData['user']);
        });
    } else {
      throw Exception('Failed to load data');
    }
  }

// ~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-~---~=-=-=-=-=-=-=-=-
  @override
  void initState() {
    super.initState();

    if (whatOptionAlmoxarifado == 1) {
      fetchDataReagentes();
    } else if (whatOptionAlmoxarifado == 2) {
      fetchDataMateriais();
    } else if (whatOptionAlmoxarifado == 3) {
      fetchDataControle();
    }
  }

  Future<void> insertData(String productName, String productId) async {
    var url = Uri.parse(baseUrl +
        "?ProductId=${productId}"
            "&ProductName=${productName}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'SUCCESS') {
        // Order added successfully
        print("Order added successfully");
      } else {
        // Order addition failed
        print("Failed to add order: ${jsonResponse['message']}");
      }
    } else {
      // HTTP request failed
      print("HTTP Request failed with status: ${response.statusCode}");
    }
  }

  Future<void> deleteData(String productName) async {
    var url = Uri.parse(deleteUrl + "?ProductId=carlos");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'SUCCESS') {
        // Order added successfully
        print("Order added successfully");
      } else {
        // Order addition failed
        print("Failed to add order: ${jsonResponse['message']}");
      }
    } else {
      // HTTP request failed
      print("HTTP Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: naoEscolheuAlmoxarifado
            ? whatAlmoxarifado()
            : isReagente
                ? ChoiceScreenAlmoxarifado()
                : isMaterial
                    ? ChoiceScreenMateriais()
                    : ChoiceScreenControle());
  }

  Widget ChoiceScreenAlmoxarifado() {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //    onPressed: () => deleteData(''), child: const Text('APAGAR')),
          Expanded(
            child: fetchedData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: fetchedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DetalhesProdutoReagentes(
                                  produto: fetchedData[index]);
                            },
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              '${fetchedData[index]['identificacao']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Peso: ${fetchedData[index]['peso']} (g ou ml)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Quantidade: ${fetchedData[index]['quantidade']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Validade: ${fetchedData[index]['validade']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Inserir Novo Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(labelText: 'Nome do Produto'),
                    ),
                    TextField(
                      controller: productIdController,
                      decoration: InputDecoration(labelText: 'ID do Produto'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      insertData(
                          productNameController.text, productIdController.text);
                      setState(() {
                        fetchedData.add({
                          'IDENTIFICACAO': productNameController.text,
                          'PESO': productIdController.text,
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirmar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget ChoiceScreenMateriais() {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //    onPressed: () => deleteData(''), child: const Text('APAGAR')),
          Expanded(
            child: fetchedData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: fetchedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DetalhesProdutoMateriais(
                                  produto: fetchedData[index]);
                            },
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              '${fetchedData[index]['material']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Descrição: ${fetchedData[index]['descricao']} ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Quantidade: ${fetchedData[index]['quantidade']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 2, 68, 126)),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Tamanho: ${fetchedData[index]['tamanho']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Inserir Novo Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(labelText: 'Nome do Produto'),
                    ),
                    TextField(
                      controller: productIdController,
                      decoration: InputDecoration(labelText: 'ID do Produto'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      insertData(
                          productNameController.text, productIdController.text);
                      setState(() {
                        fetchedData.add({
                          'IDENTIFICACAO': productNameController.text,
                          'PESO': productIdController.text,
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirmar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget ChoiceScreenControle() {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //    onPressed: () => deleteData(''), child: const Text('APAGAR')),
          Expanded(
            child: fetchedData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: fetchedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DetalhesProdutoMateriais(
                                  produto: fetchedData[index]);
                            },
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              '${fetchedData[index]['material']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Descrição: ${fetchedData[index]['descricao']} ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Quantidade: ${fetchedData[index]['quantidade']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 2, 68, 126)),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Tamanho: ${fetchedData[index]['tamanho']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Inserir Novo Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(labelText: 'Nome do Produto'),
                    ),
                    TextField(
                      controller: productIdController,
                      decoration: InputDecoration(labelText: 'ID do Produto'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      insertData(
                          productNameController.text, productIdController.text);
                      setState(() {
                        fetchedData.add({
                          'IDENTIFICACAO': productNameController.text,
                          'PESO': productIdController.text,
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirmar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class isReagenteScreen extends StatefulWidget {
  const isReagenteScreen({super.key});

  @override
  State<isReagenteScreen> createState() => _isReagenteScreenState();
}

class _isReagenteScreenState extends State<isReagenteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DetalhesProdutoReagentes extends StatelessWidget {
  final Map<String, dynamic> produto;

  DetalhesProdutoReagentes({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes do Produto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ID do Produto: ${produto['identificacao']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nome do Produto: ${produto['peso']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Validade do Produto: ${produto['quantidade']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Validade do Produto: ${produto['tipo']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Validade do Produto: ${produto['observacao']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditarProdutoDialogReagente(
                          produto: produto,
                          onSave: (editedProduct) {
                            // Lógica para salvar as alterações do produto aqui
                            // Você pode acessar os valores editados em 'editedProduct'
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetalhesProdutoMateriais extends StatelessWidget {
  final Map<String, dynamic> produto;

  DetalhesProdutoMateriais({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes do Material',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Material: ${produto['material']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Descrição: ${produto['descricao']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Tamanho: ${produto['tamanho']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Quantidade: ${produto['quantidade']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Observação: ${produto['quantidade']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditarProdutoDialogMaterial(
                          produto: produto,
                          onSave: (editedProduct) {
                            // Lógica para salvar as alterações do produto aqui
                            // Você pode acessar os valores editados em 'editedProduct'
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditarProdutoDialogReagente extends StatelessWidget {
  final Map<String, dynamic> produto;
  final Function(Map<String, dynamic>) onSave;

  EditarProdutoDialogReagente({required this.produto, required this.onSave});

  final TextEditingController identificacaoController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController validadeController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    identificacaoController.text = produto['identificacao'];
    pesoController.text = produto['peso'];
    validadeController.text = produto['validade'];
    tipoController.text = produto['tipo'];
    quantidadeController.text = produto['quantidade'];
    observacaoController.text = produto['observacao'];

    return AlertDialog(
      title: Text(
        'Editar Item',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: identificacaoController,
            decoration: InputDecoration(labelText: 'ID do Produto'),
          ),
          TextField(
            controller: pesoController,
            decoration: InputDecoration(labelText: 'Nome do Produto'),
          ),
          TextField(
            controller: validadeController,
            decoration: InputDecoration(labelText: 'Validade do Produto'),
          ),
          TextField(
            controller: quantidadeController,
            decoration: InputDecoration(labelText: 'Quantidade do Produto'),
          ),
          TextField(
            controller: tipoController,
            decoration: InputDecoration(labelText: 'Tipo do Produto'),
          ),
          TextField(
            controller: observacaoController,
            decoration: InputDecoration(labelText: 'Observação do Produto'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> editedProduct = {
              'identificacao': identificacaoController.text,
              'quantidade': pesoController.text,
              'validade': validadeController.text,
            };
            onSave(editedProduct);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class EditarProdutoDialogMaterial extends StatelessWidget {
  final Map<String, dynamic> produto;
  final Function(Map<String, dynamic>) onSave;

  EditarProdutoDialogMaterial({required this.produto, required this.onSave});

  final TextEditingController identificacaoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController tamanhoController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    identificacaoController.text = produto['material'];
    descricaoController.text = produto['descricao'];
    tamanhoController.text = produto['tamanho'];
    quantidadeController.text = produto['quantidade'];
    observacaoController.text = produto['observacao'];

    return AlertDialog(
      title: Text(
        'Editar Item',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: identificacaoController,
            decoration: InputDecoration(labelText: 'Nome do material'),
          ),
          TextField(
            controller: descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: tamanhoController,
            decoration: InputDecoration(labelText: 'Tamanho'),
          ),
          TextField(
            controller: quantidadeController,
            decoration: InputDecoration(labelText: 'Quantidade'),
          ),
          TextField(
            controller: observacaoController,
            decoration: InputDecoration(labelText: 'Observação'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> editedProduct = {
              'identificacao': identificacaoController.text,
              'quantidade': descricaoController.text,
              'validade': tamanhoController.text,
            };
            onSave(editedProduct);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class whatAlmoxarifado extends StatefulWidget {
  @override
  State<whatAlmoxarifado> createState() => _whatAlmoxarifadoState();
}

class _whatAlmoxarifadoState extends State<whatAlmoxarifado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  naoEscolheuAlmoxarifado = false;
                  whatOptionAlmoxarifado = 1;
                  isReagente = true;
                });

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Card(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Text(
                      'Reagentes',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  naoEscolheuAlmoxarifado = false;
                  whatOptionAlmoxarifado = 2;
                  isMaterial = true;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Text(
                      'Materiais',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  naoEscolheuAlmoxarifado = false;
                  whatOptionAlmoxarifado = 3;
                  isControle = true;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    width: 250,
                    alignment: Alignment.center,
                    child: Text(
                      'Controle de Estoque',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
