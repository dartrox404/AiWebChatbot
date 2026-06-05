import 'package:aichat_web/core/const/app_sizes.dart';
import 'package:aichat_web/core/extensions/app_extensions.dart';
import 'package:aichat_web/data/provider/chat_provider.dart';
import 'package:aichat_web/features/utils/my_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reponse = ref.watch(chatProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000428), Color(0xff004e92)],
          ),
        ),
        child: Center(
          child: Container(
            height: context.height * .6,
            width: context.width * .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff000000), Color(0xff434343)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: Offset(0, 8),
                ),
              ],
              color: context.color.secondary,
              borderRadius: .circular(AppSizes.kradiusXl),
            ),
            child: Padding(
              padding: const .symmetric(
                vertical: AppSizes.kspace16,
                horizontal: AppSizes.kspace12,
              ),
              child: Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Bubble😉Chat',
                        style: context.text.headlineLarge?.copyWith(
                          fontFamily: 'poppins',
                          color: context.color.primary,
                        ),
                      ),
                      const Gap(AppSizes.kspace8),
                      MyTextfeild(controller: controller),
                      const Gap(AppSizes.kspace8),
                      SizedBox(
                        width: context.width * .2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff9d4edd),
                            side: BorderSide(color: context.color.secondary),
                          ),
                          onPressed: () {
                            ref
                                .read(chatProvider.notifier)
                                .getmessage(controller.text.trim());
                            controller.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Chat With Me 👀',
                              style: context.text.bodyMedium?.copyWith(
                                fontFamily: 'poppins',
                                color: context.color.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(AppSizes.kspace16),
                    ],
                  ),
                  SizedBox(
                    width: context.width * .2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          reponse.when(
                            data: (data) {
                              return GptMarkdown(
                                data,
                                style: context.text.bodyMedium?.copyWith(
                                  fontFamily: 'poppins',
                                  color: context.color.primary,
                                ),
                              );
                            },
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () => Center(
                              child: Lottie.asset(
                                height: 100,
                                width: 100,
                                "assets/animation/Material wave loading.json",
                              ),
                            ),
                          ),
                        ],
                      ),
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
