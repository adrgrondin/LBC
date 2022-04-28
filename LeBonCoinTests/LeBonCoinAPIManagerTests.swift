//
//  LeBonCoinAPIManagerTests.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 28/04/2022.
//

import XCTest
@testable import LeBonCoin

class LeBonCoinAPIManagerTests: XCTestCase {

    private var apiManager: APIManagerProtocol?

    override func setUpWithError() throws {
        apiManager = APIManagerMock()
    }

    func testFetchListing() async throws {
        guard let listing: Listing = try await apiManager?.initRequest(with: ListingRequestMock.getListing) else {
            return
        }

        let firstAd = listing.first

        XCTAssertEqual(firstAd?.id, 1461267313)

        XCTAssertEqual(firstAd?.categoryID, 4)

        XCTAssertEqual(firstAd?.title, "Statue homme noir assis en plâtre polychrome")

        XCTAssertEqual(firstAd?.listingDescription, "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible")

        XCTAssertEqual(firstAd?.price, 140.00)

        XCTAssertEqual(firstAd?.imagesURL.small, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")

        XCTAssertEqual(firstAd?.imagesURL.thumb, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")

        let date = ISO8601DateFormatter().date(from: "2019-11-05T15:56:59+0000")
        XCTAssertEqual(firstAd?.creationDate, date)

        XCTAssertEqual(firstAd?.isUrgent, false)

        XCTAssertEqual(firstAd?.siret, nil)
    }
}
