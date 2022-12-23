import 'package:flutter/material.dart';
import '../services/network_service.dart';

class UrlShortnerController extends ChangeNotifier {
  final TextEditingController urlController = TextEditingController();

  final UrlShortenerService urlShortenerService = UrlShortenerService();

  bool isLoading = false;
  String? result;

  Future<void> getShortLink() async {
    isLoading = true;
    notifyListeners();
    var shortUrl = await urlShortenerService.postShortLink(urlController.text);

    result = shortUrl.resultUrl;
    isLoading = false;

    notifyListeners();
  }
}
