//
//  ViewController.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/17/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

/*
 Optional To Do:
    ? Make the control points transparent and prettier - has issues
    x Draw the convex hull
    x Toggle the convex hull
    x Randomize the initial positions of the control points
*/

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var BezierCurveDisplay: CurveView!
    
    @IBOutlet weak var boundingBoxToggleSwitch: UISwitch!
    
    @IBOutlet weak var curveModeSegmentedControl: UISegmentedControl!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let initialCurveMode: CurveView.BezierCurveMode
        
        let initialBoundingBoxMode: Bool = boundingBoxToggleSwitch.isOn
        
        print("Initial mode: \(self.curveModeSegmentedControl.titleForSegment(at: self.curveModeSegmentedControl.selectedSegmentIndex)!)")
        
        switch self.curveModeSegmentedControl.selectedSegmentIndex
        {
        case 0:
            initialCurveMode = CurveView.BezierCurveMode.quadratic
        case 1:
            initialCurveMode = CurveView.BezierCurveMode.cubic
        default:
            print("Attempted to switch to an invalid mode")
            // if invalid mode detected, reset it to the original
            initialCurveMode = BezierCurveDisplay.currentCurveMode
        }
        
        print("Bounding box started as: \(initialBoundingBoxMode)")
        
        // make sure that the CurveDisplay's initial settings match the UI controls
        BezierCurveDisplay.startUp(initialCurveMode: initialCurveMode, initialBoundingBoxActivity: initialBoundingBoxMode)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // this function was only used in initial design, but it's a neat piece of code, so it stays
    // tutorial here: https://www.raywenderlich.com/76020/using-uigesturerecognizer-with-swift-tutorial
    @IBAction func PanGestureHappened(_ sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: self.view)
        
        if let senderView = sender.view
        {
            senderView.center = CGPoint(x: senderView.center.x + translation.x, y: senderView.center.y + translation.y)
        }
        
        sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }

    @IBAction func curveModeChanged(_ sender: UISegmentedControl)
    {
        print("Mode changed to: \(self.curveModeSegmentedControl.titleForSegment(at: self.curveModeSegmentedControl.selectedSegmentIndex)!)")
        
        let newMode: CurveView.BezierCurveMode
        
        switch self.curveModeSegmentedControl.selectedSegmentIndex
        {
            case 0:
                newMode = CurveView.BezierCurveMode.quadratic
            case 1:
                newMode = CurveView.BezierCurveMode.cubic
            default:
                print("Attempted to switch to an invalid mode")
                // if invalid mode detected, reset it to the original
                newMode = BezierCurveDisplay.currentCurveMode
        }
        
        BezierCurveDisplay.changeCurveMode(to: newMode)
    }
    
    @IBAction func boundingBoxToggled(_ sender: UISwitch)
    {
        print("Bounding box toggled to: \(boundingBoxToggleSwitch.isOn)")
        
        BezierCurveDisplay.changeConvexHullDrawing(to: boundingBoxToggleSwitch.isOn)
    }
    
    // testing in class, doesn't fix the problem
    /*
    override func viewWillAppear(_ animated: Bool) {
        BezierCurveDisplay.createControlPoints()
    }
     */
}

