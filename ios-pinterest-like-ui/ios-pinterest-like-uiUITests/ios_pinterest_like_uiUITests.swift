//
//  ios_pinterest_like_uiUITests.swift
//  ios-pinterest-like-uiUITests
//
//  Created by YukiOkudera on 2018/05/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

@testable import ios_pinterest_like_ui
import XCTest

final class ios_pinterest_like_uiUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCustomTransition() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells

        cellsQuery.otherElements.containing(.staticText, identifier:"リス").element.tap()
        
        let closeButton = app.buttons["　×　"]
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"豚").element.tap()
        closeButton.tap()
        
        cellsQuery.otherElements.containing(.staticText, identifier:"うさぎ").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"レッサーパンダ").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"パンダ").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"犬").element.tap()
        closeButton.tap()

        // swipeUp
        collectionViewsQuery.element.swipeUp()

        cellsQuery.otherElements.containing(.staticText, identifier:"猫").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"ホワイトタイガー").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"カエル").element.tap()
        closeButton.tap()

        cellsQuery.otherElements.containing(.staticText, identifier:"ペンギン").element.tap()
        closeButton.tap()
    }
    
}
