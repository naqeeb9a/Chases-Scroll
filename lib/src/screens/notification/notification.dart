import 'package:chases_scroll/src/models/notification_model.dart';
import 'package:chases_scroll/src/repositories/chat_repository.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../utils/constants/colors.dart';

class NotificationView extends HookWidget {
  static final ChatRepository chatRepository = ChatRepository();
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationModel = useState<NotificationModel?>(null);
    final isLoading = useState<bool>(true);
    getNotification() {
      chatRepository.getNotification().then((value) {
        notificationModel.value = value;
        isLoading.value = false;
      });
    }

    useEffect(() {
      getNotification();
      return null;
    }, []);

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: customText(
                text: "Notification",
                fontSize: 14,
                textColor: AppColors.black)),
        body: isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                ...notificationModel.value!.content!
                    .mapIndexed((element, value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Row(children: [
                          ChaseScrollContainer(
                              name:
                                  "${element.createdBy!.firstName} ${element.createdBy!.lastName}",
                              imageUrl:
                                  "${Endpoints.displayImages}${element.lastModifiedBy?.data?.imgMain?.value}"),
                          widthSpace(3),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                    text: "${element.title}",
                                    textColor: AppColors.primary,
                                    fontSize: 14),
                                customText(
                                    text: reduceStringLength(
                                        "${element.message}", 25),
                                    fontSize: 11,
                                    textColor: AppColors.textGrey)
                              ]),
                          const Spacer(),
                          customText(
                              text: timeAgoFromEpoch(element.createdDate!),
                              fontSize: 11,
                              textColor: AppColors.primary)
                        ]),
                        heightSpace(1),
                        const Divider(color: Color(0x7F9B9696))
                      ],
                    ),
                  );
                })
              ])));
  }
}
