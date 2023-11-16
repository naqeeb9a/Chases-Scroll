import 'package:chases_scroll/src/models/chat_model.dart';
import 'package:chases_scroll/src/repositories/chat_repository.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/screens/chat/model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/routes.dart';

class ChatScreen extends HookWidget {
  static final ChatRepository chatRepository = ChatRepository();
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatModel = useState<ChatModel?>(null);
    final isLoading = useState<bool>(true);
    getAllChats() {
      chatRepository.getChat().then((value) {
        isLoading.value = false;
        chatModel.value = value;
      });
    }

    useEffect(() {
      getAllChats();
      return null;
    }, []);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: true,
          title: customText(
              text: "Chat", textColor: AppColors.primary, fontSize: 14),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.black87,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 10, bottom: 15),
              child: GestureDetector(
                onTap: () {
                  context.push(AppRoutes.createChat);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const AppTextFormField(hintText: "Search for users"),
            heightSpace(2),
            isLoading.value
                ? const CircularProgressIndicator()
                : Column(children: [
                    ...chatModel.value!.content!.mapIndexed((element, index) {
                      return InkWell(
                        onTap: () {
                          if (element.type == "ONE_TO_ONE") {
                            context.push(AppRoutes.privateChat,
                                extra: ChatDataModel(
                                    name: element.name!,
                                    id: element.id!,
                                    image: element
                                        .lastModifiedBy?.data?.imgMain?.value));
                            return;
                          }
                          context.push(AppRoutes.groupChatMessage,
                              extra: ChatDataModel(
                                  name: element.name!,
                                  id: element.id!,
                                  image: element
                                      .lastModifiedBy?.data?.imgMain?.value));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            element.type == "ONE_TO_ONE"
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChaseScrollContainer(
                                        name: "${element.name} ",
                                        imageUrl:
                                            "${Endpoints.displayImages}${element.lastModifiedBy?.data?.imgMain?.value}"),
                                  )
                                : SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(0),
                                              ),
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 3,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(0),
                                              ),
                                              color: const Color(0xFF9DA8FB),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          child: ChaseScrollContainer(
                                              name: "${element.name} ",
                                              imageUrl:
                                                  "${Endpoints.displayImages}${element.lastModifiedBy?.data?.imgMain?.value}"),
                                        ),
                                      ],
                                    ),
                                  ),
                            widthSpace(2),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                      text: "${element.name}",
                                      fontSize: 14,
                                      textColor: AppColors.black),
                                  heightSpace(.1),
                                  customText(
                                      text: reduceStringLength(
                                          element.lastMessage ?? "", 24),
                                      fontSize: 11,
                                      textColor: AppColors.textGrey)
                                ]),
                            const Spacer(),
                            customText(
                                text: formatEpoch(element.createdDate!),
                                fontSize: 11,
                                textColor: AppColors.textGrey)
                          ]),
                        ),
                      );
                    })
                  ])
          ]),
        )));
  }
}
