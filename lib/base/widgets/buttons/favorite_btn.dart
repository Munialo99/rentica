import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/providers/favorite_btn_provider.dart';

class FavoriteBtn extends ConsumerWidget {
  final void Function(bool isFavorited)? onChanged;
  final String id;

  const FavoriteBtn({
    super.key,
    required this.id,
    this.onChanged,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteBtnProvider.select((fav) => fav[id] ?? false));

    return GestureDetector( // Use GestureDetector for tap handling
      onTap: () {
        ref.read(favoriteBtnProvider.notifier).toggle(id);
        onChanged?.call(!isFavorited);
      },
      child: CircleAvatar(
        radius: 16,
        backgroundColor: AppStyles.whiteColor,
        child: Icon(
          isFavorited ? Icons.favorite : Icons.favorite_border,
          color: isFavorited ? AppStyles.primaryColor : AppStyles.primaryColor,
          size: 20, // Icon size
        ),
      ),
    );
  }
}
