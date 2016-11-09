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
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            borderView.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor() {
        didSet {
            borderView.layer.borderColor = borderColor.CGColor
        }
    }
    @IBInspectable var borderInset: CGFloat = 0.0 {
        didSet {
            borderView.frame = CGRect(
                x: borderInset,
                y: borderInset,
                width: self.frame.width - borderInset * 2,
                height: self.frame.height - borderInset * 2)
            borderView.layer.cornerRadius = borderView.frame.width / 2
        }
    }
    @IBInspectable var rippleOutset: CGFloat = 0.0
    @IBInspectable var rippleDuration: Float = 3.0
    @IBInspectable var rippleMinInterval: Float = 0.0
    @IBInspectable var rippleMaxInterval: Float = 1.5
    @IBInspectable var rippleMinBorderWidth: Float = 1.0
    @IBInspectable var rippleMaxBorderWidth: Float = 4.5
    
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
        self.clipsToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        
        // Add borderView
        self.addSubview(borderView)
        
        // add the first ripple
        addSubRipple()
    }
    
    private func resetTimer() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(
            NSTimeInterval(randomFloat(min: rippleMinInterval, max: rippleMaxInterval)),
            target: self, selector: #selector(RippleView.addSubRipple), userInfo: nil, repeats: false)
    }
    
    @objc private func addSubRipple() {
        let subRippleView = UIView()
        
        // add ripple
        subRippleView.frame = CGRect(
            x: rippleOutset * -1,
            y: rippleOutset * -1,
            width: self.frame.width + rippleOutset * 2,
            height: self.frame.height + rippleOutset * 2)
        
        subRippleView.layer.borderWidth = CGFloat(randomFloat(min: rippleMinBorderWidth, max: rippleMaxBorderWidth))
        subRippleView.layer.borderColor = self.backgroundColor?.CGColor
        
        self.addSubview(subRippleView)
        
        // set ripple animation
        subRippleView.alpha = 0.0
        UIView.animateWithDuration(NSTimeInterval(rippleDuration), delay: 0, options: .CurveEaseInOut, animations: {
            subRippleView.frame = self.bounds
            subRippleView.alpha = 1.0
        }) { (finished) in
            UIView.animateWithDuration(0.5, animations: {
                subRippleView.alpha = 0.0
            }, completion: { (finished) in
                subRippleView.removeFromSuperview()
            })
        }
        
        // animation for layer
        let layerAnim = CABasicAnimation(keyPath: "cornerRadius")
        layerAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layerAnim.fromValue = (self.frame.width + rippleOutset * 2) / 2
        layerAnim.toValue = self.frame.width / 2
        layerAnim.duration = CFTimeInterval(rippleDuration)
        subRippleView.layer.cornerRadius = self.frame.width / 2
        subRippleView.layer.addAnimation(layerAnim, forKey: "cornerRadius")
        
        
        // reset timer to add next ripple
        resetTimer()
    }
    
    private func randomFloat(min min:Float, max: Float) -> Float {
        return Float(arc4random_uniform(UInt32((max - min) * 100)) + 1) / 100 + min
    }
}
