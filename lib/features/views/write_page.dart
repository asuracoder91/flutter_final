import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/models/feeling.dart';
import 'package:mood_tracker/features/widgets/post_button.dart';

import '../../authentications/repos/authentication_repo.dart';
import '../view_models/content_post.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

Feeling feeling = Feeling.none;

class _WritePageState extends ConsumerState<WritePage>
    with TickerProviderStateMixin {
  String _content = "";
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _contentController.addListener(() {
      setState(() {
        _content = _contentController.text;
      });
    });
    super.initState();
  }

  // Angry Icon Controller
  late final AnimationController _playAngryIconController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // Angry Scale Controller
  late final AnimationController _scaleAngryController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  // Crying Icon Controller
  late final AnimationController _playCryingIconController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );
  // Crying Scale Controller
  late final AnimationController _scaleCryingController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  // Gloomy Icon Controller
  late final AnimationController _playGloomyIconController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );
  // Gloomy Scale Controller
  late final AnimationController _scaleGloomyController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  // Surprised Icon Controller
  late final AnimationController _playSurprisedIconController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // Surprised Scale Controller
  late final AnimationController _scaleSurprisedController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  // Smiling Icon Controller
  late final AnimationController _playSmilingIconController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // Smiling Scale Controller
  late final AnimationController _scaleSmilingController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  // Happy Icon Controller
  late final AnimationController _playHappyIconController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // Happy Scale Controller
  late final AnimationController _scaleHappyController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  void _stopAngryAnimation() {
    _playAngryIconController.stop();
    _scaleAngryController.reverse();
  }

  void _playAngryAnimation() {
    _playAngryIconController.repeat();
    _scaleAngryController.forward();
  }

  void _stopCryingAnimation() {
    _playCryingIconController.stop();
    _scaleCryingController.reverse();
  }

  void _playCryingAnimation() {
    _playCryingIconController.repeat();
    _scaleCryingController.forward();
  }

  void _stopGloomyAnimation() {
    _playGloomyIconController.stop();
    _scaleGloomyController.reverse();
  }

  void _playGloomyAnimation() {
    _playGloomyIconController.repeat();
    _scaleGloomyController.forward();
  }

  void _stopSurprisedAnimation() {
    _playSurprisedIconController.stop();
    _scaleSurprisedController.reverse();
  }

  void _playSurprisedAnimation() {
    _playSurprisedIconController.repeat();
    _scaleSurprisedController.forward();
  }

  void _stopSmilingAnimation() {
    _playSmilingIconController.stop();
    _scaleSmilingController.reverse();
  }

  void _playSmilingAnimation() {
    _playSmilingIconController.repeat();
    _scaleSmilingController.forward();
  }

  void _stopHappyAnimation() {
    _playHappyIconController.stop();
    _scaleHappyController.reverse();
  }

  void _playHappyAnimation() {
    _playHappyIconController.repeat();
    _scaleHappyController.forward();
  }

  void _toggleAngry() {
    setState(() {
      if (_playAngryIconController.isAnimating) {
        _stopAngryAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.angry;
        _playAngryAnimation();
        _stopCryingAnimation();
        _stopGloomyAnimation();
        _stopSurprisedAnimation();
        _stopSmilingAnimation();
        _stopHappyAnimation();
      }
    });
  }

  void _toggleCrying() {
    setState(() {
      if (_playCryingIconController.isAnimating) {
        _stopCryingAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.sad;
        _playCryingAnimation();
        _stopAngryAnimation();
        _stopGloomyAnimation();
        _stopSurprisedAnimation();
        _stopSmilingAnimation();
        _stopHappyAnimation();
      }
    });
  }

  void _toggleGloomy() {
    setState(() {
      if (_playGloomyIconController.isAnimating) {
        _stopGloomyAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.gloomy;
        _playGloomyAnimation();
        _stopAngryAnimation();
        _stopCryingAnimation();
        _stopSurprisedAnimation();
        _stopSmilingAnimation();
        _stopHappyAnimation();
      }
    });
  }

  void _toggleSurprised() {
    setState(() {
      if (_playSurprisedIconController.isAnimating) {
        _stopSurprisedAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.surprised;
        _playSurprisedAnimation();
        _stopAngryAnimation();
        _stopCryingAnimation();
        _stopGloomyAnimation();
        _stopSmilingAnimation();
        _stopHappyAnimation();
      }
    });
  }

  void _toggleSmiling() {
    setState(() {
      if (_playSmilingIconController.isAnimating) {
        _stopSmilingAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.smiling;
        _playSmilingAnimation();
        _stopAngryAnimation();
        _stopCryingAnimation();
        _stopGloomyAnimation();
        _stopSurprisedAnimation();
        _stopHappyAnimation();
      }
    });
  }

  void _postContent() {
    ref
        .read(contentPostProvider.notifier)
        .postFeeling(_content, feeling, context);
  }

  void _toggleHappy() {
    setState(() {
      if (_playHappyIconController.isAnimating) {
        _stopHappyAnimation();
        feeling = Feeling.none;
      } else {
        feeling = Feeling.happy;
        _playHappyAnimation();
        _stopAngryAnimation();
        _stopCryingAnimation();
        _stopGloomyAnimation();
        _stopSurprisedAnimation();
        _stopSmilingAnimation();
      }
    });
  }

  @override
  void dispose() {
    _playAngryIconController.dispose();
    _scaleAngryController.dispose();
    _playCryingIconController.dispose();
    _scaleCryingController.dispose();
    _playGloomyIconController.dispose();
    _scaleGloomyController.dispose();
    _playSurprisedIconController.dispose();
    _scaleSurprisedController.dispose();
    _playSmilingIconController.dispose();
    _scaleSmilingController.dispose();
    _playHappyIconController.dispose();
    _scaleHappyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 감추기
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 30,
          elevation: 0,
          actions: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () async {
                await ref.read(authRepo).signOut();
                // ignore: use_build_context_synchronously
                context.go("/login");
              },
            ),
          ],
        ),
        body: Stack(children: [
          // 로딩 중이 아니면 화면 표시
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    const Text(
                      "  지금 어떤 기분이신가요?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v14,
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.5), // 필요한 경우 색상과 불투명도 조정
                            spreadRadius: 1, // 필요한 경우 스프레드 반경 조정
                            blurRadius: 5, // 필요한 경우 블러 반경 조정
                            offset: const Offset(0, 3), // 그림자 위치의 오프셋 조정
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _contentController,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(
                            15,
                            25,
                            12,
                            25,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          counterText: '',
                        ),
                        maxLines: 5,
                        maxLength: 120,
                      ),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Angry Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleAngry,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleAngryController),
                                child: Lottie.asset(
                                  "assets/animations/angry.json",
                                  controller: _playAngryIconController,
                                  onLoaded: (composition) {
                                    _playAngryIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "화남",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: _playAngryIconController.isAnimating
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        // Crying Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleCrying,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleCryingController),
                                child: Lottie.asset(
                                  "assets/animations/crying.json",
                                  controller: _playCryingIconController,
                                  onLoaded: (composition) {
                                    _playCryingIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "슬픔",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    _playCryingIconController.isAnimating
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        // Gloomy Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleGloomy,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleGloomyController),
                                child: Lottie.asset(
                                  "assets/animations/gloomy.json",
                                  controller: _playGloomyIconController,
                                  onLoaded: (composition) {
                                    _playGloomyIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "우울",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    _playGloomyIconController.isAnimating
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        // Surprised Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleSurprised,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleSurprisedController),
                                child: Lottie.asset(
                                  "assets/animations/surprised.json",
                                  controller: _playSurprisedIconController,
                                  onLoaded: (composition) {
                                    _playSurprisedIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "놀람",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    _playSurprisedIconController.isAnimating
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        // Smiling Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleSmiling,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleSmilingController),
                                child: Lottie.asset(
                                  "assets/animations/smiling.json",
                                  controller: _playSmilingIconController,
                                  onLoaded: (composition) {
                                    _playSmilingIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "흐뭇",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    _playSmilingIconController.isAnimating
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        // Happy Icon
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleHappy,
                              child: ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.3)
                                    .animate(_scaleHappyController),
                                child: Lottie.asset(
                                  "assets/animations/hahaha.json",
                                  controller: _playHappyIconController,
                                  onLoaded: (composition) {
                                    _playHappyIconController.duration =
                                        composition.duration;
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              "신남",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: _playHappyIconController.isAnimating
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gaps.v96,
                    Gaps.v48,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: _content.trim().isNotEmpty &&
                                feeling != Feeling.none &&
                                !ref.watch(contentPostProvider).isLoading
                            ? _postContent
                            : null,
                        child: PostButton(
                            text: "기록",
                            enabled: _content.trim().isNotEmpty &&
                                feeling != Feeling.none &&
                                !ref.watch(contentPostProvider).isLoading),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 로딩 중이면 로딩 표시
          if (ref.watch(contentPostProvider).isLoading) ...[
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ]),
      ),
    );
  }
}
