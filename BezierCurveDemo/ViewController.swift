//
//  ViewController.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/17/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var BezierCurveDisplay: CurveView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PanGestureHappened(_ sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: self.view)
        
        if let senderView = sender.view
        {
            senderView.center = CGPoint(x: senderView.center.x + translation.x, y: senderView.center.y + translation.y)
        }
        
        sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }

}

