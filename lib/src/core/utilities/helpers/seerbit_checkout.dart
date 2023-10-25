import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xendly_mobile/src/config/routes.dart';

Future<String> seerbitCheckout(BuildContext ctx, SeerbitData data) async {
  if (num.tryParse(data.amount) == null) {
    return 'Enter a valid amount';
  }
  final result = await showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            // width: MediaQuery.of(context).size.width * 0.8,
            child: SeerBitCheckoutScreen(
              params: data,
            ),
          ),
        ),
      );
    },
  );
  return result;
}

class SeerbitData {
  final String publicKey;
  final String currency;
  final String reference;
  final String country;
  final String email;
  final String amount;
  final String? fullName;
  final String? logo;
  final String? callbackurl;

  SeerbitData({
    required this.publicKey,
    required this.reference,
    required this.email,
    required this.amount,
    required this.currency,
    this.logo,
    this.callbackurl,
    this.fullName,
    this.country = 'NG',
  });

  factory SeerbitData.fromMap(Map<String, dynamic> data) {
    return SeerbitData(
      publicKey: data[''],
      email: '',
      reference: '',
      amount: '',
      currency: '',
    );
  }
}

class SeerBitCheckoutScreen extends StatefulWidget {
  const SeerBitCheckoutScreen({Key? key, required this.params})
      : super(key: key);
  final SeerbitData params;

  @override
  State<SeerBitCheckoutScreen> createState() => _SeerBitCheckoutScreenState();
}

class _SeerBitCheckoutScreenState extends State<SeerBitCheckoutScreen> {
  late final String html = '''
    <html>
      <head>
        <title>SeerBit Simple Checkout</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://checkout.seerbitapi.com/api/v2/seerbit.js"></script>
      </head>
      <body onload="paywithSeerbit()">
        <!-- <button onclick="paywithSeerbit()">Pay Now</button> -->

        <script type="text/javascript">
        window.defaultStatus = 'My Popup Window';
          function paywithSeerbit() {
            SeerbitPay ({
              //replace with your public key
              "public_key": "${widget.params.publicKey}",
              "tranref": "${widget.params.reference}",
              "currency": "${widget.params.currency}",
              "country": "${widget.params.country}",
              "amount": "${widget.params.amount}",
              "email": "${widget.params.email}",
              //optional field. Set to true to allow customer set the amount
              "setAmountByCustomer": false,
              "full_name": "${widget.params.fullName}", //optional
              "tokenize" : false, // set to true to allow token capture
              "callbackurl": "http://yourdomain.com",
              customization: {
                theme: {
                  border_color: "0000",
                  background_color: "ECECEC",
                  button_color: "000",
                }, 
                payment_method: ["card"],
                confetti: true,
                logo: "https://res.cloudinary.com/geekcloud/image/upload/v1656626786/xendly/xendly_header_k7tkwg.png",
                }     
            },
            function callback(response, closeModal) {
             onSeerBitTransactionComplete.postMessage(JSON.stringify(response));
            //  onSeerBitTransactionComplete.postMessage(JSON.stringify(response));
              // send response to Flutter app
              // window.flutter_inappwebview.callHandler('onSeerBitTransactionComplete', response);
            },
            function close(close) {
              // send close event to Flutter app
             onSeerBitTransactionClose.postMessage("close");
              // window.flutter_inappwebview.callHandler('onSeerBitTransactionClose', close);
            })
          }
        </script>

      </body>
    </html>
  ''';

  late final WebViewController _webViewController = WebViewController()
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
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..addJavaScriptChannel(
      // JavaScriptChannel(
      'onSeerBitTransactionComplete',
      onMessageReceived: (JavaScriptMessage message) {
        String response = message.message;
        if (kDebugMode) {
          print('Complete: $response');
        }
        // handle transaction complete event here
        Navigator.popAndPushNamed(context, home);
      },
      // ),
    )
    ..addJavaScriptChannel(
      'onSeerBitTransactionClose',
      onMessageReceived: (JavaScriptMessage message) {
        String response = message.message;
        Navigator.pop(context, 'cancelled');
        if (kDebugMode) {
          print('Close: $response');
        }
        // handle transaction close event here
        Navigator.popAndPushNamed(context, home);
      },
    )
    ..loadHtmlString(html);

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _webViewController);
  }

  void setupJavascriptChannels() {
    _webViewController.addJavaScriptChannel(
      // JavaScriptChannel(
      'onSeerBitTransactionComplete',
      onMessageReceived: (JavaScriptMessage message) {
        // String response = message.message;
        // handle transaction complete event here
      },
      // ),
    );

    _webViewController.addJavaScriptChannel(
      'onSeerBitTransactionClose',
      onMessageReceived: (JavaScriptMessage message) {
        // String response = message.message;
        // handle transaction close event here
      },
    );
  }
}
