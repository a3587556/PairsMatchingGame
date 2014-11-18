//
//  CardView.swift
//  PairsMatchingGame
//
//  Created by darkgod on 14/11/14.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//

import UIKit

private let backImage = UIImage(named: "back")!.CGImage
class CardView: UIControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var frontLayer: CALayer!
    var backLayer: CALayer!
    var card: Card? {
        didSet {
            let imgName = self.card!.imageName()
            let img = UIImage(named: imgName)!.CGImage
            self.frontLayer.contents = img
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // TODO: set background color
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override var selected: Bool {
        didSet {
            updateSide()
        }
    }
    
    

    func setup() {
        // shared initialization code here
        //self.layer.backgroundColor = UIColor.grayColor().CGColor
        //self.backgroundColor = UIColor.grayColor()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).CGColor
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.layer.bounds = CGRect(x: 2.0, y: 2.0, width: 61.0, height: 76.0)
        
        self.frontLayer = CALayer()
        //self.frontLayer.contents = UIImage(named: Card.random().imageName())!.CGImage
        //self.frontLayer.contents = UIImage(named: "ace_of_spades")!.CGImage
        self.frontLayer.frame = CGRect(x: 4.0, y: 4.0, width: 61.0, height: 76.0)
        
        self.layer.addSublayer(self.frontLayer)
        
        self.backLayer = CALayer()
        self.backLayer.contents = UIImage(named: "back")!.CGImage//backImage
        self.backLayer.frame = CGRect(x: 4.0, y: 4.0, width: 61.0, height: 76.0)
        self.layer.addSublayer(self.backLayer)
        
        updateSide()
    }
    
    func showFront() {
        self.frontLayer.hidden = false
        self.backLayer.hidden = true
    }
    
    func showBack() {
        self.frontLayer.hidden = true
        self.backLayer.hidden = false
    }
    
    func updateSide() {
        if(self.selected == true) {
            self.showFront()
            //setNeedsDisplay()
        }
        else {
            showBack()
            //setNeedsDisplay()
        }
        
    }
}
