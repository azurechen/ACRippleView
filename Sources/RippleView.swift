//
//  RippleView.swift
//  LoveNuts
//
//  Created by Azure Chen on 8/28/16.
//  Copyright © 2016 Azure Chen. All rights reserved.
//

import UIKit

@IBDesignable
public class RippleView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor()
    @IBInspectable var borderInset: CGFloat = 0.0
    @IBInspectable var rippleOutset: CGFloat = 0.0
    @IBInspectable var rippleMaxInterval: Float = 1.0
    @IBInspectable var rippleSpeed: Float = 1.0
    
    private let borderView = UIView()
    private var timer = NSTimer()
    
    // MARK: Init
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override public func prepareForInterfaceBuilder() {
        initialize()
    }
    
    private func initialize() {
        // Add borderView
        self.addSubview(borderView)
    }
    
    override public func layoutSubviews() {
        self.clipsToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        
        borderView.frame = CGRect(
            x: borderInset,
            y: borderInset,
            width: self.bounds.width - borderInset * 2,
            height: self.bounds.height - borderInset * 2)
        borderView.layer.borderWidth = borderWidth
        borderView.layer.borderColor = borderColor.CGColor
        borderView.layer.cornerRadius = borderView.frame.width / 2
        
        resetTimer()
    }
    
    private func resetTimer() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(
            NSTimeInterval(randomFloat(rippleMaxInterval)),
            target: self, selector: #selector(RippleView.addSubRipple), userInfo: nil, repeats: false)
    }
    
    @objc private func addSubRipple() {
        let subRippleView = UIView()
        
        subRippleView.frame = CGRect(
            x: rippleOutset * -1,
            y: rippleOutset * -1,
            width: self.frame.width + rippleOutset * 2,
            height: self.frame.height + rippleOutset * 2)
        subRippleView.layer.borderWidth = 3
        subRippleView.layer.borderColor = self.backgroundColor?.CGColor
        subRippleView.layer.cornerRadius = subRippleView.frame.width / 2
        
        self.addSubview(subRippleView)
        resetTimer()
    }
    
    private func randomFloat(max: Float) -> Float {
        return Float(arc4random_uniform(UInt32(max * 100)) + 1) / 100
    }
}
