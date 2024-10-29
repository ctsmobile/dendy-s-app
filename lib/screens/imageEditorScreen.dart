// ignore_for_file: prefer_const_constructors, sort_child_properties_last, curly_braces_in_flow_control_structures, use_super_parameters

import 'dart:io';
import 'dart:ui';

import 'package:dendy_app/controllers/uploadImagesController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageEditorScreen extends StatefulWidget {
  static const Color red = Color(0xFFFF0000);

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  void onFocus() {
    setState(() {});
  }

  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background

  Widget buildDefault(BuildContext context) {
    final UploadImageController controller = Get.put(UploadImageController());

    return Obx(() => Scaffold(
        backgroundColor: appThemeColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          // Listen to the controller.imageController and update the UI when it updates.
          child: controller.isDataLoading.value
              ? Loader()
              : ValueListenableBuilder<PainterControllerValue>(
                  valueListenable: controller.imageController,
                  child: const Text("Flutter Painter Example"),
                  builder: (context, _, child) {
                    return MyAppBar(
                      title: 'Edit Image',
                      actionsWidget: [
                        // Redo action
                        IconButton(
                          icon: const Icon(
                            PhosphorIcons.arrowClockwise,
                            color: purpleColor,
                          ),
                          onPressed:
                              controller.imageController.canRedo ? redo : null,
                        ),
                        // Undo action
                        IconButton(
                          icon: const Icon(
                            PhosphorIcons.arrowCounterClockwise,
                            color: purpleColor,
                          ),
                          onPressed:
                              controller.imageController.canUndo ? undo : null,
                        ),
                      ],
                    );
                  }),
        ),
        // Generate image
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 40),
          height: 50,
          width: 50,
          child: FloatingActionButton(
              backgroundColor: purpleColor,
              elevation: 4,
              onPressed: controller.isImageProcessing.value
                  ? null
                  : () async {
                      if (MediaQuery.of(context).viewInsets.bottom > 0) {
                        FocusScope.of(context).unfocus();
                      } else {
                        controller.isImageProcessing(true);
                        if (Get.put(UploadImageController()).backgroundImage ==
                            null) return;
                        final backgroundImageSize = Size(
                            Get.put(UploadImageController())
                                .backgroundImage!
                                .width
                                .toDouble(),
                            Get.put(UploadImageController())
                                .backgroundImage!
                                .height
                                .toDouble());
                        final imageFuture = Get.put(UploadImageController())
                            .imageController
                            .renderImage(backgroundImageSize)
                            .then<Uint8List?>(
                                (ui.Image image) => image.pngBytes);
                        // Await the result of the Future
                        Uint8List? imageData = await imageFuture;
                        XFile? xFile;
                        var uuid = Uuid();
                        String imageName = '${uuid.v4()}.png';
                        // You need to convert Uint8List to XFile or handle the upload differently
                        if (imageData != null) {
                          // Convert Uint8List to XFile (assuming you know the file path)
                          final tempDir = await getTemporaryDirectory();
                          // var uuid = Uuid();
                          // final file = File('${tempDir.path}/${uuid.v4()}.png');
                          // await file.writeAsBytes(imageData);

                          // xFile = XFile(file.path);

                          xFile = XFile.fromData(
                            imageData,
                            path: '${tempDir.path}/$imageName.png',
                            // Provide mimeType if needed
                            name: imageName, // Provide a name for the file
                          );
                        }
                        // Now you can call the uploadImage method
                        controller.uploadImage(xFile!, imageName);

                        // Get.toNamed(RouteConstant.uploadImagesViewScreen,
                        //     arguments: controller.whichJob.value);
                      }
                    },
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 3, color: purpleColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: controller.isImageProcessing.value
                  ? Loader(
                      color: whiteColor,
                    )
                  : Icon(
                      Icons.done,
                      color: whiteColor,
                      size: 28,
                    )),
        ),
        body: controller.isDataLoading.value
            ? Loader()
            : Stack(
                children: [
                  if (controller.backgroundImage != null)
                    // Enforces constraints
                    Positioned.fill(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: controller.backgroundImage!.width /
                              controller.backgroundImage!.height,
                          child: FlutterPainter(
                            controller: controller.imageController,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: ValueListenableBuilder(
                      valueListenable: controller.imageController,
                      builder: (context, _, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 400,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                color: Colors.white54,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (controller
                                          .imageController.freeStyleMode !=
                                      FreeStyleMode.none) ...[
                                    const Divider(),
                                    const Text("Free Style Settings"),
                                    // Control free style stroke width
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Text("Stroke Width")),
                                        Expanded(
                                          flex: 3,
                                          child: Slider.adaptive(
                                              min: 2,
                                              max: 25,
                                              value: controller.imageController
                                                  .freeStyleStrokeWidth,
                                              onChanged:
                                                  setFreeStyleStrokeWidth),
                                        ),
                                      ],
                                    ),
                                    if (controller
                                            .imageController.freeStyleMode ==
                                        FreeStyleMode.draw)
                                      Row(
                                        children: [
                                          const Expanded(
                                              flex: 1, child: Text("Color")),
                                          // Control free style color hue
                                          Expanded(
                                            flex: 3,
                                            child: Slider.adaptive(
                                                min: 0,
                                                max: 359.99,
                                                value: HSVColor.fromColor(
                                                        controller
                                                            .imageController
                                                            .freeStyleColor)
                                                    .hue,
                                                activeColor: controller
                                                    .imageController
                                                    .freeStyleColor,
                                                onChanged: setFreeStyleColor),
                                          ),
                                        ],
                                      ),
                                  ],
                                  if (controller.textFocusNode.hasFocus) ...[
                                    const Divider(),
                                    const Text("Text settings"),
                                    // Control text font size
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 1, child: Text("Font Size")),
                                        Expanded(
                                          flex: 3,
                                          child: Slider.adaptive(
                                              min: 8,
                                              max: 96,
                                              value: controller.imageController
                                                      .textStyle.fontSize ??
                                                  14,
                                              onChanged: setTextFontSize),
                                        ),
                                      ],
                                    ),

                                    // Control text color hue
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 1, child: Text("Color")),
                                        Expanded(
                                          flex: 3,
                                          child: Slider.adaptive(
                                              min: 0,
                                              max: 359.99,
                                              value: HSVColor.fromColor(
                                                      controller
                                                              .imageController
                                                              .textStyle
                                                              .color ??
                                                          ImageEditorScreen.red)
                                                  .hue,
                                              activeColor: controller
                                                  .imageController
                                                  .textStyle
                                                  .color,
                                              onChanged: setTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (controller.imageController.shapeFactory !=
                                      null) ...[
                                    const Divider(),
                                    const Text("Shape Settings"),

                                    // Control text color hue
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Text("Stroke Width")),
                                        Expanded(
                                          flex: 3,
                                          child: Slider.adaptive(
                                              min: 2,
                                              max: 25,
                                              value: controller
                                                      .imageController
                                                      .shapePaint
                                                      ?.strokeWidth ??
                                                  shapePaint.strokeWidth,
                                              onChanged: (value) =>
                                                  setShapeFactoryPaint(
                                                      (controller.imageController
                                                                  .shapePaint ??
                                                              shapePaint)
                                                          .copyWith(
                                                    strokeWidth: value,
                                                  ))),
                                        ),
                                      ],
                                    ),

                                    // Control shape color hue
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 1, child: Text("Color")),
                                        Expanded(
                                          flex: 3,
                                          child: Slider.adaptive(
                                              min: 0,
                                              max: 359.99,
                                              value: HSVColor.fromColor(
                                                      (controller.imageController
                                                                  .shapePaint ??
                                                              shapePaint)
                                                          .color)
                                                  .hue,
                                              activeColor: (controller
                                                          .imageController
                                                          .shapePaint ??
                                                      shapePaint)
                                                  .color,
                                              onChanged: (hue) =>
                                                  setShapeFactoryPaint(
                                                      (controller.imageController
                                                                  .shapePaint ??
                                                              shapePaint)
                                                          .copyWith(
                                                    color: HSVColor.fromAHSV(
                                                            1, hue, 1, 1)
                                                        .toColor(),
                                                  ))),
                                        ),
                                      ],
                                    ),

                                    // Row(
                                    //   children: [
                                    //     const Expanded(
                                    //         flex: 1, child: Text("Fill shape")),
                                    //     Expanded(
                                    //       flex: 3,
                                    //       child: Center(
                                    //         child: Switch(
                                    //             value: (controller
                                    //                             .imageController
                                    //                             .shapePaint ??
                                    //                         shapePaint)
                                    //                     .style ==
                                    //                 PaintingStyle.fill,
                                    //             onChanged: (value) =>
                                    //                 setShapeFactoryPaint((controller
                                    //                             .imageController
                                    //                             .shapePaint ??
                                    //                         shapePaint)
                                    //                     .copyWith(
                                    //                   style: value
                                    //                       ? PaintingStyle.fill
                                    //                       : PaintingStyle
                                    //                           .stroke,
                                    //                 ))),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller.imageController,
          builder: (context, _, __) => Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Free-style eraser
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          PhosphorIcons.eraser,
                          color: purpleColor,
                          size: 28,
                        ),
                        onTap: toggleFreeStyleErase,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      CustomText(
                        text: 'Erase',
                        textColor: purpleColor,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          PhosphorIcons.scribbleLoop,
                          color: purpleColor,
                          size: 28,
                        ),
                        onTap: toggleFreeStyleDraw,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      CustomText(
                        text: 'Draw',
                        textColor: purpleColor,
                      )
                    ],
                  ),

                  // Add text
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          PhosphorIcons.textT,
                          color: purpleColor,
                          size: 28,
                        ),
                        onTap: addText,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      CustomText(
                        text: 'Text',
                        textColor: purpleColor,
                      )
                    ],
                  ),

                  if (controller.imageController.shapeFactory == null)
                    PopupMenuButton<ShapeFactory?>(
                      tooltip: "Add shape",
                      itemBuilder: (context) => <ShapeFactory, String>{
                        ArrowFactory(): "Arrow",
                        DoubleArrowFactory(): "Double Arrow",
                      }
                          .entries
                          .map((e) => PopupMenuItem(
                              value: e.key,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    getShapeIcon(e.key),
                                    color: purpleColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  CustomText(
                                    text: e.value,
                                    textColor: purpleColor,
                                  ),
                                ],
                              )))
                          .toList(),
                      onSelected: selectShape,
                      child: Column(
                        children: [
                          Icon(
                            getShapeIcon(
                              controller.imageController.shapeFactory,
                            ),
                            size: 28,
                            color: purpleColor,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            text: 'Shapes',
                            textColor: purpleColor,
                          )
                        ],
                      ),
                    )
                  else
                    IconButton(
                      icon: Icon(
                        getShapeIcon(controller.imageController.shapeFactory),
                        color: purpleColor,
                        size: 30,
                      ),
                      onPressed: () => selectShape(null),
                    ),
                ],
              ),
            ),
          ),
        )));
  }

  static IconData getShapeIcon(ShapeFactory? shapeFactory) {
    if (shapeFactory is LineFactory) return PhosphorIcons.lineSegment;
    if (shapeFactory is ArrowFactory) return PhosphorIcons.arrowUpRight;
    if (shapeFactory is DoubleArrowFactory) {
      return PhosphorIcons.arrowsHorizontal;
    }
    if (shapeFactory is RectangleFactory) return PhosphorIcons.rectangle;
    if (shapeFactory is OvalFactory) return PhosphorIcons.circle;
    return PhosphorIcons.polygon;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(UploadImageController()).paintImage();
  }

  @override
  Widget build(BuildContext context) {
    return buildDefault(context);
  }

  void undo() {
    Get.put(UploadImageController()).imageController.undo();
  }

  void redo() {
    Get.put(UploadImageController()).imageController.redo();
  }

  void toggleFreeStyleDraw() {
    Get.put(UploadImageController()).imageController.shapeFactory = null;
    Get.put(UploadImageController()).imageController.freeStyleMode =
        Get.put(UploadImageController()).imageController.freeStyleMode !=
                FreeStyleMode.draw
            ? FreeStyleMode.draw
            : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    Get.put(UploadImageController()).imageController.shapeFactory = null;
    Get.put(UploadImageController()).imageController.freeStyleMode =
        Get.put(UploadImageController()).imageController.freeStyleMode !=
                FreeStyleMode.erase
            ? FreeStyleMode.erase
            : FreeStyleMode.none;
  }

  void addText() {
    Get.put(UploadImageController()).imageController.shapeFactory = null;
    if (Get.put(UploadImageController()).imageController.freeStyleMode !=
        FreeStyleMode.none) {
      Get.put(UploadImageController()).imageController.freeStyleMode =
          FreeStyleMode.none;
    }
    Get.put(UploadImageController()).textFocusNode.addListener(onFocus);
    Get.put(UploadImageController()).imageController.addText();
  }

  void setFreeStyleStrokeWidth(double value) {
    Get.put(UploadImageController()).imageController.freeStyleStrokeWidth =
        value;
  }

  void setFreeStyleColor(double hue) {
    Get.put(UploadImageController()).imageController.freeStyleColor =
        HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  void setTextFontSize(double size) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it

    Get.put(UploadImageController()).imageController.textSettings =
        Get.put(UploadImageController()).imageController.textSettings.copyWith(
            textStyle: Get.put(UploadImageController())
                .imageController
                .textSettings
                .textStyle
                .copyWith(fontSize: size));
  }

  void setShapeFactoryPaint(Paint paint) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it

    Get.put(UploadImageController()).imageController.shapePaint = paint;
  }

  void setTextColor(double hue) {
    Get.put(UploadImageController()).imageController.textStyle =
        Get.put(UploadImageController())
            .imageController
            .textStyle
            .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  }

  void selectShape(ShapeFactory? factory) {
    if (Get.put(UploadImageController()).imageController.freeStyleMode !=
        FreeStyleMode.none) {
      Get.put(UploadImageController()).imageController.freeStyleMode =
          FreeStyleMode.none;
    }
    Get.put(UploadImageController()).imageController.shapeFactory = factory;
  }

  void renderAndDisplayImage() async {
    if (Get.put(UploadImageController()).backgroundImage == null) return;
    final backgroundImageSize = Size(
        Get.put(UploadImageController()).backgroundImage!.width.toDouble(),
        Get.put(UploadImageController()).backgroundImage!.height.toDouble());

    // Render the image
    // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
    final imageFuture = Get.put(UploadImageController())
        .imageController
        .renderImage(backgroundImageSize)
        .then<Uint8List?>((ui.Image image) => image.pngBytes);

    // From here, you can write the PNG image data a file or do whatever you want with it
    // For example:
    // ```dart
    // final file = File('${(await getTemporaryDirectory()).path}/img.png');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ```
    // I am going to display it using Image.memory

    // Show a dialog with the image

    // try {
    //   ByteData? byteData =
    //       await backgroundImage!.toByteData(format: ImageByteFormat.png);
    //   Uint8List imageBytes = byteData!.buffer.asUint8List();

    //   // Get the directory to save the file
    //   final directory = await getApplicationDocumentsDirectory();
    //   final filePath = '${directory.path}/captured_image.png';
    //   final file = File(filePath);

    //   // Write the image bytes to the file
    //   await file.writeAsBytes(imageBytes);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('image saved to gallery'),
    //       action: SnackBarAction(
    //         label: 'Undo',
    //         onPressed: () {
    //           // Handle the action
    //           print('Undo action pressed');
    //         },
    //       ),
    //       duration: Duration(seconds: 3),
    //     ),
    //   );

    //   print('Image saved to $filePath');
    // } catch (e) {
    //   print('Error capturing and saving image: $e');
    // }

    // showDialog(
    //     context: context,
    //     builder: (context) => RenderedImageDialog(imageFuture: imageFuture));
  }

  void removeSelectedDrawable() {
    final selectedDrawable =
        Get.put(UploadImageController()).imageController.selectedObjectDrawable;
    if (selectedDrawable != null)
      Get.put(UploadImageController())
          .imageController
          .removeDrawable(selectedDrawable);
  }

  void flipSelectedImageDrawable() {
    final imageDrawable =
        Get.put(UploadImageController()).imageController.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;

    Get.put(UploadImageController()).imageController.replaceDrawable(
        imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }
}

class RenderedImageDialog extends StatelessWidget {
  final Future<Uint8List?> imageFuture;

  const RenderedImageDialog({Key? key, required this.imageFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rendered Image"),
      content: FutureBuilder<Uint8List?>(
        future: imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          return InteractiveViewer(
              maxScale: 10, child: Image.memory(snapshot.data!));
        },
      ),
    );
  }
}

class SelectStickerImageDialog extends StatelessWidget {
  final List<String> imagesLinks;

  const SelectStickerImageDialog({Key? key, this.imagesLinks = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select sticker"),
      content: imagesLinks.isEmpty
          ? const Text("No images")
          : FractionallySizedBox(
              heightFactor: 0.5,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final imageLink in imagesLinks)
                      InkWell(
                        onTap: () => Navigator.pop(context, imageLink),
                        child: FractionallySizedBox(
                          widthFactor: 1 / 4,
                          child: Image.network(imageLink),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
