class ApolloEleven {
  final String imageUrl;
  final String title;
  final String location;
  final String description;

  ApolloEleven(this.imageUrl, this.title, this.location, this.description);

  ApolloEleven.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        location = json['location'],
        description = json['description'];
}
