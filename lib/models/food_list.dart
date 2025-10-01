class Food {
  final String name;
  final String category;
  final int price;
  final List<String> ingredients;
  final int calories;
  final String image;
  final String recipeUrl;
  final String description;

  Food({
    required this.name,
    required this.category,
    required this.price,
    required this.ingredients,
    required this.calories,
    required this.image,
    required this.recipeUrl,
    required this.description,
  });
}