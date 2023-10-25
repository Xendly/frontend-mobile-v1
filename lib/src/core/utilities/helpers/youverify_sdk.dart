import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<String> youVerifyVForm(BuildContext ctx, YouverifyVformData data) async {
  final result = await showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.zero,
          // child: SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            // width: MediaQuery.of(context).size.width * 0.8,
            child: YouverifyVerificationScreen(
              params: data,
            ),
            // ),
          ),
        ),
      );
    },
  );
  return result;
}

class YouverifyVformData {
  final String publicUrl;
  final String email;

  YouverifyVformData({
    required this.email,
    required this.publicUrl,
  });

  factory YouverifyVformData.fromMap(Map<String, dynamic> data) {
    return YouverifyVformData(
      email: '',
      publicUrl: '',
    );
  }
}

class YouverifyVerificationScreen extends StatefulWidget {
  const YouverifyVerificationScreen({
    Key? key,
    required this.params,
  }) : super(key: key);
  final YouverifyVformData params;

  @override
  State<YouverifyVerificationScreen> createState() =>
      _YouverifyVerificationScreenState();
}

class _YouverifyVerificationScreenState
    extends State<YouverifyVerificationScreen> {
  late final WebViewController _webViewController = WebViewController(
    onPermissionRequest: (WebViewPermissionRequest request) {
      request.grant();
    },
  )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.endsWith('success')) {
            Navigator.pop(context, 'success');
          }
          if (request.url.endsWith('closed')) {
            Navigator.pop(context, 'closed');
          }
          return NavigationDecision.prevent;
        },
      ),
    )
    ..loadRequest(
      Uri.parse(
        '${widget.params.publicUrl}/verification?email=${widget.params.email}',
      ),
    );

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _webViewController);
  }
}
