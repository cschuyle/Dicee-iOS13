//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var die1ImageView: UIImageView!
    @IBOutlet weak var die2ImageView: UIImageView!
    @IBOutlet weak var die3ImageView: UIImageView!
    @IBOutlet weak var die4ImageView: UIImageView!
    @IBOutlet weak var die5ImageView: UIImageView!
    @IBOutlet weak var rollResultLabel: UILabel!
    
    @IBOutlet weak var rollButton: UIButton!

    var rolledValues : [Int] = [1, 1, 1, 1, 1]

    lazy var rolledImageViews : [UIImageView] =
        [die1ImageView!, die2ImageView!, die3ImageView!, die4ImageView!, die5ImageView!]

    override func viewDidLoad() {
        super.viewDidLoad()

        for die in rolledImageViews {
            die.image = Images.die1;
            die.alpha = 0.9
        }
    }

    @IBAction func rollButtonTapped(_ sender: Any) {
        for dieIndex in 0..<(rolledValues.count) {
            let valueRolled = Int.random(in: 1...6)
            recordDieRoll(dieIndex, valueRolled)
        }
        let classifier = RollClassifier(rolledValues)
        for classification in classifier.classifications {
            switch classification {
            case .yahtzee(ofValue: _):
                rollResultLabel.text = "Yahtzee!"
                break
            case .largeStraight(startingWith: _):
                rollResultLabel.text = "Large Straight"
                break
            case .smallStraight(startingWith: _):
                rollResultLabel.text = "Small Straight"
                break
            case .fullHouse(twoOf: _, threeOf: _):
                rollResultLabel.text = "Full House"
                break
            case .fourOfAKind(ofValue: _):
                rollResultLabel.text = "Four of a Kind"
                break
            case .threeOfAKind(ofValue: _):
                rollResultLabel.text = "Three of a Kind"
                break
            case .cardinality(ofValue: let value, count: let count):
                rollResultLabel.text = "\(count) \(value)s"
            }
        }
    }

    fileprivate func recordDieRoll(_ dieIndex: Int, _ valueRolled: Int) {
        rolledValues[dieIndex] = valueRolled

        rolledImageViews[dieIndex].image = Images.diceImages[valueRolled - 1];
        rolledImageViews[dieIndex].alpha = 0.9
    }
}

