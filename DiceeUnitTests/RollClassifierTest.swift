//
//  RollClassifierTest.swift
//  Dicee-iOS13
//
//  Created by Carlton Schuyler on 3/13/21.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import XCTest

class RollClassifierTest: XCTestCase {

    func test_justNumbers() throws {
        let classifier = RollClassifier(1, 2, 3, 4, 4)
        XCTAssertTrue(Array(classifier.classifications)
                        .containsAll(
                            [.cardinality(ofValue: 1, count: 1),
                             .cardinality(ofValue: 2, count: 1),
                             .cardinality(ofValue: 3, count: 1),
                             .cardinality(ofValue: 4, count: 2)]
                        ))
    }

    func test_threeOfAKind() throws {
        let classifier = RollClassifier(1, 2, 4, 1, 1)
        XCTAssertTrue(classifier.classifications.contains(.threeOfAKind(ofValue: 1)))
    }

    func test_fourOfAKind() throws {
        let classifier = RollClassifier(1, 1, 4, 1, 1)
        XCTAssertTrue(classifier.classifications.contains(.fourOfAKind(ofValue: 1)))
        // And also these
        XCTAssertTrue(classifier.classifications.contains(.threeOfAKind(ofValue: 1)))
    }

    func test_yahtzee() throws {
        let classifier = RollClassifier(1, 1, 1, 1, 1)
        XCTAssertTrue(classifier.classifications.contains(.yahtzee(ofValue: 1)))
        // And also these
        XCTAssertTrue(classifier.classifications.contains(.fourOfAKind(ofValue: 1)))
        XCTAssertTrue(classifier.classifications.contains(.threeOfAKind(ofValue: 1)))
    }

    func test_fullHouse() throws {
        let classifier = RollClassifier(1, 1, 2, 2, 2)
        XCTAssertTrue(classifier.classifications.contains(.fullHouse(twoOf: 1, threeOf: 2)))
        // And also these
        XCTAssertTrue(classifier.classifications.contains(.threeOfAKind(ofValue: 2)))
    }

    func test_smallStraight() throws {
        let classifier = RollClassifier(1, 2, 3, 4, 2)
        XCTAssertTrue(classifier.classifications.contains(.smallStraight(startingWith: 1)))
    }

    func test_largeStraight() throws {
        let classifier = RollClassifier(1, 2, 3, 4, 5)
        XCTAssertTrue(classifier.classifications.contains(.largeStraight(startingWith: 1)))
        // And also these
        XCTAssertTrue(classifier.classifications.contains(.smallStraight(startingWith: 1)))
        XCTAssertTrue(classifier.classifications.contains(.smallStraight(startingWith: 2)))
    }
}

extension Array where Element: Comparable {
    func containsAll(_ elements: [Element]) -> Bool {
        for element in elements {
            if !self.contains(element) {
                return false
            }
        }
        return true
    }
}

