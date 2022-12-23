import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controllers/url_shortner_controller.dart';

class UrlShortenerScreen extends StatelessWidget {
  const UrlShortenerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<UrlShortnerController>(context, listen: true);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "URL Shortner",
              style: TextStyle(
                fontSize: 42,
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Shorten your long URL quickly",
              style: TextStyle(
                color: Colors.grey,
                fontSize: kDefaultPadding,
              ),
            ),
            const SizedBox(height: 20 * 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: TextFormField(
                controller: controller.urlController,
                onChanged: (value) {
                  final String text = controller.urlController.text;
                  controller.urlController.value =
                      controller.urlController.value.copyWith(
                    text: text,
                    selection: TextSelection(
                      baseOffset: text.length,
                      extentOffset: text.length,
                    ),
                    composing: TextRange.empty,
                  );
                  controller.notifyListeners();
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "Paste your long URL here",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.link,
                    color: Colors.grey,
                  ),
                  suffixIcon: controller.urlController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            controller.urlController.clear();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 30),
            controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.result == null
                    ? const Text(
                        "Shorten your long URL quickly",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: kDefaultPadding,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              controller.result!,
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding),
                          GestureDetector(
                            child: const Icon(
                              Icons.copy,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: controller.result))
                                  .whenComplete(
                                () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Copied to Clipboard"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
            const SizedBox(height: 50 * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    controller.getShortLink();
                  },
                  child: const Text("Shorten URL",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: kDefaultPadding,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
