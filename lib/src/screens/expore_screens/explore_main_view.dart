import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/explore_provider.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/event_container_tranform_view.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/suggestions_view.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants/spacer.dart';
import '../widgets/custom_fonts.dart';
import '../widgets/textform_field.dart';

// class ExploreMainView extends ConsumerWidget {
//   const ExploreMainView({super.key});

//   @override
//   State<ExploreMainView> createState() => _ExploreMainViewState();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// class _ExploreMainViewState extends State<ExploreMainView>
//     with TickerProviderStateMixin {
//   final searchController = TextEditingController();

//   PageController pageController = PageController(viewportFraction: 0.95);
//   int currentIndex = 0;
//   PageController? _controller;

//   double _currentPageValue = 0.0;
//   final double _scaleFactor = 0.8;
//   double height = 200;

//   @override
//   void initState() {
//     _controller = PageController(initialPage: 0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final getTopEvents =
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: PAD_ALL_15,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               customText(
//                   text: "Hello David",
//                   fontSize: 20,
//                   textColor: AppColors.black,
//                   fontWeight: FontWeight.w700),
//               heightSpace(1),
//               GestureDetector(
//                 onTap: () => context.push(AppRoutes.searchExploreView),
//                 child: Container(
//                   padding: PAD_ALL_13,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 1.2,
//                       color: AppColors.primary,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       SvgPicture.asset(
//                         'assets/svgs/search-chase.svg',
//                         height: 20,
//                       ),
//                       widthSpace(2),
//                       customText(
//                         text: "Search for users, event or...",
//                         fontSize: 14,
//                         textColor: AppColors.searchTextGrey,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               heightSpace(1),
//               customText(
//                   text: "Top Events",
//                   fontSize: 14,
//                   textColor: AppColors.primary,
//                   fontWeight: FontWeight.w700),
//               heightSpace(1),
//               Expanded(
//                 flex: 3,
//                 child: Container(
//                   // color: Colors.indigo,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           //color: Colors.amber,
//                           child: PageView.builder(
//                             controller: pageController,
//                             scrollDirection: Axis.horizontal,
//                             itemCount: 5,
//                             onPageChanged: (int pageIndex) {
//                               setState(() {
//                                 _currentPageValue = pageIndex.toDouble();
//                               });
//                             },
//                             itemBuilder: (BuildContext context, int index) {
//                               return EventContainerTransformView(
//                                 index: index,
//                                 currentPageValue: _currentPageValue,
//                                 scaleFactor: _scaleFactor,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 50,
//                         width: double.infinity,
//                         //color: Colors.green,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             5,
//                             (index) => buildDot(index, context),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   customText(
//                       text: "People you may know",
//                       fontSize: 14,
//                       textColor: AppColors.black,
//                       fontWeight: FontWeight.w700),
//                   GestureDetector(
//                     onTap: () => context.push(AppRoutes.suggestionFriendMore),
//                     child: customText(
//                         text: "Sell all",
//                         fontSize: 12,
//                         textColor: AppColors.deepPrimary,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 6,
//                     itemBuilder: (BuildContext context, int index) {
//                       return SuggestionView();
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //widget for the cur

//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       height: _currentPageValue == index ? 13 : 8,
//       width: _currentPageValue == index ? 13 : 8,
//       margin: EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: _currentPageValue == index
//             ? AppColors.deepPrimary
//             : AppColors.lightGrey,
//       ),
//     );
//   }
// }

// class ExploreMainView extends ConsumerStatefulWidget {

// final getTopEvent = ref.watch(eventListFutureProvider);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return Scaffold(
//       body: SafeArea(
//         child: getTopEvent.when(
//           data: (data) {
//             return ListView.builder(
//               itemCount: 4,
//               itemBuilder: (BuildContext context, int index) {
//                 return Text(data[index].eventName);
//               },
//             );
//           },
//           error: (error, stack) => Text(error.toString()),
//           loading: () {
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }

class ExploreMainView extends StatelessWidget {
  const ExploreMainView({super.key});

  @override
  Widget build(BuildContext context) {
    // final getTopEvent = ref.watch(eventListFutureProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(),
        // child: getTopEvent.when(
        //   data: (data) {
        //     return ListView.builder(
        //       itemCount: 4,
        //       itemBuilder: (BuildContext context, int index) {
        //         return Text(data[index].createdDate.toString());
        //       },
        //     );
        //   },
        //   error: (error, stack) => Text(error.toString()),
        //   loading: () {
        //     return CircularProgressIndicator();
        //   },
        // ),
      ),
    );
  }
}
