//
//  HUD_Button.swift
//  Custom UIs
//
//  Created by QUANG on 6/20/17.
//  Copyright © 2017 Superior Future. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


let buttonSizeRatio = 0.25

let buttonDefaultSize: CGFloat = CGFloat(Double(screenWidth) * buttonSizeRatio)

var defaultImage = UIImage.init(named: "default")
var defaultText = "CHECK PICTURES"

@IBDesignable
class HUD_Button: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = buttonDefaultSize / 7 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var size: CGFloat = buttonDefaultSize {
        didSet {
            self.frame.size = CGSize(width: size, height: size)
        }
    }
    
    @IBInspectable var logo: UIImage = defaultImage! {
        didSet {
            defaultImage = logo
        }
    }
    
    @IBInspectable var text: String = defaultText.uppercased() { //MAX: 14 char
        didSet {
            defaultText = text.uppercased()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        self.frame.size = CGSize(width: size, height: size)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = UIColor.clear
        
        //Set up backgound View
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = backgroundColor
            view.frame = CGRect(x: 0, y: 0, width: size, height: size)
            view.isUserInteractionEnabled = false
            
            return view
        }()
        
        //Set up logo View
        let logoView: UIImageView = {
            let view = UIImageView()
            let imgSize = size - (2 * size / 5)
            
            view.image = defaultImage
            view.tintColor = UIColor.white
            view.frame.size = CGSize(width: imgSize, height: imgSize)
            view.frame = CGRect(x: (size - imgSize) / 2, y: size / 10, width: imgSize, height: imgSize * 9 / 10)
            view.isUserInteractionEnabled = false
            view.contentMode = UIViewContentMode.scaleAspectFit
            view.backgroundColor = UIColor.clear
            
            return view
        }()
        
        //Set up text view
        let textView: UILabel = {
            let view = UILabel()

            view.text = defaultText
            view.adjustsFontSizeToFitWidth = true
            view.backgroundColor = UIColor.clear
            view.textColor = UIColor.white
            view.frame = CGRect(x: 4, y: 0, width: size - 8, height: (size / 4) - 8)
            view.textAlignment = .center
            //TODO: RUNNING TEXT IF LONG
            
            return view
        }()
        let secretView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: size / 4 * 3, width: size, height: size / 4)
            view.backgroundColor = UIColor.white.withAlphaComponent(0.09)
            return view
        }()
        
        self.addSubview(backgroundView)
        self.addSubview(logoView)
        self.addSubview(secretView)
        secretView.addSubview(textView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onPress))
        self.addGestureRecognizer(tap)
    }
    
    func onPress() {
        print("Pressed")
    }

}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
