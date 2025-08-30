import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// #enddocregion platform_imports
class CustomWebViewAssetWidget extends StatefulWidget {
  final String assetFile;
  final String? title;
  final bool? showBack;

  const CustomWebViewAssetWidget({Key? key, required this.assetFile, this.title, this.showBack}) : super(key: key);

  @override
  State<CustomWebViewAssetWidget> createState() => _CustomWebViewAssetWidgetState();
}

class _CustomWebViewAssetWidgetState extends State<CustomWebViewAssetWidget> {
  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
  Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            //
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadFlutterAsset("assets/gdpr_consent.html");

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    webViewController = controller;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          16.height,
          Image.asset(
            AppImages.appLogoVertical,
            height: 40,
          ),
          16.height,
          WebViewWidget(controller: webViewController).expand(),
          Row(
            children: [
              AppButton(
                text: "Decline",
                onTap: () {
                  finish(context);
                },
                color: Colors.white,
                elevation: 0,
                textColor: Colors.red,
              ).expand(),
              16.width,
              Observer(
                builder: (context) {
                  return ButtonAppLoader(
                    isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.gdprConsentApiState].validate(),
                    child: AppButton(
                      text: "Accept",
                      color: Colors.white,
                      elevation: 0,
                      onTap: () async {
                        await personalDetailsStore.onGDPRConsentSubmit(true);
                      },
                      textColor: Colors.green,
                    ),
                  );
                },
              ).expand()
            ],
          ),
        ],
      ),
    );
  }
}
