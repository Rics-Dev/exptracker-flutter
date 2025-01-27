enum Category {
  all,
  groceries,
  food,
  work,
  entertainment,
  transportation,
  other;

  String toJson() => name;
  static Category fromJson(String json) => values.byName(json);
}

extension CategoryX on Category {
  String get toName => switch (this) {
        Category.all => 'All',
        Category.groceries => 'Groceries',
        Category.food => 'Food',
        Category.work => 'Work',
        Category.entertainment => 'Entertainment',
        Category.transportation => 'Transportation',
        Category.other => 'Other',
      };
}
