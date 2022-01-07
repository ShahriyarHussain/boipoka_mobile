class Listing {
  final dynamic id,
      descriptions,
      price,
      condition,
      negotiable,
      listingType,
      date,
      book,
      listedBy,
      wishlistedBy,
      viewedBy,
      trades,
      listedByName,
      bookName,
      time;

  Listing({
    required this.id,
    required this.descriptions,
    required this.price,
    required this.condition,
    required this.negotiable,
    required this.bookName,
    required this.book,
    required this.listingType,
    required this.date,
    required this.listedBy,
    required this.listedByName,
    required this.wishlistedBy,
    required this.viewedBy,
    required this.trades,
    required this.time,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
        id: json['id'],
        descriptions: json['descriptions'],
        price: json['price'],
        condition: json['condition'],
        negotiable: json['negotiable'],
        bookName: json['book_name'],
        book: json['book'],
        listingType: json['listing_type'],
        date: json['date'].split("T")[0],
        listedBy: json['listed_by'],
        listedByName: json['listed_by_names'],
        wishlistedBy: json['wishlisted_by'],
        viewedBy: json['viewed_by'],
        trades: json['trades'],
        time: json['date'].split("T")[1].split(".")[0]);
  }

  static String convertCondition(int condition) {
    if (condition == 1) {
      return "Excellent";
    } else if (condition == 2) {
      return "Fair";
    } else if (condition == 3) {
      return "Acceptable";
    } else if (condition == 4) {
      return "Well Worn";
    } else {
      return "Poor";
    }
  }

  static String convertNegotiable(bool negotiable) {
    return negotiable ? "Yes" : "No";
  }

  static String convertListingType(bool listing_type) {
    return listing_type ? "Sell" : "Exchange";
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id \n$descriptions \n$price \n$condition \n$negotiable \n$bookName \n$book \n$listingType \n$date \n$listedBy \n$listedByName \n$wishlistedBy \n$viewedBy \n$trades";
  }
}
