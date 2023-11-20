import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/custom_fonts.dart';

class EventContainerTransformView extends StatefulWidget {
  final int? index;

  final double? currentPageValue;
  final double? scaleFactor;
  final EventContent? event;
  const EventContainerTransformView(
      {super.key,
      this.index,
      this.currentPageValue,
      this.scaleFactor,
      this.event});

  @override
  State<EventContainerTransformView> createState() =>
      _EventContainerTransformViewState();
}

class _EventContainerTransformViewState
    extends State<EventContainerTransformView> with TickerProviderStateMixin {
  double height = 200;

  @override
  Widget build(BuildContext context) {
    //for Transform purpose -(to animate the container cards)
    Matrix4 matrix = Matrix4.identity();
    if (widget.index == widget.currentPageValue!.floor()) {
      //..............(currentPageValue = 0 && index = 1)
      //..............1 - (1 -1)*(1 - 0.80) = 0; ..............................this is for the initial pageview and current index
      var currScale = 1 -
          (widget.currentPageValue! - widget.index!) *
              (1 - widget.scaleFactor!);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (widget.index! == widget.currentPageValue!.floor() + 1) {
      //
      //..............(currentPageValue = 1 && index = 2)
      //..............1 + (1 -2 + 1)*(1 - 0.80) = 1; ..............................this is for the initial pageview and current index
      var currScale = widget.scaleFactor! +
          (widget.currentPageValue! - widget.index! + 1) *
              (1 - widget.scaleFactor!);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (widget.index! == widget.currentPageValue!.floor() - 1) {
      var currScale = 1 -
          (widget.currentPageValue! - widget.index!) *
              (1 - widget.scaleFactor!);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - widget.scaleFactor!) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.eventDetailMainView, extra: widget.event);
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(0),
            ),
            color: widget.index!.isEven
                ? const Color(0xff69c5df)
                : const Color(0xff9294cc),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  //height: MediaQuery.of(context).size.height / 4.78,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(0),
                    ),
                    //color: Colors.grey.shade200,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.event!.currentPicUrl}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      color: AppColors.deepPrimary),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: customText(
                        text: widget.event!.eventName!,
                        fontSize: 11,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
