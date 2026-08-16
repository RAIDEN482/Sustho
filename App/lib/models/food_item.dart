/// A food item in the local nutrition database. Iron is per 100 g.
class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.ironMg,
    required this.lowGi,
  });

  final String id;
  final String name;
  final String nameBn;

  /// Iron in mg per 100 g edible portion.
  final double ironMg;

  /// True when this food has a low glycaemic index (PCOS-friendly).
  final bool lowGi;
}

/// Local, offline food database with common Bangladesh foods.
class FoodDatabase {
  FoodDatabase._();

  static const List<FoodItem> all = [
    FoodItem(
      id: 'spinach',
      name: 'Spinach (Palong Shak)',
      nameBn: 'পালং শাক',
      ironMg: 2.7,
      lowGi: true,
    ),
    FoodItem(
      id: 'lentils',
      name: 'Lentils (Masoor Dal)',
      nameBn: 'মসুর ডাল',
      ironMg: 3.3,
      lowGi: true,
    ),
    FoodItem(
      id: 'chickpeas',
      name: 'Chickpeas (Chola)',
      nameBn: 'ছোলা',
      ironMg: 6.2,
      lowGi: true,
    ),
    FoodItem(
      id: 'redMeat',
      name: 'Lean red meat',
      nameBn: 'চর্বিহীন লাল মাংস',
      ironMg: 2.6,
      lowGi: false,
    ),
    FoodItem(
      id: 'chicken',
      name: 'Chicken',
      nameBn: 'মুরগির মাংস',
      ironMg: 1.2,
      lowGi: false,
    ),
    FoodItem(
      id: 'fish',
      name: 'Fish (Rui/Katla)',
      nameBn: 'রুই/কাতলা মাছ',
      ironMg: 1.0,
      lowGi: false,
    ),
    FoodItem(
      id: 'eggs',
      name: 'Eggs',
      nameBn: 'ডিম',
      ironMg: 1.8,
      lowGi: false,
    ),
    FoodItem(
      id: 'banana',
      name: 'Banana',
      nameBn: 'কলা',
      ironMg: 0.3,
      lowGi: true,
    ),
    FoodItem(
      id: 'apple',
      name: 'Apple',
      nameBn: 'আপেল',
      ironMg: 0.1,
      lowGi: true,
    ),
    FoodItem(
      id: 'oatmeal',
      name: 'Oatmeal',
      nameBn: 'ওটমিল',
      ironMg: 4.7,
      lowGi: true,
    ),
    FoodItem(
      id: 'brownRice',
      name: 'Brown rice',
      nameBn: 'বাদামি চাল',
      ironMg: 0.8,
      lowGi: true,
    ),
    FoodItem(
      id: 'jaggery',
      name: 'Jaggery (Gur)',
      nameBn: 'গুড়',
      ironMg: 2.9,
      lowGi: false,
    ),
    FoodItem(
      id: 'nuts',
      name: 'Nuts (Badam)',
      nameBn: 'বাদাম',
      ironMg: 3.7,
      lowGi: true,
    ),
    FoodItem(
      id: 'dates',
      name: 'Dates (Khejur)',
      nameBn: 'খেজুর',
      ironMg: 0.9,
      lowGi: true,
    ),
    FoodItem(
      id: 'broccoli',
      name: 'Broccoli',
      nameBn: 'ব্রকলি',
      ironMg: 0.7,
      lowGi: true,
    ),
    FoodItem(
      id: 'soybean',
      name: 'Soybean',
      nameBn: 'সয়াবিন',
      ironMg: 15.7,
      lowGi: true,
    ),
    FoodItem(
      id: 'turmeric',
      name: 'Turmeric (Holud)',
      nameBn: 'হলুদ',
      ironMg: 41.4,
      lowGi: true,
    ),
    FoodItem(
      id: 'pumpkinSeeds',
      name: 'Pumpkin seeds',
      nameBn: 'কুমড়ার বীজ',
      ironMg: 8.8,
      lowGi: true,
    ),
    FoodItem(
      id: 'paneer',
      name: 'Paneer / Chhana',
      nameBn: 'পনির/ছানা',
      ironMg: 0.2,
      lowGi: true,
    ),
    FoodItem(
      id: 'rice',
      name: 'White rice',
      nameBn: 'সাদা চাল',
      ironMg: 0.2,
      lowGi: false,
    ),
  ];

  static List<FoodItem> search(String query, {bool bn = false}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((f) {
      final name = bn ? f.nameBn.toLowerCase() : f.name.toLowerCase();
      return name.contains(q) ||
          f.name.toLowerCase().contains(q) ||
          f.nameBn.toLowerCase().contains(q);
    }).toList();
  }
}
