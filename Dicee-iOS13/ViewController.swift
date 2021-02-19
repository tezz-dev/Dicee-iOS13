//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwiftUI


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var leftDie = UIHostingController(rootView: DiceView(number: [1, 2, 3, 4, 5, 6].randomElement()!, width: screenWidth / 3, height: screenWidth / 3))
var rightDie = UIHostingController(rootView: DiceView(number: [1, 2, 3, 4, 5, 6].randomElement()!, width: screenWidth / 3, height: screenWidth / 3))

class ViewController: UIViewController {

    // Interface Builder Outlet
    // Don't rename the var name - Terminating app due to uncaught exception
    // <connections> in the interface builder source code
    // use refractor for renaming the var name
    
    var isLightMode = true
    
    var rollButtonView = UIButton()
    
    var titleLabel = UILabel()
    var descLabel = UILabel()
    var footNoteLabel = UILabel()
    
    var leftDieView = leftDie.view!
    var rightDieView = rightDie.view!
    
    var contrastModeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwiftUIView(leftDie)
        setSwiftUIView(rightDie)

        
        // Title Label
        setTitleLabel()
        
        // Desc Label
        setDescLabel()
        
        // FootNote Label
        setFootNoteLabel()
        
        // LEFT DIE VIEW
        setAutoConstraints(someView: leftDie.view, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 12, yOffset: 0, xRelative: true, yRelative: false, xLeading: true, yTop: true)
        
        
        // RIGHT DIE VIEW
        setAutoConstraints(someView: rightDie.view, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 12, yOffset: 0, xRelative: true, yRelative: false, xLeading: false, yTop: true)
        
        // Roll Button View
        rollButtonView = createButton(title: "Roll", backgroundColor: .darkGray)
        self.view.addSubview(rollButtonView)
        setAutoConstraints(someView: rollButtonView, width: screenWidth / 3, height: screenWidth / 6, xOffset: 0.0, yOffset: screenHeight / 5, xRelative: false, yRelative: true, xLeading: true, yTop: false)
        rollButtonView.addTarget(self, action: #selector(rollButtonPressed(_:)), for: .touchUpInside)
        
        // Contrast Mode
        updateContrastModeButton()
    }

    func createButton(title: String, backgroundColor: UIColor) -> UIButton {
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width - 32
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel!.font = UIFont(name: "AvenirNext-Bold", size: screenWidth / 10 - 5)
        button.setTitleColor(isLightMode ? UIColor.white : UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = isLightMode ? UIColor.white.cgColor : UIColor.black.cgColor
        return button
    }
    
    fileprivate func setTitleLabel() {
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width - 32
        let screenHeight = view.safeAreaLayoutGuide.layoutFrame.height - 32
        
        titleLabel.text = "diceey"
        titleLabel.textColor = isLightMode ? .darkGray : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: screenWidth / 10 + 1)
        titleLabel.textAlignment = .right
        self.view.addSubview(titleLabel)
        setAutoConstraints(someView: titleLabel, width: screenWidth, height: screenHeight / 8, xOffset: 0.0, yOffset: 0.0, xRelative: true, yRelative: true, xLeading: true, yTop: true)
    }
    
    fileprivate func setDescLabel() {
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width - 32
        let screenHeight = view.safeAreaLayoutGuide.layoutFrame.height - 32
        
        descLabel.text = "true randomness\ndoes't feel random\nto humans"
        descLabel.numberOfLines = 3
        descLabel.textColor = isLightMode ? .darkGray : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        descLabel.font = UIFont(name: "AvenirNext-Bold", size: screenWidth / 18 + 1)
        descLabel.textAlignment = .center
        self.view.addSubview(descLabel)
        setAutoConstraints(someView: descLabel, width: screenWidth, height: screenHeight / 6, xOffset: 0.0, yOffset: screenHeight / 8, xRelative: true, yRelative: true, xLeading: true, yTop: true)
    }
    
