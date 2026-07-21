import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const _accent = Color(0xFF6C5CE7);

class Day18RflutterAlert extends StatelessWidget {
  const Day18RflutterAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = <Map<String, dynamic>>[
      {
        'icon': Icons.info_outline_rounded,
        'title': 'Basic Alert',
        'subtitle': 'The simplest way to show a message',
        'onTap': () => _showBasicAlert(context),
      },
      {
        'icon': Icons.error_outline_rounded,
        'title': 'Alert with Button',
        'subtitle': 'A single confirm action',
        'onTap': () => _showSingleButtonAlert(context),
      },
      {
        'icon': Icons.warning_amber_rounded,
        'title': 'Alert with Buttons',
        'subtitle': 'Two custom-styled actions',
        'onTap': () => _showMultiButtonAlert(context),
      },
      {
        'icon': Icons.brush_rounded,
        'title': 'Alert with Style',
        'subtitle': 'Custom animation, border, and colors',
        'onTap': () => _showStyledAlert(context),
      },
      {
        'icon': Icons.check_circle_outline_rounded,
        'title': 'Alert with Custom Icon',
        'subtitle': 'Swap the default icon for any widget',
        'onTap': () => _showCustomIconAlert(context),
      },
      {
        'icon': Icons.login_rounded,
        'title': 'Alert with Custom Content',
        'subtitle': 'Embed a form inside the dialog',
        'onTap': () => _showCustomContentAlert(context),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 18 · RFlutter Alert',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
              'rflutter_alert makes it easy to show styled dialogs — '
              'success, error, warning, and fully custom layouts — with '
              'built-in animations. Tap any option below to try it.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(actions.length, (index) {
            final action = actions[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == actions.length - 1 ? 0 : 12,
              ),
              child: _ActionTile(
                icon: action['icon'] as IconData,
                title: action['title'] as String,
                subtitle: action['subtitle'] as String,
                onTap: action['onTap'] as VoidCallback,
              ),
            );
          }),
        ],
      ),
    );
  }

  // The easiest way to show an RFlutter Alert.
  void _showBasicAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'RFLUTTER ALERT',
      desc: 'Flutter is more awesome with RFlutter Alert.',
    ).show();
  }

  // Alert with a single button.
  void _showSingleButtonAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: 'RFLUTTER ALERT',
      desc: 'Flutter is more awesome with RFlutter Alert.',
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            'COOL',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  // Alert with multiple, custom-styled buttons.
  void _showMultiButtonAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'RFLUTTER ALERT',
      desc: 'Flutter is more awesome with RFlutter Alert.',
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            'FLAT',
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0),
            ],
          ),
          child: const Text(
            'GRADIENT',
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
        ),
      ],
    ).show();
  }

  // Advanced use: a reusable, fully custom alert style.
  void _showStyledAlert(BuildContext context) {
    final alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: _accent),
      ),
      titleStyle: const TextStyle(color: _accent),
    );

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: 'RFLUTTER ALERT',
      desc: 'Flutter is more awesome with RFlutter Alert.',
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: _accent,
          radius: BorderRadius.circular(10.0),
          child: const Text(
            'COOL',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  // The original used Image.asset(...) with a bundled asset that isn't
  // available here — swapped for a plain widget (an icon) to show the
  // same `image:` slot works with any widget, not just Image.asset.
  void _showCustomIconAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'RFLUTTER ALERT',
      desc: 'Flutter is more awesome with RFlutter Alert.',
      image: const Icon(Icons.celebration_rounded, color: _accent, size: 64),
    ).show();
  }

  // Alert with fully custom content (a small login form).
  void _showCustomContentAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'LOGIN',
      content: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: _accent,
          child: const Text(
            'LOGIN',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: _accent, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
