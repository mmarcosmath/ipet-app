import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipet/app/util/database.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/util/messages.dart';
import 'package:ipet/app/util/utils.dart';
import 'package:ipet/app/widgets/custom_button.dart';
import 'package:ipet/app/widgets/custom_textfield.dart';
import 'package:ipet/app/widgets/custon_textbutton.dart';
import 'package:ipet/app/widgets/genre_select.dart';
import 'package:ipet/app/widgets/photos_view.dart';

class Donate extends StatelessWidget {
  Donate({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  String genre = "";
  ValueNotifier<List<Uint8List>?> images = ValueNotifier(null);
  var donateValidator = ValueNotifier<bool>(false);

  void setGenre(String genre) => this.genre = genre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            colorFilter: ColorFilter.mode(
              HexColor("#2fb7a7").withOpacity(0.9),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  ValueListenableBuilder(
                    valueListenable: images,
                    builder: (context, List<Uint8List>? imageValue, _) {
                      return imageValue != null
                          ? Container(
                              height: 250,
                              child: PhotosView(
                                images: imageValue,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                var imagesBytes = await selectMultipleImages();
                                images.value = imagesBytes;
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                ),
                                alignment: Alignment.center,
                                height: 250,
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
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  "assets/icons/camera.png",
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          controller: nameController,
                          icon: Image.asset("assets/icons/pet.png"),
                          title: "Nome",
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: dateController,
                                icon: Image.asset("assets/icons/birthday.png"),
                                title: "Idade/Meses",
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GenreSelect(onChange: setGenre),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: descriptionController,
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          icon: Image.asset("assets/icons/description.png"),
                          title: "Descrição",
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ValueListenableBuilder(
                            valueListenable: donateValidator,
                            builder: (context, bool isLoading, _) {
                              return Center(
                                child: AnimatedContainer(
                                  height: 50,
                                  width: isLoading
                                      ? 50
                                      : MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  duration: Duration(milliseconds: 300),
                                  child: isLoading
                                      ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: CircularProgressIndicator(
                                              color: HexColor("#2fb7a7"),
                                            ),
                                          ),
                                        )
                                      : CustomButton(
                                          title: "CONCLUIDO",
                                          onPressed: () async {
                                            donateValidator.value = true;
                                            if (nameController.text.isNotEmpty &&
                                                dateController
                                                    .text.isNotEmpty &&
                                                descriptionController
                                                    .text.isNotEmpty &&
                                                genre.isNotEmpty &&
                                                images.value != null) {
                                              bool isCreate = await savePet(
                                                name: nameController.text,
                                                date: dateController.text,
                                                description:
                                                    descriptionController.text,
                                                genre: genre,
                                                photos: images.value!,
                                              );
                                              if (isCreate) {
                                                Message.showMessage(context,
                                                    "Cadastro efetuado!");
                                                return Navigator.pop(context);
                                              } else {
                                                Message.showMessage(context,
                                                    "Erro ao realizar cadastro!");
                                              }
                                            } else {
                                              Message.showError(context,
                                                  "Preencha todos os campos!");
                                            }
                                            donateValidator.value = false;
                                          },
                                        ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextButton(
                          title: "VOLTAR",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
