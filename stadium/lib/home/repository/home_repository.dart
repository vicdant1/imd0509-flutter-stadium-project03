import 'package:dio/dio.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/models/jogadores.dart';
import 'package:stadium/utils/constants.dart';

class HomeRepository {
  final Dio dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
  ));

  Future postClube(Clubes clube) async {
    try {
      final response = await dio.post(
        '/clubes/.json',
        data: clube.toJson(),
      );
      return response.data;
    } catch (e) {
      // Handle error
    }
  }

  Future getClubes() async {
    try {
      final response = await dio.get('/clubes/.json');
      List<Clubes> clubes = [];
      if (response.data != null) {
        response.data.forEach((key, value) {
          clubes.add(Clubes.fromJson(value));
          clubes.last.id = key;
        });
      }
      return clubes;
    } catch (e) {
      // Handle error
    }
  }

  Future postJogador(List<Jogador> jogador, String id) async {
    try {
      await dio.patch('/clubes/$id/.json', data: {
        'jogadores': jogador.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      // Handle error
    }
  }

  Future postEstadio(Estadios estadio) async {
    try {
      await dio.patch('/estadios/.json', data: {
        estadio.nome: estadio.toJson(),
      });
    } catch (e) {
      // Handle error
    }
  }

  Future getEstadios() async {
    try {
      final response = await dio.get('/estadios/.json');
      List<Estadios> estadios = [];
      if (response.data != null) {
        response.data.forEach((key, value) {
          estadios.add(Estadios.fromJson(value));
        });
      }
      return estadios;
    } catch (e) {
      // Handle error
    }
  }

  Future getClubeById(String id) async {
    try {
      final response = await dio.get('/clubes/$id/.json');
      return Clubes.fromJson(response.data);
    } catch (e) {
      // Handle error
    }
  }

  Future deleteEstadio(String nome) async {
    try {
      return dio.delete('/estadios/$nome/.json');
    } catch (e) {
      // Handle error
    }
  }

  Future patchEstadio(String nome, Estadios estadio) async {
    try {
      return dio.patch('/estadios/.json', data: {
        estadio.nome: estadio.toJson(),
      });
    } catch (e) {
      // Handle error
    }
  }
}
