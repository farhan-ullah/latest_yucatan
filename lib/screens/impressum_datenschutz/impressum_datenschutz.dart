import 'package:yucatan/screens/notifications/notification_view.dart';
import 'package:yucatan/services/common_service.dart';
import 'package:yucatan/services/response/legal_docwebpage_response.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:ui' as ui;
import 'dart:html';

class ImpressumDatenschutz extends StatefulWidget {
  static const String route = '/impressum_datenschutz';
  final bool isComingFromCheckOut;
  final WebViewValues webViewValues;

  ImpressumDatenschutz(
      {this.isComingFromCheckOut = false,
      this.webViewValues = WebViewValues.IMPRINT});

  @override
  _ImpressumDatenschutzState createState() {
    return _ImpressumDatenschutzState();
  }
}

class _ImpressumDatenschutzState extends State<ImpressumDatenschutz> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  WebViewValues? _currentWebViewValue;

  List<String> webPages = [
    "https://myappventure.de",
    "https://myappventure.de",
    "https://myappventure.de",
    "https://myappventure.de"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isComingFromCheckOut) {
      _currentWebViewValue = widget.webViewValues;
    } else {
      _currentWebViewValue = WebViewValues.IMPRINT;
    }
    CommonService.getLegalDocWebPageUrl().then((value) {
      LegalDocWebPageResponse legalDocWebPageResponse = value!;
      webPages[0] = legalDocWebPageResponse.data!.imprint!;
      webPages[1] = legalDocWebPageResponse.data!.tos!;
      webPages[2] = legalDocWebPageResponse.data!.privacy!;
      webPages[3] = legalDocWebPageResponse.data!.rightOfWithdrawal!;
    });
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'hello-world-html',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'https://www.myappventure.de/impressum'
          ..style.border = 'none');
          
    // ignore: undefined_prefixed_name
     ui.platformViewRegistry.registerViewFactory(
        'hello-world-html1',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'https://www.myappventure.de/agbs'
          ..style.border = 'none');

    // ignore: undefined_prefixed_name
       ui.platformViewRegistry.registerViewFactory(
        'hello-world-html2',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'https://www.myappventure.de/datenschutzrichtlinien'
          ..style.border = 'none');



    // ignore: undefined_prefixed_name
           ui.platformViewRegistry.registerViewFactory(
        'hello-world-html3',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'https://www.myappventure.de/widerrufsbelehrung'
          ..style.border = 'none');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Impressum & Datenschutz"),
          backgroundColor:
              Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
          actions: [
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, Dimensions.getScaledSize(15.0), 0),
                child: NotificationView(
                  negativePadding: false,
                )),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.getScaledSize(22.0),
                  left: Dimensions.getScaledSize(10.0),
                  bottom: Dimensions.getScaledSize(10.0),
                  right: Dimensions.getScaledSize(10.0)),
              child: Center(
                child: Container(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Provider.of<ThemeModel>(context,
                                                listen: true)
                                            .primaryMainColor,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              Dimensions.getScaledSize(8.0)))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: getTabButton("Impressum",
                                              WebViewValues.IMPRINT)),
                                      Expanded(
                                          child: getTabButton(
                                              "AGB", WebViewValues.TOS)),
                                      Expanded(
                                          child: getTabButton("Datenschutz",
                                              WebViewValues.PRIVACY)),
                                      Expanded(
                                          child: getTabButton("Widerruf",
                                              WebViewValues.RIGHTOFWITHDRAWAL)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.getScaledSize(10.0),
                      right: Dimensions.getScaledSize(10.0)),
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: _currentWebViewValue == WebViewValues.IMPRINT ?
                  HtmlElementView(viewType: 'hello-world-html'): _currentWebViewValue == WebViewValues.TOS ?
                  HtmlElementView(viewType: 'hello-world-html1'): _currentWebViewValue == WebViewValues.PRIVACY ?
                  HtmlElementView(viewType: 'hello-world-html2'):HtmlElementView(viewType: 'hello-world-html3')
                  //  InAppWebView(
                  //   key: webViewKey,
                  //   initialUrlRequest: URLRequest(
                  //       url: Uri.parse(getViews(_currentWebViewValue!))),
                  //   initialOptions: InAppWebViewGroupOptions(),
                  //   onWebViewCreated: (InAppWebViewController controller) {
                  //     webViewController = controller;
                  //   },
                  //   onLoadStart: (
                  //     InAppWebViewController? controller,
                  //     Uri? url,
                  //   ) {},
                  //   onUpdateVisitedHistory: (_, Uri? uri, __) {},
                  // ),
                  ),
            ),
            SizedBox(height: Dimensions.getScaledSize(12)),
          ],
        ),
      ),
    );
  }

  getTabButton(String text, WebViewValues value) {
    bool isSelected = _currentWebViewValue == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentWebViewValue = value;
        });
        webViewController!.loadUrl(
            urlRequest:
                URLRequest(url: Uri.parse(getViews(_currentWebViewValue!))));
      },
      child: Container(
        height: Dimensions.getScaledSize(36.0),
        decoration: BoxDecoration(
            color: isSelected ? CustomTheme.primaryColorDark : Colors.white,
            border: Border.all(
                width: 0,
                color:
                    isSelected ? CustomTheme.primaryColorDark : Colors.white),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.getScaledSize(6)))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
              fontSize: Dimensions.getScaledSize(10.0),
              fontWeight: FontWeight.w300,
              fontFamily: CustomTheme.fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  getViews(WebViewValues value) {
    switch (value) {
      case WebViewValues.IMPRINT:
        return webPages[0];
        break;
      case WebViewValues.TOS:
        return webPages[1];
        break;
      case WebViewValues.PRIVACY:
        return webPages[2];
        break;
      case WebViewValues.RIGHTOFWITHDRAWAL:
        return webPages[3];
        break;
    }
  }
}

enum WebViewValues {
  TOS,
  PRIVACY,
  IMPRINT,
  RIGHTOFWITHDRAWAL,
}
