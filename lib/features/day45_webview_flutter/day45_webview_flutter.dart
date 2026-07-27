import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _accent = Color(0xFF6C5CE7);

class Day45WebviewFlutter extends StatefulWidget {
  const Day45WebviewFlutter({super.key});

  @override
  State<Day45WebviewFlutter> createState() => _Day45WebviewFlutterState();
}

class _Day45WebviewFlutterState extends State<Day45WebviewFlutter> {
  late final WebViewController _controller;

  bool _isLoading = true;
  bool _headerFooterHidden = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('Loading: $url');
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://amazon.com'));
  }

  /// Toggle the visibility of the webpage's header and footer.
  ///
  /// This demonstrates how to execute JavaScript inside a WebView.
  Future<void> _toggleHeaderFooter() async {
    if (_headerFooterHidden) {
      // Show header & footer
      await _controller.runJavaScript("""
        document.querySelector('header')?.style.removeProperty('display');
        document.querySelector('footer')?.style.removeProperty('display');
      """);
    } else {
      // Hide header & footer
      await _controller.runJavaScript("""
        document.querySelector('header')?.style.setProperty('display', 'none');
        document.querySelector('footer')?.style.setProperty('display', 'none');
      """);
    }

    setState(() {
      _headerFooterHidden = !_headerFooterHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 45 · WebView',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              }
            },
          ),
          IconButton(
            tooltip: 'Forward',
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              }
            },
          ),
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: _accent)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _accent,
        tooltip: _headerFooterHidden
            ? 'Show Header & Footer'
            : 'Hide Header & Footer',
        onPressed: _toggleHeaderFooter,
        child: Icon(
          _headerFooterHidden
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
