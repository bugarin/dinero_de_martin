import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _apiKey =
      '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';
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getHistoriaDinero(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text':
                      'Por favor, analiza esta imagen de un billete y proporciona una descripción detallada de su historia, incluyendo el período histórico, el contexto económico y cualquier detalle cultural relevante. Sé específico y detallado en tu respuesta.'
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': imageUrl,
                  }
                }
              ]
            }
          ],
          'max_tokens': 1000
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get banknote history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting banknote history: $e');
    }
  }
}
