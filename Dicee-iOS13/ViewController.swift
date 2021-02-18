//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Interface Builder Outlet
    // Don't rename the var name - Terminating app due to uncaught exception
    // <connections> in the interface builder source code
    // use refractor for renaming the var name
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var leftDieView: UIImageView!
    
    @IBOutlet weak var rightDieView: UIImageView!
    
    @IBOutlet weak var mainLogo: UIImageView!
    
    @IBOutlet weak var rollButtonView: UIButton!
    
    let diceFaces: [UIImage] = [
        #imageLiteral(resourceName: "DiceOne"),
        #imageLiteral(resourceName: "DiceTwo"),
        #imageLiteral(resourceName: "DiceThree"),
        #imageLiteral(resourceName: "DiceFour"),
        #imageLiteral(resourceName: "DiceFive"),
        #imageLiteral(resourceName: "DiceSix")
    ]
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // BACKGROUND VIEW
        setAutoConstraints(someView: backgroundView!, width: screenWidth, height: screenHeight, xOffset: 0, yOffset: 0, xRelative: false, yRelative: false, xLeading: true, yTop: true)
        
        // MAIN LOGO VIEW
        setAutoConstraints(someView: mainLogo!, width: screenWidth / 2, height: screenWidth / 3, xOffset: screenWidth / 2, yOffset: screenHeight / 18, xRelative: false, yRelative: true, xLeading: true, yTop: true)
        
        // LEFT DIE VIEW
        setAutoConstraints(someView: leftDieView!, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 18, yOffset: screenWidth / 18, xRelative: true, yRelative: false, xLeading: true, yTop: true)
        
        // RIGHT DIE VIEW
        setAutoConstraints(someView: rightDieView!, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 18, yOffset: screenWidth / 18, xRelative: true, yRelative: false, xLeading: false, yTop: true)
        
        // ROLL BUTTON VIEW
        setAutoConstraints(someView: rollButtonView!, width: screenWidth / 3, height: screenWidth / 6, xOffset: screenWidth / 3, yOffset: screenWidth / 9, xRelative: false, yRelative: true, xLeading: true, yTop: false)
    }

    // AUTO LAYOUT FUNCTION
    // Description: To set the constraints programatically by calling the funtion for every view in the IB.
    // Parameters description
    // 1. someView: UIView - This is the view for which you want to describe constraint
    // 2. width - Set the width of the view as a constraint
    // 3. height - Set the height of the view as a constraint
    // 4. xOffset - Set the offset from the leading side/ trailing side
    // 5. yOffset - Set the offset from the top side/ bottom side
    // 6. xRelative - If true, it sets the offset as the horizontal constraint. If false, it horizontally centers the view.
    // 7. yRelative - If true, it sets the offset as the vertical constraint. If false, it vertically centers the view.
    // 8. xLeading - If true, the xOffset is interpreted as from the leading side. If false, the xOffset is interpreted as from the trailing side.
    // 9. yTop - If true, the yOffset is interpreted as from the top side. If false, the yOffset is interpreted as from the bottom side.
    // Note: The xOffset and yOffset values should be non-negative, i.e., it should be >= 0
    func setAutoConstraints(someView: UIView, width: CGFloat, height: CGFloat, xOffset: CGFloat, yOffset: CGFloat, xRelative: Bool, yRelative: Bool, xLeading: Bool, yTop: Bool) {
        
        someView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(
           item: someView,
           attribute: NSLayoutConstraint.Attribute.width,
           relatedBy: NSLayoutConstraint.Relation.equal,
           toItem: nil,
           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
           multiplier: 1,
           constant: width
        )
        let heightConstraint = NSLayoutConstraint(
           item: someView,
           attribute: NSLayoutConstraint.Attribute.height,
           relatedBy: NSLayoutConstraint.Relation.equal,
           toItem: nil,
           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
           multiplier: 1,
           constant: height
        )
        var xConstraint = NSLayoutConstraint(
            item: someView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: view,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1,
            constant: 0
        )
        var yConstraint = NSLayoutConstraint(
            item: someView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: view,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0
        )
        if xRelative {
            if xLeading {
                xConstraint = NSLayoutConstraint(
                   item: someView,
                   attribute: NSLayoutConstraint.Attribute.leading,
                   relatedBy: NSLayoutConstraint.Relation.equal,
                   toItem: view,
                   attribute: NSLayoutConstraint.Attribute.leadingMargin,
                   multiplier: 1.0,
                   constant: xOffset
                )
            }
            else {
                xConstraint = NSLayoutConstraint(
                   item: someView,
                   attribute: NSLayoutConstraint.Attribute.trailing,
                   relatedBy: NSLayoutConstraint.Relation.equal,
                   toItem: view,
                   attribute: NSLayoutConstraint.Attribute.trailingMargin,
                   multiplier: 1.0,
                   constant: -xOffset
                )
            }
            
        }
        if yRelative {
            if yTop {
                yConstraint = NSLayoutConstraint(
                    item: someView,
                    attribute: NSLayoutConstraint.Attribute.top,
                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: view,
                    attribute: NSLayoutConstraint.Attribute.topMargin,
                    multiplier: 1.0,
                    constant: yOffset
                )
            }
            else {
                yConstraint = NSLayoutConstraint(
                    item: someView,
                    attribute: NSLayoutConstraint.Attribute.bottom,
                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: view,
                    attribute: NSLayoutConstraint.Attribute.bottomMargin,
                    multiplier: 1.0,
                    constant: -yOffset
                )
            }
            
        }
        view.addConstraints([widthConstraint, heightConstraint, xConstraint, yConstraint])
    }
    
    // Interface Builder Action
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        leftDieView.image = diceFaces.randomElement()
        rightDieView.image = diceFaces.randomElement()
    }
}

