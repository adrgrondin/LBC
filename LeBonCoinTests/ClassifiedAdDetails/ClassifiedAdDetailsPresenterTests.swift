//
//  ClassifiedAdDetailsPresenterTests.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 03/05/2022.
//

import XCTest
@testable import LeBonCoin

class ClassifiedAdDetailsPresenterTests: XCTestCase {
    var presenter: ClassifiedAdDetailsPresenter!
    let dateFormatter = ISO8601DateFormatter()

    override func setUpWithError() throws {
        let imagesUrl = ImagesURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/57a118ce39d6e40844a87f65b3eb3682e7b38c1d.jpg",
                                 thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/57a118ce39d6e40844a87f65b3eb3682e7b38c1d.jpg")


        let date = dateFormatter.date(from: "2019-11-05T15:55:42+0000")!
        
        let classifiedAd = ClassifiedAd(id: 1701863264,
                                        categoryID: 1,
                                        title: "2 phare xénon megane 2 phase 1 complet",
                                        listingDescription: "2 phare xénon megane 2 phase 1 complet",
                                        price: 250.00,
                                        imagesURL: imagesUrl,
                                        creationDate: date,
                                        isUrgent: true,
                                        siret: "893 432 877")

        presenter = ClassifiedAdDetailsPresenter(classifiedAd: classifiedAd, categoryName: "Véhicule")
    }

    func testAttach() throws {
        let view = ClassifiedAdDetailsViewMock()
        presenter.attach(view: view)

        XCTAssertNotNil(presenter.view)
    }

    func testSetClassifiedAdAndCategoryName() throws {
        let view = ClassifiedAdDetailsViewMock()
        presenter.attach(view: view)

        let date = dateFormatter.date(from: "2019-11-05T15:55:42+0000")!

        XCTAssertEqual(view.classifiedAd?.id, 1701863264)
        XCTAssertEqual(view.classifiedAd?.categoryID, 1)
        XCTAssertEqual(view.classifiedAd?.title, "2 phare xénon megane 2 phase 1 complet")
        XCTAssertEqual(view.classifiedAd?.listingDescription, "2 phare xénon megane 2 phase 1 complet")
        XCTAssertEqual(view.classifiedAd?.price, 250.00)
        XCTAssertEqual(view.classifiedAd?.imagesURL.small, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/57a118ce39d6e40844a87f65b3eb3682e7b38c1d.jpg")
        XCTAssertEqual(view.classifiedAd?.imagesURL.thumb, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/57a118ce39d6e40844a87f65b3eb3682e7b38c1d.jpg")
        XCTAssertEqual(view.classifiedAd?.creationDate, date)
        XCTAssertEqual(view.classifiedAd?.isUrgent, true)
        XCTAssertEqual(view.classifiedAd?.siret, "893 432 877")

        XCTAssertEqual(view.categoryName, "Véhicule")
    }
}
