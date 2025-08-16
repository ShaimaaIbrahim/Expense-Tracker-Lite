import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:expense_tracker_lite/features/add_expense/view_models/expense_bloc.dart';
import 'package:expense_tracker_lite/features/add_expense/view_models/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_expense/views/screens/add_expense_screen.dart';
import '../dashboard/views/screens/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: _buildBottomBarWithIntegratedFAB(),
    );
  }

  Widget _buildCurrentScreen() {
    return IndexedStack(
      index: _currentIndex,
      children: [
         DashboardScreen(),
        Container(),
        Container(),
        Container(),
      ],
    );
  }

  Widget _buildBottomBarWithIntegratedFAB() {
    return Container(
      height: 70, // Increased height for FAB
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Navigation Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, "Home"),
              _buildNavItem(1, Icons.wallet_outlined, "Expenses"),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(2, Icons.bar_chart_outlined, "Stats"),
              _buildNavItem(3, Icons.person_outline, "Profile"),
            ],
          ),

          // Centered FAB (part of the navigation bar)
          Positioned(
            top: -25, // Half outside the bar
            child: GestureDetector(
              onTap: () => _onFabPressed(),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey[600],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _onFabPressed() async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpenseScreen()),
    );
    if(result==true){
      debugPrint("hhi");
      context.read<ExpenseBloc>().add(LoadExpensesEvent());
    }
  }
}


