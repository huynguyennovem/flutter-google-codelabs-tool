import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/data/local_data.dart';
import 'package:flutter_google_codelabs_tool/di/di.dart';
import 'package:flutter_google_codelabs_tool/ui/others/error_widget.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class GuidelineWidget extends StatefulWidget {
  const GuidelineWidget({Key? key}) : super(key: key);

  @override
  State<GuidelineWidget> createState() => _GuidelineWidgetState();
}

class _GuidelineWidgetState extends State<GuidelineWidget> {

  Future? _guidelineStringFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _guidelineStringFuture = getIt.get<LocalData>().getGuideline();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _guidelineStringFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              return Markdown(
                data: snapshot.data,
                selectable: true,
                onTapLink: (text, url, title) async {
                  if (url == null || url.isEmpty) return;
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    debugPrint('Can not launch $uri');
                  }
                },
              );
            default:
              if (snapshot.hasError) {
                return const CustomErrorWidget();
              }
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
