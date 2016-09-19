//
//  CurveView.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/18/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class CurveView: UIView
{
    // these may not be necessary
    var topLeftCorner: CGPoint?
    var topRightCorner: CGPoint?
    var bottomRightCorner: CGPoint?
    var bottomLeftCorner: CGPoint?
    
    var currentCurveMode: BezierCurveMode = BezierCurveMode.quadratic
    
    var controlPoints = [ControlPointView]()
    
    let controlPointSize: CGSize = CGSize(width: 10, height: 10)
    
    public enum BezierCurveMode: Int
    {
        case quadratic = 3, cubic = 4
    }
    
    func setup()
    {
        self.currentCurveMode = BezierCurveMode.quadratic
        
        self.createControlPoints()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        
        self.setGeometry()
        
        drawViewBoundary(rect: rect)
        
        drawBezierCurve(rect: rect)
    }
    
    func drawViewBoundary(rect: CGRect)
    {
        let viewBoundary: UIBezierPath = UIBezierPath(rect: self.bounds)
        viewBoundary.lineWidth = 2
        viewBoundary.lineCapStyle = CGLineCap.round
        UIColor.black.setStroke()
        viewBoundary.stroke()
    }
    
    func drawBezierCurve(rect: CGRect)
    {
        let bezierCurve: UIBezierPath = UIBezierPath()
        
        // start drawing at the first control point
        bezierCurve.move(to: controlPoints[0].center)
        
        // add the curve depending on the mode
        switch currentCurveMode
        {
            case .quadratic:
                bezierCurve.addQuadCurve(to: controlPoints.last!.center, controlPoint: controlPoints[1].center)
            
            case .cubic:
                bezierCurve.addCurve(to: controlPoints.last!.center, controlPoint1: controlPoints[1].center, controlPoint2: controlPoints[2].center)
        }
        
        bezierCurve.lineWidth = 3
        bezierCurve.lineCapStyle = CGLineCap.round
        UIColor.black.setStroke()
        bezierCurve.stroke()
    }
 
    // if the corner points are not necessary, this function may be removed
    func setGeometry()
    {
        topLeftCorner = bounds.origin
        topRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y)
        bottomRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y + bounds.height)
        bottomLeftCorner = CGPoint(x: bounds.origin.x, y: bounds.origin.y + bounds.height)
    }
    
    func createControlPoints()
    {
        for index in 0..<currentCurveMode.rawValue
        {
            controlPoints.append(ControlPointView(frame: CGRect(origin: CGPoint(x: 100 * index, y: 100 * index), size: controlPointSize)))
            
            self.addSubview(controlPoints[index])
        }
        
        self.setNeedsDisplay()
    }
    
    func removeControlPoints()
    {
        for controlPoint in controlPoints
        {
            controlPoint.removeFromSuperview()
        }
        
        controlPoints.removeAll()
    }
    
    func changeCurveMode(to: BezierCurveMode)
    {
        currentCurveMode = to
        
        removeControlPoints()
        
        createControlPoints()
    }
}
