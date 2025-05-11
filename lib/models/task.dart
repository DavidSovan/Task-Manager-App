class Task {
  final int? id;
  final String title;
  final String description;
  final String status;
  final String? createdAt;
  final String? updatedAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: int.tryParse(json['id'].toString()),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  Task copyWith({int? id, String? title, String? description, String? status}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    );
  }
}
