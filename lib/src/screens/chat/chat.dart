import 'package:chases_scroll/src/models/chat_model.dart';
import 'package:chases_scroll/src/repositories/chat_repository.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/screens/chat/model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
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
    final searchController = useTextEditingController();

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

    List<Content> filteredChats() {
      if (searchController.text.isEmpty) {
        return chatModel.value!.content!
            .where((element) => element.type == "ONE_TO_ONE")
            .toList();
      } else {
        return chatModel.value!.content!
            .where((element) =>
                element.type == "ONE_TO_ONE" &&
                element.name!
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
            .toList();
      }
    }

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
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (_) => {},
                decoration: const InputDecoration(hintText: "Search for users"),
              ),
              heightSpace(2),
              isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        ...filteredChats().map((element) {
                          return InkWell(
                            onTap: () {
                              context.push(AppRoutes.privateChat,
                                  extra: ChatDataModel(
                                    name: element.name!,
                                    id: element.id!,
                                    image: element
                                        .lastModifiedBy?.data?.imgMain?.value,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ChaseScrollContainer(
                                      name: "${element.name} ",
                                      imageUrl:
                                          "${Endpoints.displayImages}${element.lastModifiedBy?.data?.imgMain?.value}",
                                    ),
                                  ),
                                  widthSpace(2),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "${element.name}",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                      ),
                                      heightSpace(.1),
                                      customText(
                                        text: reduceStringLength(
                                            element.lastMessage ?? "", 24),
                                        fontSize: 11,
                                        textColor: AppColors.textGrey,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  customText(
                                    text: formatEpoch(element.createdDate!),
                                    fontSize: 11,
                                    textColor: AppColors.textGrey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
