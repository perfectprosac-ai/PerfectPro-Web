import 'dart:convert';
import 'package:http/http.dart' as http;

class ElasticService {
  // Este é o endereço exclusivo que criamos para o seu projeto
  static const String _url = 'https://onrender.com';

  static Future<void> enviarTeste() async {
    try {
      print('⏳ Acordando o servidor Render... aguarde.');
      
      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mensagem": "Teste de iniciante com sucesso!",
          "usuario": "PerfectProAdmin",
          "data_envio": DateTime.now().toIso8601String()
        }),
      );

      if (response.statusCode == 200) {
        print('✅ SUCESSO: O dado chegou no Elastic!');
        print('ID do registro: ${jsonDecode(response.body)['id']}');
      } else {
        print('❌ ERRO DO SERVIDOR: ${response.statusCode}');
      }
    } catch (e) {
      print('🚨 ERRO DE CONEXÃO: Verifique se você tem internet ou se o link está certo.');
      print('Detalhe do erro: $e');
    }
  }
}
