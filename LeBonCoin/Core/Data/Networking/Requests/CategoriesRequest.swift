//
//  CategoriesRequest.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

enum CategoriesRequest: RequestProtocol {
  case getCategories

  var path: String {
    "/leboncoin/paperclip/master/categories.json"
  }

  var requestType: RequestType {
    .GET
  }
}
