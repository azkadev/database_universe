/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
class InstanceSelector extends StatefulWidget {
  ///
  const InstanceSelector({
    required this.instances,
    required this.selectedInstance,
    required this.onSelected,
    super.key,
  });

  ///
  final List<String> instances;

  ///
  final String? selectedInstance;

  ///
  final void Function(String instance) onSelected;

  @override
  State<InstanceSelector> createState() => _InstanceSelectorState();
}

class _InstanceSelectorState extends State<InstanceSelector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    _animation.addStatusListener((AnimationStatus status) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              color: theme.colorScheme.secondaryContainer,
              child: SizeTransition(
                sizeFactor: _animation,
                axisAlignment: -1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    for (final instance in widget.instances)
                      if (instance != widget.selectedInstance)
                        InstanceButton(
                          instance: instance,
                          onTap: () {
                            widget.onSelected(instance);
                            _controller.reverse();
                          },
                        ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
            if (widget.selectedInstance != null)
              SelectedInstanceButton(
                instance: widget.selectedInstance!,
                hasMultiple: widget.instances.length > 1,
                color: _animation.status != AnimationStatus.dismissed
                    ? Colors.blue
                    : null,
                onTap: () {
                  if (_controller.status == AnimationStatus.completed) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}

///
class InstanceButton extends StatelessWidget {
  ///
  const InstanceButton({
    required this.instance,
    required this.onTap,
    super.key,
  });

  ///
  final String instance;

  ///
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                instance,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
class SelectedInstanceButton extends StatelessWidget {
  ///
  const SelectedInstanceButton({
    required this.instance,
    required this.onTap,
    required this.hasMultiple,
    required this.color,
    super.key,
  });

  ///
  final String instance;

  ///
  final VoidCallback onTap;

  ///
  final bool hasMultiple;

  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(10),
      color: theme.colorScheme.secondaryContainer,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: hasMultiple ? onTap : null,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.database,
                  size: 25,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      instance,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      'Isar Instance',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (hasMultiple)
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.chevronUp,
                        size: 12,
                      ),
                      Icon(
                        FontAwesomeIcons.chevronDown,
                        size: 12,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
