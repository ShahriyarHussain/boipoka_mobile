import 'package:boipoka_mobile/Listings/listing.dart';
import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  const ListingCard(this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(listing.bookName),
          Text("Listed by:" + listing.listedByName),
          Text("Price: " + listing.price.toString()),
          Text("Condition: " + Listing.convertCondition(listing.condition)),
          // Text("id: " + listing.id.toString()),
          Text("Negotiable:" + Listing.convertNegotiable(listing.negotiable)),
          Text("Type:" + Listing.convertListingType(listing.listingType)),
          Text("Wishlisted By: " + listing.wishlistedBy.toString()),
          Text("Viewed By: " + listing.viewedBy.toString()),
          Text("posted on: " + listing.date + " at " + listing.time)
        ],
      ),
    );
  }
}
