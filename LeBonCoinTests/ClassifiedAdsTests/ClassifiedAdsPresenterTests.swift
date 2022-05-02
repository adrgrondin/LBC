//
//  ClassifiedAdsPresenterTests.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 02/05/2022.
//

import XCTest
@testable import LeBonCoin

class ClassifiedAdsPresenterTests: XCTestCase {
    var presenter: ClassifiedAdsPresenter!

    override func setUpWithError() throws {
        presenter = ClassifiedAdsPresenter(fetchService: FetchServiceMock())
    }

    func testAttach() throws {
        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        XCTAssertNotNil(presenter.view)
    }

    func testFetching() throws {
        XCTAssertTrue(presenter.listing.isEmpty)
        XCTAssertTrue(presenter.categories.isEmpty)

        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        let expectation = expectation(description: "Wait for fetching")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(presenter.listing.isEmpty)
            XCTAssertFalse(presenter.categories.isEmpty)
        } else {
            XCTFail("Presenter did finish fetching")
        }
    }

    func testUpdateDataSource() throws {
        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        let expectation = expectation(description: "Wait for fetching")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(view.updateDataSourceCalled)
        } else {
            XCTFail("Presenter did finish fetching")
        }
    }

    func testSortedByDate() throws {
        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        let expectation = expectation(description: "Wait for fetching")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            let firstClassifiedAd = presenter.listing.first!
            let lastClassifiedAd = presenter.listing.last!

            XCTAssertTrue(firstClassifiedAd.creationDate.compare(lastClassifiedAd.creationDate) == .orderedDescending)
        } else {
            XCTFail("Presenter did finish fetching")
        }
    }

    func testSortedByIsUrgent() throws {
        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        let expectation = expectation(description: "Wait for fetching")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            let firstClassifiedAd = presenter.listing.first!

            XCTAssertTrue(firstClassifiedAd.isUrgent)
        } else {
            XCTFail("Presenter did finish fetching")
        }
    }

    func testFilteredCategory() throws {
        let view = ClassifiedAdsViewMock()
        presenter.attach(view: view)

        let expectation = expectation(description: "Wait for fetching")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            presenter.didSelectCategory(Category(id: 1, name: ""))

            let hasCategory1 = view.listing.contains(where: { $0.categoryID != 1})

            XCTAssertFalse(hasCategory1)
        } else {
            XCTFail("Presenter did finish fetching")
        }
    }
}
