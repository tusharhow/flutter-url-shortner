import 'package:dio/dio.dart';
import '../constants.dart';
import '../models/url_shortner_response_model.dart';

class UrlShortenerService {
  final Dio _dio = Dio();

  Future<UrlShortnerResponse> postShortLink(String longUrl) async {
    final response = await _dio.post(BASE_URL, data: {"url": longUrl});

    if (response.statusCode == 200) {
      final result = UrlShortnerResponse.fromJson(response.data);
      return result;
    } else {
      return UrlShortnerResponse(
        resultUrl: "Something went wrong..",
      );
    }
  }
}
