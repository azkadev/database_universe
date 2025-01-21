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
import 'package:google_fonts/google_fonts.dart';

///
class PropertyBuilder extends StatefulWidget {
  ///
  const PropertyBuilder({
    required this.property,
    required this.type,
    super.key,
    this.bold = false,
    this.underline = false,
    this.value,
    this.children = const [],
  });

  ///
  final String property;

  ///
  final bool bold;

  ///
  final bool underline;

  ///
  final Widget? value;

  ///
  final String type;

  ///
  final List<Widget> children;

  @override
  State<PropertyBuilder> createState() => _PropertyBuilderState();
}

class _PropertyBuilderState extends State<PropertyBuilder> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: widget.children.isNotEmpty
              ? () => setState(() => _expanded = !_expanded)
              : null,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              children: [
                if (widget.children.isNotEmpty) ...[
                  AnimatedRotation(
                    turns: _expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_right,
                      size: 24,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 4),
                ] else
                  const SizedBox(width: 28),
                Tooltip(
                  message: widget.type,
                  child: Text(
                    '${widget.property}:',
                    style: GoogleFonts.jetBrainsMono(
                      fontWeight: widget.bold ? FontWeight.w800 : null,
                      color: theme.colorScheme.onPrimaryContainer,
                      decoration:
                          widget.underline ? TextDecoration.underline : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.value != null)
                  Expanded(child: widget.value!)
                else
                  Text(
                    widget.type,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer
                          .withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (_expanded && widget.children.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Column(children: widget.children),
            ),
          ),
      ],
    );
  }
}
