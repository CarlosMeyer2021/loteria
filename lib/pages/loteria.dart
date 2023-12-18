import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loteria/pages/busca_jogo.dart';

class Loteria extends StatefulWidget {
  const Loteria({super.key});

  @override
  State<Loteria> createState() => _LoteriaState();
}

class _LoteriaState extends State<Loteria> {
  late Future<List<BuscaJogo>> jogos;

  @override
  void initState() {
    super.initState();

    jogos = pesquisaJogo();
  }

  Future<List<BuscaJogo>> pesquisaJogo() async {
    var url =
        'https://apiloterias.com.br/app/v2/resultado?loteria=megasena&token=kJdfLjd38Jai2ek';
    //var url = 'https://apiloterias.com.br/app/v2/resultado?loteria=megasena&token=kJdfLjd38Jai2ek';
    var jogoResponse = await http.get(Uri.parse(url));
    
    if (jogoResponse.statusCode == 200) {
      print(jogoResponse);
      //List <dynamic>listJsonResponse = json.decode(jogoResponse.body);
      List listaDeJogo = jsonDecode(jogoResponse.body);
      print(listaDeJogo);
      //return listJsonResponse.map((dynamic jogo) => BuscaJogo.fromJson(jogo)).toList();
      return listaDeJogo.map((json) => BuscaJogo.fromJson(json)).toList();
    } else {
      print('Erro ao buscar dados');
      throw Exception('Deu ruim');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Loteria',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        )),
      ),
      body: Center(
        child: FutureBuilder<List<BuscaJogo>>(
          future: jogos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  BuscaJogo jogos = snapshot.data![index];
                  return ListTile(
                    title: Text(jogos.nome),
                  );
                },
              );
            } else if (snapshot.hasError) {
              Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
