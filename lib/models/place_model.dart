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
  // 1. Busca o título (você já faz bem, mas vamos garantir)
  String? title = json['ShortName'];
  if (title == null && json['Detail'] != null) {
    title = json['Detail']['en']?['Title'] ?? json['Detail']['it']?['Title'];
  }

  // 2. Busca a Imagem (Tenta a galeria, se não tiver, tenta o campo ImageSummary)
  String? img;
  if (json['ImageGallery'] != null && (json['ImageGallery'] as List).isNotEmpty) {
    img = json['ImageGallery'][0]['ImageUrl'];
  } else if (json['FirstImage'] != null) {
    img = json['FirstImage']['ImageUrl'];
  }

  // 3. Busca a Descrição (Tenta vários campos onde ela costuma se esconder)
  String? desc = json['Detail']?['en']?['BaseText'];
  if (desc == null || desc.isEmpty) {
    desc = json['Detail']?['it']?['BaseText']; // Tenta em italiano se não tiver inglês
  }

  return PlaceModel(
    id: (json['Id'] ?? json['id'] ?? '').toString(),
    name: title ?? 'Local sem nome',
    imageUrl: img,
    description: (desc != null && desc.isNotEmpty) ? desc : 'Explore este local incrível para descobrir mais detalhes.',
  );
}
}