//
//  ControlPointView.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/18/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ControlPointView: UIView
{


    func setup()
    {
        // size of the view can be set by the caller
        
        // create and bind the gesture recognizer programmatically
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.translateOnPan))
        
        // add the new gesture recognizer to the
        self.gestureRecognizers = [panGestureRecognizer]
        
        // make the background transparent
        self.isOpaque = false
        self.backgroundColor = UIColor.white.withAlphaComponent(0.0)
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setup()
    }
    
    // this is strange - functions can be optional!
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        UIColor.blue.setStroke()
        UIColor.blue.withAlphaComponent(0.0).setFill()
        
        let controlPointCircle: UIBezierPath = UIBezierPath(ovalIn: rect)
        controlPointCircle.lineWidth = 2
        controlPointCircle.addClip()
        controlPointCircle.fill()
        controlPointCircle.stroke()
        
        // Problem: only the first ControlPointView drawn in the CurveView gets this center dot
        //          Now that initial locations are randomized, the dots don't draw at all
        UIColor.blue.setFill()
        let controlPointDot: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: self.center.x - 2.5, y: self.center.y - 2.5, width: 5, height: 5))
        controlPointDot.fill()
        controlPointDot.stroke()
    }
    
    func translateOnPan(recognizer: UIPanGestureRecognizer)
    {
        // since each ControPointView has its own method for panning, no need to generalize like in the viewController
        
        let translation = recognizer.translation(in: self)
        let xTranslation: CGFloat
        let yTranslation: CGFloat
        
        // if (left edge will move outside bounds) || (right edge will move outside bounds)
        if (((self.center.x - self.bounds.width/2) + translation.x) <= superview!.bounds.minX) || (((self.center.x + self.bounds.width/2) + translation.x) >= superview!.bounds.maxX)
        {
            xTranslation = 0
        }
        else
        {
            xTranslation = translation.x
        }
        
        // if (top edge will move outside bounds) || (bottom edge will move outside bounds)
        if (((self.center.y - self.bounds.height/2) + translation.y) <= superview!.bounds.minY) || (((self.center.y + self.bounds.height/2) + translation.y) >= superview!.bounds.maxY)
        {
            yTranslation = 0
        }
        else
        {
            yTranslation = translation.y
        }

        
        // just move the point already
        self.center = CGPoint(x: self.center.x + xTranslation, y: self.center.y + yTranslation)
        
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
        
        // alert that the superview needs to be redrawn
        superview!.setNeedsDisplay()
    }

}
