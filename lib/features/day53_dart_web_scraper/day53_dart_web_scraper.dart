import 'package:dart_web_scraper/dart_web_scraper.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day53DartWebScraper extends StatefulWidget {
  const Day53DartWebScraper({super.key});

  @override
  State<Day53DartWebScraper> createState() => _Day53DartWebScraperState();
}

class _Day53DartWebScraperState extends State<Day53DartWebScraper> {
  bool _isLoading = true;
  String? _quote;
  String? _author;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    final scraper = WebScraper();

    final result = await scraper.scrape(
      url: Uri.parse('https://quotes.toscrape.com'),
      scraperConfig: ScraperConfig(
        parsers: [
          Parser(
            id: 'quotes',
            parents: ['_root'],
            type: ParserType.element,
            selectors: ['.quote'],
            multiple: true,
          ),
          Parser(
            id: 'quote',
            parents: ['quotes'],
            type: ParserType.text,
            selectors: ['span.text'],
          ),
          Parser(
            id: 'author',
            parents: ['quotes'],
            type: ParserType.text,
            selectors: ['small.author'],
          ),
        ],
      ),
    );

    final quotes = result['quotes'] as List;

    final first = quotes.first as Map<String, dynamic>;

    setState(() {
      _quote = first['quote'];
      _author = first['author'];
      _isLoading = false;
    });

    debugPrint(result.toString());
  }

  Widget _card({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: _accent, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 15, height: 1.5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 53 - Dart Web Scraper',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: _accent))
            : _error != null
            ? Center(child: Text(_error!, textAlign: TextAlign.center))
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Text(
                      'dart_web_scraper extracts website data using reusable parser configurations and CSS selectors.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _card(title: 'Quote', value: _quote!),
                  const SizedBox(height: 20),
                  _card(title: 'Author', value: _author!),
                ],
              ),
      ),
    );
  }
}
