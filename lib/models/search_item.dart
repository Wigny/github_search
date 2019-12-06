class SearchItem {
  final String fullName;
  final String url;
  final String avatarUrl;

  SearchItem({this.fullName, this.url, this.avatarUrl});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    var owner = json["owner"] as Map<String, dynamic>;

    return SearchItem(
      fullName: json["full_name"] as String,
      url: json["html_url"] as String,
      avatarUrl: owner["avatar_url"] as String,
    );
  }
}
