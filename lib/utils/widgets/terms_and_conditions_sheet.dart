import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsSheet extends StatefulWidget {
  final String htmlContent;

  const TermsAndConditionsSheet({Key? key, required this.htmlContent}) : super(key: key);

  static Future<bool?> show(BuildContext context, String htmlContent) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => TermsAndConditionsSheet(htmlContent: htmlContent),
    );
  }

  @override
  _TermsAndConditionsSheetState createState() => _TermsAndConditionsSheetState();
}

class _TermsAndConditionsSheetState extends State<TermsAndConditionsSheet> {
  late WebViewController _controller;
  bool _canAccept = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadHtmlString(widget.htmlContent)
      ..addJavaScriptChannel(
        'ScrollListener',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'bottom') {
            setState(() => _canAccept = true);
          }
        },
      )
      ..loadHtmlString(_injectScrollListener(widget.htmlContent));
    ;
  }

  String _injectScrollListener(String htmlContent) {
    return '''
    <html>
      <head>
        <script>
          function sendScrollEvent() {
            var scrollTop = window.scrollY || document.documentElement.scrollTop;
            var scrollHeight = document.documentElement.scrollHeight;
            var clientHeight = document.documentElement.clientHeight;
            
            if (scrollTop + clientHeight >= scrollHeight - 10) {
              ScrollListener.postMessage('bottom');
            }
          }
          
          window.addEventListener('scroll', sendScrollEvent);
        </script>
      </head>
      <body style="margin: 0; padding: 0;">
        $htmlContent
      </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Terms and Conditions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // WebView for displaying HTML
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),

            // Accept & Decline buttons (appear only after scrolling)
            if (_canAccept)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("Decline", style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text("Accept"),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
