import 'package:example/core/flutter/client/client.dart';
import 'package:example/page/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:general_framework/flutter/flutter.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';

///
class HomePage extends ExampleClientFlutterAppStatefulWidget {
  ///
  const HomePage({super.key, required super.generalFrameworkClientFlutter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with GeneralLibFlutterStatefulWidget {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ensureInitialized();
      await refresh();
    });
  }

  @override
  Future<void> refresh() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future(() async {
      await Future.delayed(Duration(seconds: 2));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SkeletonizerGeneralFramework(
          enabled: isLoading,
          child: Text("Example Database Universe"),
        ),
        actions: [
          widget.generalFrameworkClientFlutter.themeChangeWidget(
            context: context,
            pageState: this,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: context.height,
              minWidth: context.width,
            ),
            child: Column(
              children: [
                contentWidget(
                  context: context,
                  title: "Chat",
                  onTap: () {
                    handleFunction(
                      onFunction: (context, statefulWidget) {
                        context
                            .navigator()
                            .push(MaterialPageRoute(builder: (context) {
                          return ChatPage(
                              generalFrameworkClientFlutter:
                                  widget.generalFrameworkClientFlutter);
                        }));
                      },
                    );
                  },
                ),
                contentWidget(
                  context: context,
                  title: "Threads",
                  onTap: () {
                    handleFunction(
                      onFunction: (context, statefulWidget) {
                        context
                            .navigator()
                            .push(MaterialPageRoute(builder: (context) {
                          return ChatPage(
                              generalFrameworkClientFlutter:
                                  widget.generalFrameworkClientFlutter);
                        }));
                      },
                    );
                  },
                ),
                SizedBox(
                  height: context.mediaQueryData.padding.bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contentWidget({
    required BuildContext context,
    required String title,
    void Function()? onTap,
  }) {
    return MenuContainerGeneralFrameworkWidget.lisTile(
      context: context,
      contentPadding: EdgeInsets.all(10),
      isLoading: isLoading,
      leading: Skeleton.leaf(child: CircleAvatar()),
      title: title,
      trailing: Icon(Icons.send_outlined),
      onTap: onTap,
    );
  }
}
