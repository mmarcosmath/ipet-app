import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';

class PhotosView extends StatelessWidget {
  List<Uint8List> images;

  PhotosView({
    Key? key,
    required this.images,
  }) : super(key: key);

  var controller = PageController();
  var index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PageView(
              controller: controller,
              onPageChanged: (index) {
                this.index.value = index;
              },
              children: [
                ...images.map(
                  (image) => GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          log("ATUALIZOU");
                          return InteractiveviewerGallery(
                            maxScale: 20,
                            sources: images,
                            onPageChanged: (index) {
                              this.index.value = index;
                              controller.jumpToPage(index);
                            },
                            initIndex: images.indexOf(image),
                            itemBuilder: (BuildContext context, int index,
                                bool isFocus) {
                              return Container(
                                color: Colors.white,
                                child: Image.memory(
                                  images[index],
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: Image.memory(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        ValueListenableBuilder(
          valueListenable: index,
          builder: (context, indexValue, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...images.map(
                  (image) => Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: this.index.value == images.indexOf(image)
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
