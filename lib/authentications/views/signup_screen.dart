import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/authentications/views/login_screen.dart';
import 'package:mood_tracker/authentications/widgets/login_form.dart';
import 'package:mood_tracker/authentications/widgets/social_login.dart';
import 'package:mood_tracker/authentications/widgets/social_login_dark.dart';
import 'package:mood_tracker/constants/gaps.dart';
import '../view_models/google_login_view_model.dart';
import '../view_models/signup_view_model.dart';
import '../widgets/auth_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static const routeURL = "/signup";
  static const routeName = "signup";

  @override
  ConsumerState<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignUpScreen> {
  // form 관련 Key와 Controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // 이메일 확인 정규표현식
  final _emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  bool _hasValidEmail = false;
  bool _hasValidPassword = false;
  bool _isButtonActive = false;

  // email, password 저장하는 form
  Map<String, String> formData = {};

  void _goLoginScreen(BuildContext context) {
    context.goNamed(LoginScreen.routeName);
  }

  void _onSignUpTap() {
    if (_formKey.currentState != null) {
      if (_isButtonActive) {
        _formKey.currentState!.save();
        ref.read(signUpProvider.notifier).signUp(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  // 버튼 상태 관리
  void _updateButtonState() {
    setState(() {
      _isButtonActive = _hasValidPassword && _hasValidEmail;
    });
  }

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _hasValidEmail = _emailPattern.hasMatch(_emailController.text);
        _updateButtonState();
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _hasValidPassword = _passwordController.text.length >= 8;
        _updateButtonState();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // error message handling provider monitor
    final errorMessage = ref.watch(signUpErrorMessageProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 화면 터치하면 키보드 내려감
      child: Scaffold(
          resizeToAvoidBottomInset: false, // 가상 키보드 올라왔을 때 화면깨짐 방지
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 상단 블럭
                    Column(children: [
                      SizedBox(
                        height: 200,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Lottie.asset(
                                "assets/animations/walking_avocado.json",
                                width: 220,
                                height: 220,
                                repeat: true,
                                animate: true,
                              ),
                            ),
                            const Positioned(
                              top: 86,
                              right: 72,
                              child: Text(
                                '기분을 가볍게\n기록해 보세요',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginForm(
                                text: "이메일",
                                controller: _emailController,
                                obscureText: false,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['email'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v8,
                              LoginForm(
                                text: "패스워드",
                                controller: _passwordController,
                                obscureText: true,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['password'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v6,
                              Visibility(
                                  visible: errorMessage != null &&
                                      errorMessage.isNotEmpty,
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: SizedBox(
                                    height: 40,
                                    child: Text(
                                      errorMessage ?? "",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14,
                                        letterSpacing: -0.3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: _onSignUpTap,
                          child: AuthButton(
                              text: "계정생성",
                              enabled: _isButtonActive &&
                                  !ref.watch(signUpProvider).isLoading),
                        ),
                      ),
                      Gaps.v36,
                      Gaps.v64,
                      // 구글 로그인 버튼
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: SocialLogin(
                          text: "Sign In with Google",
                          icon: SvgPicture.asset(
                              "assets/icons/icons8-google.svg",
                              width: 28),
                        ),
                      ),
                      Gaps.v10,

                      // 애플 로그인 버튼
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: SocialLoginDark(
                          text: "Continue with Apple",
                          icon: SvgPicture.asset(
                            "assets/icons/icons8-apple-logo.svg",
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ]),

                    //최하단 텍스트 : 회원가입
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('계정이 있으신가요? '),
                          GestureDetector(
                            onTap: () => _goLoginScreen(context),
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // 로딩 중이면 로딩 표시
                if (ref.watch(signUpProvider).isLoading ||
                    ref.watch(googleLoginProvider).isLoading) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ],
            ),
          )),
    );
  }
}
