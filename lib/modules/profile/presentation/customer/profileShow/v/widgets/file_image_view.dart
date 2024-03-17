import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileImageView extends StatelessWidget {
  final XFile imageFile;
  final bool wait;
  final Function() onTap;

  const FileImageView({
    Key? key,
    required this.imageFile,
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
          child: Container(
            height: 72,
            width: 72,
            color: Colors.transparent,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageFile.path),
                    height: 72,
                    width: 72,
                    fit: BoxFit.cover,
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 5),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                  ),
                ),
                !wait
                    ? Container()
                    : Container(
                        color: Colors.grey.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
