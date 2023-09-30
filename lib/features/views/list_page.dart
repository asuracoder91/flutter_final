import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/utils.dart';

import '../../authentications/repos/authentication_repo.dart';
import '../../constants/gaps.dart';
import '../models/feeling.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  Future<void> _deletePost(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(ref.read(authRepo).user!.uid)
        .collection("feelings")
        .doc(doc.id)
        .delete();
  }

  Future<void> _showDeleteModal(BuildContext context, DocumentSnapshot doc) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          "이 기분을 지우고 싶어요?",
          style: TextStyle(
            height: 2,
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              await _deletePost(doc);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: const Text(
              "지우기",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            "취소",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // transparent appbar with only tail icon
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

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(ref.read(authRepo).user!.uid)
            .collection("feelings")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text(
                "비어있는 기분",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    _showDeleteModal(context, docs[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v16,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 13, 6, 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Lottie.asset(
                                  getEmojiUrl(Feeling.values.firstWhere((e) =>
                                      e.toString() ==
                                      'Feeling.${docs[index]["feeling"]}')),
                                  width: 50,
                                  height: 50,
                                ),
                                Gaps.h6,
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 50,
                                    maxHeight: double.infinity,
                                    maxWidth: 275,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      docs[index]["content"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gaps.v4,
                        Text(
                          getTimeText(docs[index]["createdAt"]),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
