import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

const _accent = Color(0xFF6C5CE7);

class Day26MathExpressions extends StatefulWidget {
  const Day26MathExpressions({super.key});

  @override
  State<Day26MathExpressions> createState() => _Day26MathExpressionsState();
}

class _Day26MathExpressionsState extends State<Day26MathExpressions> {
  final _controller = TextEditingController();
  String _result = '0';
  bool _hasError = false;

  static const List<String> _quickInserts = ['+', '-', '×', '÷', '(', ')', '.'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The original called exp.evaluate(...) with no try/catch — typing
  // anything malformed (like "2+" or "2++2") would throw and crash the
  // whole widget. Wrapped in a try/catch so invalid input just shows a
  // friendly error message instead.
  void _evaluate() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = '0';
        _hasError = false;
      });
      return;
    }

    try {
      final sanitized = input.replaceAll('×', '*').replaceAll('÷', '/');
      final parser = GrammarParser();
      final expression = parser.parse(sanitized);
      final contextModel = ContextModel();
      // Expression.evaluate() is deprecated — the package now uses a
      // typed evaluator per result kind (RealEvaluator, IntervalEvaluator,
      // VectorEvaluator) instead of a single dynamic evaluate() call.
      final evaluator = RealEvaluator(contextModel);
      final value = evaluator.evaluate(expression);
      setState(() {
        _result = _formatResult(value.toDouble());
        _hasError = false;
      });
    } catch (_) {
      setState(() {
        _result = 'Invalid expression';
        _hasError = true;
      });
    }
  }

  String _formatResult(double value) {
    // Trim trailing ".0" for whole numbers, e.g. "9.0" -> "9".
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  // Clears the input field AND the result together — the original had
  // "Clear" only reset the answer text while leaving stale text in the
  // field, which was confusing.
  void _reset() {
    _controller.clear();
    setState(() {
      _result = '0';
      _hasError = false;
    });
  }

  void _insert(String value) {
    final text = _controller.text;
    final selection = _controller.selection;
    final cursor = selection.start < 0 ? text.length : selection.start;
    final newText = text.replaceRange(cursor, cursor, value);
    _controller
      ..text = newText
      ..selection = TextSelection.collapsed(offset: cursor + value.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 26 - Math Expressions',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'math_expressions parses and evaluates math strings like '
                '"1+2-4*3" at runtime — handy for calculators, spreadsheets, '
                'or user-defined formulas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Input field ────────────────────────────────────────
            TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'e.g. 1 + 2 * 3',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: _reset,
                  icon: const Icon(Icons.clear_rounded),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _evaluate(),
            ),

            const SizedBox(height: 12),

            // ── Quick operator inserts ────────────────────────────
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _quickInserts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final op = _quickInserts[index];
                  return OutlinedButton(
                    onPressed: () => _insert(op),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _accent,
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      op,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // ── Result ─────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _hasError ? Colors.red.withValues(alpha: 0.08) : _accent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(
                    _hasError ? 'ERROR' : 'RESULT',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: _hasError ? Colors.red : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _hasError ? 18 : 32,
                      fontWeight: FontWeight.w700,
                      color: _hasError ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Buttons ────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _evaluate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Evaluate',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
