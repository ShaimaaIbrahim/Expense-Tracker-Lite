import 'package:expense_tracker_lite/data/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/ui/space.dart';

class AnimatedExpenseItem extends StatefulWidget {
  final Category category;
  final String amount;
  final String type;
  final DateTime time;
  final int delay;

  const AnimatedExpenseItem({
    super.key,
    required this.category,
    required this.amount,
    required this.type,
    required this.time,
    required this.delay,
  });

  @override
  State<AnimatedExpenseItem> createState() => _AnimatedExpenseItemState();
}

class _AnimatedExpenseItemState extends State<AnimatedExpenseItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final dateFormat = DateFormat('h:mm a'); // Formats time as "3:00 AM"

    if (dateTime.isAfter(today)) {
      return 'Today at ${dateFormat.format(dateTime)}';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday at ${dateFormat.format(dateTime)}';
    } else {
      final dayFormat = DateFormat('MMM d'); // Formats date as "Jan 5"
      return '${dayFormat.format(dateTime)} at ${dateFormat.format(dateTime)}';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: Color(widget.category.color),
                    shape: BoxShape.circle
                ),
                child: Transform.scale(
                    scale: 0.60, // 5/50 = 0.1
                    child: Image.asset(widget.category.icon, color: Color(widget.category.iconColor))
                ),
              ),
              Space(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Manually",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "-\$${widget.amount}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:  AppColors.darkBackground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDateTime(widget.time),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}