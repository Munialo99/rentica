import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/contact_data.dart';
import 'package:rentica/base/data/mock%20data/faq_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/screens/profile/widgets/contact_option_tile.dart'; // Import Contact data

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(AppIcons.arrowBack, color: AppStyles.textBlack),
        ),
        title: Text(
          'Help Center',
          style: TextStyle(
            color: AppStyles.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), // Adjust height for tabs
          child: Column(
            children: [
              // Removed search bar as it's not in the latest image context,
              // but you can re-add it here if needed.
              TabBar(
                controller: _tabController,
                indicatorColor: AppStyles.primaryColor,
                labelColor: AppStyles.primaryColor,
                unselectedLabelColor: AppStyles.textGrey,
                labelStyle: AppStyles.textStyle.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: AppStyles.textStyle.copyWith(fontWeight: FontWeight.normal),
                tabs: const [
                  Tab(text: 'FAQ'),
                  Tab(text: 'Contact Us'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // FAQ Tab Content
          _buildFaqContent(),
          // Contact Us Tab Content
          _buildContactUsContent(),
        ],
      ),
    );
  }

  Widget _buildFaqContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: faqData.map((faqItem) {
            return ContactOptionTile(
              icon: AppIcons.helpOutline,
              title: faqItem['question']!,
              content: faqItem['answer']!,
              contentType: 'text',
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContactUsContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: contactOptionsData.map((option) {
            IconData iconData;
            switch (option['icon']) {
              case 'customerService':
                iconData = AppIcons.customerService;
                break;
              case 'whatsapp':
                iconData = AppIcons.whatsapp;
                break;
              case 'website':
                iconData = AppIcons.website;
                break;
              case 'facebook':
                iconData = AppIcons.facebook;
                break;
              case 'twitter':
                iconData = AppIcons.twitter;
                break;
              case 'instagram':
                iconData = AppIcons.instagram;
                break;
              default:
                iconData = Icons.help_outline;
            }
      
            return ContactOptionTile(
              icon: iconData,
              title: option['title']!,
              content: option['content']!,
              contentType: option['type']!,
              url: option['url'],
              //initiallyExpanded: option['title'] == 'WhatsApp',
            );
          }).toList(),
      
        ),
      ),
    );
  }
}