//
//  RollClassifier.swift
//  Dicee-iOS13
//
//  Created by Carlton Schuyler on 3/14/21.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

class RollClassifier {

    enum Classification : Equatable, Comparable, Hashable {
        case cardinality(ofValue: Int, count: Int)
        case threeOfAKind(ofValue: Int)
        case fourOfAKind(ofValue: Int)
        case yahtzee(ofValue: Int)
        case fullHouse(twoOf: Int, threeOf: Int)
        case smallStraight(startingWith: Int)
        case largeStraight(startingWith: Int)
    }

    private let values: [Int]

    var classifications: Set<Classification> = []
    private var cardinalities : [Int : Int] = [:]

    init(_ values: Int...) {
        self.values = values
        classifyAll()
    }

    init(_ values: [Int]) {
        self.values = values
        classifyAll()
    }

    private func classifyExistenceAndCardinality() {
        for value in values {
            cardinalities[value] = (cardinalities[value] ?? 0) + 1
        }
        for countedNumber in cardinalities {
            classifications.insert(.cardinality(ofValue: countedNumber.key, count: countedNumber.value))
        }
    }

    private func classifyAll() {
        classifyExistenceAndCardinality()
        classify3OfAKind()
        classify4OfAKind()
        classifyYahtzee()
        classifyFullHouse()
        classifySmallStraight()
        classifyLargeStraight()
    }

    private func classify3OfAKind() {
        for cardinality in cardinalities {
            if cardinality.value >= 3 {
                classifications.insert(.threeOfAKind(ofValue: cardinality.key))
            }
        }
    }

    private func classify4OfAKind() {
        for cardinality in cardinalities {
            if cardinality.value >= 4 {
                classifications.insert(.fourOfAKind(ofValue: cardinality.key))
            }
        }
    }

    private func classifyYahtzee() {
        for cardinality in cardinalities {
            if cardinality.value >= 5 {
                classifications.insert(.yahtzee(ofValue: cardinality.key))
            }
        }
    }

    private func classifyFullHouse() {
        for twoOf in 1...6 {
            for threeOf in 1...6 {
                if twoOf != threeOf &&
                    classifications.contains(.cardinality(ofValue: twoOf, count: 2)) &&
                    classifications.contains(.cardinality(ofValue: threeOf, count: 3)) {

                    classifications.insert(.fullHouse(twoOf: twoOf, threeOf: threeOf))
                }
            }
        }
    }

    private func classifySmallStraight() {
        for startingWith in 1...3 {
            if cardinalities.keys.contains(startingWith) &&
                cardinalities.keys.contains(startingWith + 1) &&
                cardinalities.keys.contains(startingWith + 2) &&
                cardinalities.keys.contains(startingWith + 3) {

                classifications.insert(.smallStraight(startingWith: startingWith))
            }
        }
    }

    private func classifyLargeStraight() {
        for startingWith in 1...2 {
            if cardinalities.keys.contains(startingWith) &&
                cardinalities.keys.contains(startingWith + 1) &&
                cardinalities.keys.contains(startingWith + 2) &&
                cardinalities.keys.contains(startingWith + 3) &&
                cardinalities.keys.contains(startingWith + 4) {

                classifications.insert(.largeStraight(startingWith: startingWith))
            }
        }
    }
}
