import 'package:hive/hive.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  @HiveField(3)
  final int color; // Store color as int (ARGB)

  @HiveField(4)
  final int iconColor; // Store icon color as int (ARGB)
  
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  // Predefined categories
  static const List<Category> predefinedCategories = [
    Category(
      id: '1',
      name: 'Groceries',
      icon: AppAssets.groceriesIcon,
      color: 0x592A79DB,
      iconColor: 0xF20951B7
    ),
    Category(
      id: '2',
      name: 'Entertainment',
      icon: AppAssets.entertainmentIcon,
      color: AppColors.funBg,
      iconColor: 0xFFFB8C00
    ),
    Category(
      id: '3',
      name: 'Gas',
      icon: AppAssets.gasIcon,
      color: AppColors.gasBg, 
      iconColor: 0xFFE53935
    ),
    Category(
      id: '4',
      name: 'Shopping',
      icon: AppAssets.shoppingIcon,
      color: AppColors.shopBg,
      iconColor: 0xFFFFD180
    ),
    Category(
      id: '5',
      name: 'News Paper',
      icon: AppAssets.newsPaperIcon,
      color: AppColors.newsBg,
      iconColor: 0xFFFB8C00
    ),
    Category(
      id: '6',
      name: 'Transport',
      icon: AppAssets.transportIcon,
      color: AppColors.transportBg,
      iconColor: 0xFF42A5F5
    ),
    Category(
      id: '7',
      name: 'Rent',
      icon: AppAssets.rentIcon,
      color: AppColors.rentBg,
      iconColor: 0xFFFB8C00
    ),
    Category(
        id: '8',
        name: 'Add Category',
        icon: AppAssets.addIcon,
        color: 0xFFFFFFFF,
        iconColor: 0xFF42A5F5
    )
  ];

  static Category? getCategoryById(String id) {
    try {
      return predefinedCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ icon.hashCode ^ color.hashCode;
  }
} 