//
//  ListingRequest.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

enum ListingRequest: RequestProtocol {
  case getListing

  var path: String {
    "/leboncoin/paperclip/master/listing.json"
  }

  var requestType: RequestType {
    .GET
  }
}
