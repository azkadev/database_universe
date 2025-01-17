import 'package:example/core/flutter/client/client.dart';
import 'package:flutter/material.dart';
import 'package:general_framework/flutter/flutter.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';

///
class ThreadsPage extends ExampleClientFlutterAppStatefulWidget {
  ///
  const ThreadsPage({super.key, required super.generalFrameworkClientFlutter});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage>
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
    await Future(() async {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
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
      leading: CircleAvatar(),
      title: title,
      trailing: Icon(Icons.send_outlined),
      onTap: onTap,
    );
  }
}
