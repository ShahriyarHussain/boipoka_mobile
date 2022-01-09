import 'package:boipoka_mobile/Listings/listing.dart';
import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  const ListingCard(this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Center(
        child: Card(
          margin: const EdgeInsets.only(left: 5, right: 15, top: 5),
          color: Colors.indigo[800],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: (Listing.convertListingType(listing.listingType)
                            .toString() ==
                        "Sell")
                    ? const Icon(
                        Icons.sell,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.swap_horizontal_circle_rounded,
                        color: Colors.white,
                      ),
                title: Text(
                  listing.bookName +
                      " for " +
                      Listing.convertListingType(listing.listingType),
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                    "posted on: " +
                        listing.date +
                        " at " +
                        listing.time +
                        " by " +
                        listing.listedByName,
                    style: const TextStyle(color: Colors.white60)),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.black26,
                  ),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        Text(
                          "Price: " + listing.price.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Icon(
                            Icons.mode_standby_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 2),
                            child: Text(
                              "Negotiable: " +
                                  Listing.convertNegotiable(listing.negotiable),
                              style: const TextStyle(color: Colors.white),
                            )),
                      ])),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black26,
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.construction_rounded,
                      color: Colors.white,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Condition: " +
                              Listing.convertCondition(listing.condition),
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black26,
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5, right: 20),
                        child: Text(
                          listing.viewedBy.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    const Icon(
                      Icons.thumbs_up_down,
                      color: Colors.white,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          listing.wishlistedBy.toString(),
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.only(top: 10, left: 10),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(listing.bookName),
    //       Text("Listed by:" + listing.listedByName),
    //       Text("Price: " + listing.price.toString()),
    //       Text("Condition: " + Listing.convertCondition(listing.condition)),
    //       // Text("id: " + listing.id.toString()),
    //       Text("Negotiable:" + Listing.convertNegotiable(listing.negotiable)),
    //       Text("Type:" + Listing.convertListingType(listing.listingType)),
    //       Text("Wishlisted By: " + listing.wishlistedBy.toString()),
    //       Text("Viewed By: " + listing.viewedBy.toString()),
    //       Text("posted on: " + listing.date + " at " + listing.time)
    //     ],
    //   ),
    // );
  }
}
