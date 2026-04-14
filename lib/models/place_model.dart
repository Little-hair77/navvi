class PlaceModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;

  PlaceModel({
    required this.id, 
    required this.name, 
    this.imageUrl, 
    this.description
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    String? title = json['ShortName'];
    if (title == null && json['Detail'] != null) {
      title = json['Detail']['en']?['Title'];
    }

    String? img;
    if (json['ImageGallery'] != null && (json['ImageGallery'] as List).isNotEmpty) {
      img = json['ImageGallery'][0]['ImageUrl'];
    }

    return PlaceModel(
      id: (json['Id'] ?? json['id'] ?? '').toString(), 
      
      name: title ?? 'Sem nome',
      
      imageUrl: img,
      
      description: json['Detail']?['en']?['BaseText'] ?? 'Nenhuma descrição disponível.',
    );
  }
}