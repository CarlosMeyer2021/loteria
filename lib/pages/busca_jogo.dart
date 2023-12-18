

import 'dart:convert';

class BuscaJogo {
  late String nome;
  late int numeroConcurso;
  late String dataConcurso;
  late String localRealizacao;
  late bool acumulou;
  late List dezenas;

  BuscaJogo({
    required this.nome,
    required this.numeroConcurso,
    required this.dataConcurso,
    required this.localRealizacao,
    required this.acumulou,
    required this.dezenas,
  });

  BuscaJogo.fromJson(Map<String, dynamic> json){
    nome = json['nome'];
    numeroConcurso = json['numeroConcurso'];
    dataConcurso = json['dataConcurso'];
    localRealizacao = json['localRealizacao'];
    acumulou = json['acumulou'];
    dezenas = json['dezenas'];
  }

  Map<String, dynamic> toMap(){
    return {
      'nome': nome,
      'numeroConcurso': numeroConcurso,
      'dataConcurso': dataConcurso,
      'localRealizacao': localRealizacao,
      'acumulou': acumulou,
      'dezenas': dezenas,
    };
  }

    String toJson() => jsonEncode(toMap());
}
