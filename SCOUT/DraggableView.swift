//
//  DraggableView.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//  Used by Mohammed Islubee & Sophie Kohrogi

import Foundation
import UIKit

let ACTION_MARGIN: Float = 120      //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
let SCALE_STRENGTH: Float = 4       //%%% how quickly the card shrinks. Higher = slower shrinking
let SCALE_MAX:Float = 0.93          //%%% upper bar for how much the card shrinks. Higher = shrinks less
let ROTATION_MAX: Float = 1         //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
let ROTATION_STRENGTH: Float = 320  //%%% strength of rotation. Higher = weaker rotation
let ROTATION_ANGLE: Float = 3.14/8  //%%% Higher = stronger rotation angle

protocol DraggableViewDelegate {
    func cardSwipedLeft(_ card: UIView) -> Void
    func cardSwipedRight(_ card: UIView) -> Void
}

class DraggableView: UIView {
    var delegate: DraggableViewDelegate!
    var panGestureRecognizer: UIPanGestureRecognizer!
    var originPoint: CGPoint!
    var overlayView: OverlayView!
    
    var username: UILabel!
    var email: UIButton!
    var userType: UILabel!
    
    let imageName = "super-mario-03.png"
    var imageView: UIImageView!
    
    var xFromCenter: Float!
    var yFromCenter: Float!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
       
        imageView = UIImageView()
        
        imageView?.frame = CGRect(x: 0, y: 0, width: 290, height: 300)
        self.addSubview(imageView!)
        
        username = UILabel(frame: CGRect(x: -90, y: 280, width: self.frame.size.width, height: 100))
        username.text = "no info given"
        username.textAlignment = NSTextAlignment.center
        username.textColor = UIColor(red:0.91, green:0.68, blue:0.68, alpha:1.0)

        self.backgroundColor = UIColor.white
        
        email = UIButton(frame: CGRect(x: 50, y: 295, width: self.frame.size.width, height: 100))
        email.setTitle("NO INFO", for: .normal)
        email.setTitleColor(UIColor(red:0.69, green:0.87, blue:0.88, alpha:1.0), for: .normal)
        
        userType = UILabel(frame: CGRect(x:-90 , y: 310, width: self.frame.size.width, height: 100))
        userType.text = "no info given"
        userType.textAlignment = NSTextAlignment.center
        userType.textColor = UIColor(red:0.91, green:0.68, blue:0.68, alpha:1.0)
        
        self.backgroundColor = UIColor.white

        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))

        self.addGestureRecognizer(panGestureRecognizer)
        self.addSubview(username)
        self.addSubview(email)
        self.addSubview(userType)

        overlayView = OverlayView(frame: CGRect(x: self.frame.size.width/2-100, y: 0, width: 100, height: 100))
        overlayView.alpha = 0
        self.addSubview(overlayView)

        xFromCenter = 0
        yFromCenter = 0
    }

    func setupView() -> Void {
        self.layer.cornerRadius = 4;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSize(width: 1, height: 1);
    }

    func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) -> Void {
        xFromCenter = Float(gestureRecognizer.translation(in: self).x)
        yFromCenter = Float(gestureRecognizer.translation(in: self).y)
        
        switch gestureRecognizer.state {
            
        case UIGestureRecognizerState.began:
            self.originPoint = self.center
            
        case UIGestureRecognizerState.changed:
            let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngle = ROTATION_ANGLE * rotationStrength
            let scale = max(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)

            self.center = CGPoint(x: self.originPoint.x + CGFloat(xFromCenter), y: self.originPoint.y + CGFloat(yFromCenter))

            let transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            let scaleTransform = transform.scaledBy(x: CGFloat(scale), y: CGFloat(scale))
            self.transform = scaleTransform
            self.updateOverlay(CGFloat(xFromCenter))
            
        case UIGestureRecognizerState.ended:
            self.afterSwipeAction()
            
        case UIGestureRecognizerState.possible:
            fallthrough
            
        case UIGestureRecognizerState.cancelled:
            fallthrough
            
        case UIGestureRecognizerState.failed:
            fallthrough
            
        default:
            break
        }
    }

    func updateOverlay(_ distance: CGFloat) -> Void {
        if distance > 0 {
            overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        } else {
            overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        }
        overlayView.alpha = CGFloat(min(fabsf(Float(distance))/100, 0.4))
    }

    func afterSwipeAction() -> Void {
        let floatXFromCenter = Float(xFromCenter)
        
        if floatXFromCenter > ACTION_MARGIN {
            
            self.rightAction()
            
        } else if floatXFromCenter < -ACTION_MARGIN {
            
            self.leftAction()
            
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.center = self.originPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.overlayView.alpha = 0
            })
        }
    }
    
    func rightAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: 500, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
       
        UIView.animate(withDuration: 0.3, animations: { self.center = finishPoint }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        
        delegate.cardSwipedRight(self)
    }

    func leftAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: -500, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
        }, completion: { (value: Bool) in
            self.removeFromSuperview()
        })
        
        delegate.cardSwipedLeft(self)
    }

    func rightClickAction() -> Void {
        let finishPoint = CGPoint(x: 600, y: self.center.y)
        
        UIView.animate(withDuration: 0.3, animations: {
                self.center = finishPoint
                self.transform = CGAffineTransform(rotationAngle: 1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        
        delegate.cardSwipedRight(self)
    }

    func leftClickAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: -600, y: self.center.y)
        
        UIView.animate(withDuration: 0.3, animations: {
                self.center = finishPoint
                self.transform = CGAffineTransform(rotationAngle: 1)
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        
        delegate.cardSwipedLeft(self)
    }
}
