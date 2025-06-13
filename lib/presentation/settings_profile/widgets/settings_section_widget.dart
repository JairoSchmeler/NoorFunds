import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: _buildChildrenWithDividers(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    List<Widget> result = [];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);

      // Add divider after each child except the last one
      if (i < children.length - 1) {
        result.add(Divider(
          height: 1,
          thickness: 1,
          indent: 72,
          endIndent: 0,
          color: Colors.grey.withAlpha(26),
        ));
      }
    }
    return result;
  }
}
