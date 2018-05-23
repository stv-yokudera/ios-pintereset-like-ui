//
//  PhotoDataSourceTests.swift
//  ios-pinterest-like-uiTests
//
//  Created by YukiOkudera on 2018/05/23.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

@testable import ios_pinterest_like_ui
import XCTest

final class PhotoDataSourceTests: XCTestCase {
    
    func testLoadPhotos() {

        let loadResult = PhotoDataSource.loadPhotos()

        XCTAssertEqual(loadResult.count, 10)
        XCTAssertEqual(loadResult.first?.caption, "リス")
        XCTAssertEqual(loadResult.first?.comment, "リス（栗鼠）は、ネズミ目(齧歯目)リス科に属する動物の総称である。")
    }
}