    fileprivate func setFootNoteLabel() {
        
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width - 32
        let screenHeight = view.safeAreaLayoutGuide.layoutFrame.height - 32
        
        footNoteLabel.text = "made by tezz-io"
        footNoteLabel.textColor = .darkGray
        footNoteLabel.font = UIFont(name: "AvenirNext-Bold", size: screenWidth / 20 + 1)
        footNoteLabel.textAlignment = .center
        self.view.addSubview(footNoteLabel)
        setAutoConstraints(someView: footNoteLabel, width: screenWidth, height: screenHeight / 12, xOffset: 0.0, yOffset: 0.0, xRelative: true, yRelative: true, xLeading: true, yTop: false)
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
    
    
    fileprivate func setSwiftUIView(_ child: UIHostingController<DiceView>) {
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = self.view.bounds
        // First, add the view of the child to the view of the parent
        self.view.addSubview(child.view)
        // Then, add the child to the parent
        self.addChild(child)
    }
    
    @objc func rollButtonPressed(_ sender: UIButton!) {
        
        leftDie.view.removeFromSuperview()
        rightDie.view.removeFromSuperview()
        
        leftDie = UIHostingController(rootView: DiceView(number: [1, 2, 3, 4, 5, 6].randomElement()!, width: screenWidth / 3, height: screenWidth / 3))
        rightDie = UIHostingController(rootView: DiceView(number: [1, 2, 3, 4, 5, 6].randomElement()!, width: screenWidth / 3, height: screenWidth / 3))
        
        
        setSwiftUIView(leftDie)
        setSwiftUIView(rightDie)
        
        // LEFT DIE VIEW
        setAutoConstraints(someView: leftDie.view, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 12, yOffset: 0, xRelative: true, yRelative: false, xLeading: true, yTop: true)
        
        
        // RIGHT DIE VIEW
        setAutoConstraints(someView: rightDie.view, width: screenWidth / 3, height: screenWidth / 3, xOffset: screenWidth / 12, yOffset: 0, xRelative: true, yRelative: false, xLeading: false, yTop: true)
        
   }
    
    func updateContrastModeButton() {
        let screenHeight = view.safeAreaLayoutGuide.layoutFrame.height - 32
        
        contrastModeButton.setImage(UIImage(systemName: isLightMode ? "moon.fill" : "sun.max.fill"), for: .normal)
        contrastModeButton.imageView?.tintColor = isLightMode ? .white : .black
        contrastModeButton.backgroundColor = isLightMode ? .black : .white
        contrastModeButton.layer.cornerRadius = screenHeight / 16 * 0.45
        contrastModeButton.clipsToBounds = true
        contrastModeButton.addTarget(self, action: #selector(contrastModeToggled(_:)), for: .touchUpInside)
        
        self.view.addSubview(contrastModeButton)
        setAutoConstraints(someView: contrastModeButton, width: screenHeight / 16, height: screenHeight / 16, xOffset: 0.0, yOffset: screenHeight / 32, xRelative: true, yRelative: true, xLeading: true, yTop: true)
    }
    
    @objc func contrastModeToggled(_ sender: UIButton) {
        self.isLightMode.toggle()
        overrideUserInterfaceStyle = isLightMode ? .light : .dark
        self.view.backgroundColor = isLightMode ? .white : .black
        
        titleLabel.textColor = isLightMode ? .darkGray : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        descLabel.textColor = isLightMode ? .darkGray : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        footNoteLabel.textColor = isLightMode ? .darkGray : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        contrastModeButton.setImage(UIImage(systemName: isLightMode ? "moon.fill" : "sun.max.fill"), for: .normal)
        contrastModeButton.imageView?.tintColor = isLightMode ? .white : .black
        contrastModeButton.backgroundColor = isLightMode ? .black : .white
            
        rollButtonView.layer.borderColor = isLightMode ? UIColor.white.cgColor : UIColor.black.cgColor
        }
}


struct DiceView: View {
    @State var number: Int
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
            switch number {
            case 1:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        Circle().frame(width: width / 4, height: height / 5, alignment: .center)
                            .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
            case 2:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        VStack {
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .leading)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                    .opacity(0)
                            }
                            .frame(width: 76, alignment: .center)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .trailing)
                        }
                        .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
            case 3:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        VStack {
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .leading)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .center)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .trailing)
                        }
                        .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
                
            case 4:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        VStack {
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .leading)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                    .opacity(0)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                    .opacity(0)
                            }
                            .frame(width: 76, alignment: .center)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .trailing)
                        }
                        .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
                
            case 5:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        VStack {
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .leading)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .center)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .trailing)
                        }
                        .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
                
            case 6:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        VStack {
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .leading)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .center)
                            HStack {
                                Circle().frame(width: 20, height: 20, alignment: .center)
                                Spacer()
                                Circle().frame(width: 20, height: 20, alignment: .center)
                            }
                            .frame(width: 76, alignment: .trailing)
                        }
                        .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
            default:
                Rectangle()
                    .frame(width: width, height: height, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(
                        Circle().frame(width: width / 5, height: height / 5, alignment: .center)
                            .foregroundColor(.white)
                    )
                    .cornerRadius(15.0)
    }
}
}
