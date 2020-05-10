import 'package:first_project/models/pessoa.dart';
import 'package:first_project/screens/formulario_pessoa_api.dart';
import 'package:first_project/screens/item_pessoa.dart';
import 'package:first_project/screens/progress.dart';
import 'package:first_project/web_client/web_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaPessoasApi extends StatelessWidget{

  List<Pessoa> pessoas;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      body: FutureBuilder<List<Pessoa>>(
        initialData: List(),
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              this.pessoas = snapshot.data;

              return ListView.builder(
                itemCount: this.pessoas.length,
                itemBuilder: (context, indice) {
                  Pessoa pessoa = this.pessoas[indice];
                  return ItemPessoa(pessoa);
                },
              );
              break;
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioPessoasAPI();
          })).then((pessoa) => this.pessoas.add(pessoa));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}