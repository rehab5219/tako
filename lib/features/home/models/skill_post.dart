class SkillPost {
  final String id;
  final String userId;
  final String userName;
  final String userProfileImageUrl;
  final String skill;
  final String description;
  final String category;
  final String location;
  final double distance;
  final double rating;
  final DateTime postDate;
  final String? time; // Optional, for specific help requests

  SkillPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
    required this.skill,
    required this.description,
    required this.category,
    required this.location,
    required this.distance,
    required this.rating,
    required this.postDate,
    this.time,
  });

  // Factory constructor for creating a SkillPost from a Firestore document
  factory SkillPost.fromFirestore(Map<String, dynamic> data, String id) {
    return SkillPost(
      id: id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userProfileImageUrl: data['userProfileImageUrl'] ?? '',
      skill: data['skill'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      location: data['location'] ?? '',
      distance: (data['distance'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      postDate: (data['postDate']).toDate(),
      time: data['time'],
    );
  }

  // Method to convert SkillPost to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'skill': skill,
      'description': description,
      'location': location,
      'distance': distance,
      'category': category,
      'rating': rating,
      'postDate': postDate,
      'time': time,
    };
  }
}