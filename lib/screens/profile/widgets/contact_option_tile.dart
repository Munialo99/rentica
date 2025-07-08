import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';
// You might need url_launcher for opening links
// import 'package:url_launcher/url_launcher.dart';

class ContactOptionTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content; // Changed to String as content is now text
  final String contentType; // e.g., 'text', 'whatsapp', 'url'
  final String? url; // Optional URL for 'url' and 'whatsapp' types
  final bool initiallyExpanded;

  const ContactOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.content, // Now required
    this.contentType = 'text', // Default content type
    this.url,
    this.initiallyExpanded = false,
  });

  @override
  State<ContactOptionTile> createState() => _ContactOptionTileState();
}

class _ContactOptionTileState extends State<ContactOptionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  // Function to handle opening URLs/WhatsApp
  // Future<void> _launchUrl(String urlString) async {
  //   final Uri uri = Uri.parse(urlString);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Could not launch $urlString')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget expandedContentWidget;

    // Build content based on contentType
    switch (widget.contentType) {
      case 'whatsapp':
        expandedContentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.content,
              style: AppStyles.textStyle2.copyWith(color: AppStyles.textDarkGrey),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement opening WhatsApp (requires url_launcher)
                // _launchUrl('whatsapp://send?phone=${widget.url ?? widget.content}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Open WhatsApp with number')),
                );
              },
              child: Text(
                'Chat on WhatsApp',
                style: AppStyles.textStyle2.copyWith(color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
        break;
      case 'url':
        expandedContentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.content,
              style: AppStyles.textStyle2.copyWith(color: AppStyles.textDarkGrey),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement opening URL (requires url_launcher)
                // if (widget.url != null) _launchUrl(widget.url!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Open URL: ${widget.url ?? widget.content}')),
                );
              },
              child: Text(
                'Go to Website', // Or 'Go to Facebook', etc.
                style: AppStyles.textStyle2.copyWith(color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
        break;
      case 'text':
      default:
        expandedContentWidget = Text(
          widget.content,
          style: AppStyles.textStyle2.copyWith(color: AppStyles.textDarkGrey),
        );
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric( vertical: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppStyles.bgColor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(widget.icon, color: AppStyles.primaryColor),
            title: Text(
              widget.title,
              style: AppStyles.textStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppStyles.textBlack,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppStyles.textGrey,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 55.0, right: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: expandedContentWidget,
              ),
            ),
        ],
      ),
    );
  }
}