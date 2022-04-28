//
//  ListingRequestMock.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 28/04/2022.
//

import Foundation
@testable import LeBonCoin

enum ListingRequestMock: RequestProtocol {
    case getListing

    var path: String {
        guard let path = Bundle.main.path(forResource: "Listing", ofType: "json") else { return "" }
        return path
    }

    var requestType: RequestType {
        .GET
    }
}
