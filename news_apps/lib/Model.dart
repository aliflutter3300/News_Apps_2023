class NewsQueryModel {
  late String newsHead;
  late String newsDes;
  late String newsImg;
  late String newsUrl;

  NewsQueryModel({
    this.newsHead = "NEWS HEADLINE",
    this.newsDes = "News For Daily Life",
    this.newsImg = "SOME URL",
    this.newsUrl = "SOME URL",
  });

  factory NewsQueryModel.fromMap(Map<String, dynamic> news) {
    return NewsQueryModel(
      newsHead: news["title"] ?? "NEWS HEADLINE",
      newsDes: news["description"] ?? "News For Daily Life",
      newsImg: news["urlToImage"] ?? "SOME URL",
      newsUrl: news["url"] ?? "SOME URL",
    );
  }
}
