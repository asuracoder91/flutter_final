import 'package:flutter/material.dart';

class PostButton extends StatefulWidget {
  const PostButton({
    super.key,
    required this.text,
    required this.enabled,
  });
  final String text;
  final bool enabled;

  @override
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.enabled
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onPrimary,
      ),
      child: Center(
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
