import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ProjectDetails extends StatefulWidget {
  final String url;
  const ProjectDetails({super.key, required this.url});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  bool progressVisibility = true;
  late WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.url);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {
            setState(() {
              progressVisibility = false;
            });
          },

          onWebResourceError: (WebResourceError error) {
            print(error);
          },

          onNavigationRequest: (NavigationRequest request) {
            print('Navigation:'+request.url.toString());
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
        backgroundColor: Color(0xff031a38),
      ),
      body: SafeArea(
          child:Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            //padding: EdgeInsets.symmetric(horizontal: 20),
            child: WebViewWidget(
              controller: controller,
            ),
          ),
      ),
    );
  }
}
