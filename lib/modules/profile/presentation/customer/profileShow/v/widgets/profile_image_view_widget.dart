import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImageViewWidget extends StatelessWidget {
  final String url;
  final bool wait;
  final Function() onTap;

  const ProfileImageViewWidget({
    Key? key,
    required this.url,
    required this.wait,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          // ignore: unnecessary_null_comparison
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.black,
                ),
              ),
            ),
            errorWidget: (context, url, error) => GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            height: 72,
            width: 72,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
