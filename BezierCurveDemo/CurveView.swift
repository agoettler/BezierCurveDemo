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
    var currentCurveMode: BezierCurveMode = BezierCurveMode.quadratic
    
    var currentBoundingBoxMode: Bool = true
    
    var controlPoints = [ControlPointView]()
    
    let controlPointSize: CGSize = CGSize(width: 30, height: 30)
    
    public enum BezierCurveMode: Int
    {
        case quadratic = 3, cubic = 4
    }
    
    func setup()
    {
        self.currentCurveMode = BezierCurveMode.quadratic
        
        self.createControlPoints()
    }
    
    func startUp(initialCurveMode: BezierCurveMode, initialBoundingBoxActivity: Bool)
    {
        // not a true initializer, but called by viewDidLoad
        // sets drawing modes to match the initial settings of the UI controls
        
        currentCurveMode = initialCurveMode
        
        currentBoundingBoxMode = initialBoundingBoxActivity
        
        self.setNeedsDisplay()
        
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
        
        drawViewBoundary(rect: rect)
        
        drawBezierCurve(rect: rect)
        
        if currentBoundingBoxMode
        {
            drawConvexHull(rect: rect)
        }
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
        bezierCurve.move(to: controlPoints.first!.center)
        
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
    
    func drawConvexHull(rect: CGRect)
    {
        // Warning to mathematicians: hull may not actually be convex
        
        let convexHull: UIBezierPath = UIBezierPath()
        
        convexHull.move(to: controlPoints.first!.center)
        
        for index in 1..<controlPoints.count
        {
            convexHull.addLine(to: controlPoints[index].center)
        }
        
        convexHull.close()
        
        convexHull.lineWidth = 3
        UIColor.gray.setStroke()
        
        // try making the dashes dots instead
        // http://stackoverflow.com/questions/26018302/draw-dotted-not-dashed-line
        // now that's cool
        
        let dashes: [CGFloat] = [convexHull.lineWidth * 0, convexHull.lineWidth * 2]
        convexHull.setLineDash(dashes, count: dashes.count, phase: 1)
        convexHull.lineCapStyle = CGLineCap.round
        
        convexHull.stroke()
    }
 
    func createControlPoints()
    {
        for index in 0..<currentCurveMode.rawValue
        {
            // randomize the position of the new points
            // Problem: on startup, the points are often placed outside of the CurveView
            //          probably an issue with initialization
            let newXValue: CGFloat = CGFloat( Int( arc4random() ) % Int(self.bounds.width - controlPointSize.width) )
            
            let newYValue: CGFloat = CGFloat( Int( arc4random() ) % Int(self.bounds.height - controlPointSize.height) )
            
            let newOriginPoint: CGPoint = CGPoint(x: newXValue, y: newYValue)
            
            controlPoints.append(ControlPointView(frame: CGRect(origin: newOriginPoint, size: controlPointSize)))
            
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
    
    func changeConvexHullDrawing(to: Bool)
    {
        currentBoundingBoxMode = to
        
        self.setNeedsDisplay()
    }
}
