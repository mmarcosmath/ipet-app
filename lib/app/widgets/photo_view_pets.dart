import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:ipet/app/util/hexcolor.dart';

class PhotoViewPets extends StatelessWidget {
  final List<String> photos;
  final controller = PageController();
  final index = ValueNotifier(0);

  PhotoViewPets({
    Key? key,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          colorFilter: ColorFilter.mode(
            HexColor("#2fb7a7").withOpacity(0.9),
            BlendMode.srcATop,
          ),
          fit: BoxFit.cover,
        ),
      ),
      height: 380,
      child: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              this.index.value = index;
            },
            children: [
              ...photos.map(
                (photo) => GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return InteractiveviewerGallery(
                          maxScale: 20,
                          sources: photos,
                          onPageChanged: (index) {
                            this.index.value = index;
                            controller.jumpToPage(index);
                          },
                          initIndex: photos.indexOf(photo),
                          itemBuilder:
                              (BuildContext context, int index, bool isFocus) {
                            return Container(
                              color: Colors.white,
                              child: CachedNetworkImage(
                                imageUrl: photos[index],
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 6.0,
                                    color: HexColor("#2fb7a7"),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: 380,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: photo,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: ValueListenableBuilder(
                  valueListenable: index,
                  builder: (context, indexValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...photos.map(
                          (photo) => Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: this.index.value == photos.indexOf(photo)
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
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
