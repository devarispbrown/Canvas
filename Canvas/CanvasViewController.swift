//
//  CanvasViewController.swift
//  Canvas
//
//  Created by DeVaris Brown on 5/27/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    var trayOriginalCenter: CGPoint!
    var originalPoint: CGPoint!
    var velocityUp: CGPoint!
    var velocityDown: CGPoint!
    
    @IBOutlet weak var canvasGesture: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
       originalPoint = canvasGesture.center
    }
    

    @IBAction func panGestureWasTapped(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        
        trayOriginalCenter = canvasGesture.center
        
        var translation = point.y - trayOriginalCenter.y
       
        println("\(point, velocity)")
        canvasGesture.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation)
        
        if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            println("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            // 2
            let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:sender.view!.center.x + (velocity.x * slideFactor),
                y:sender.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            // 5
            canvasGesture.(Double(slideFactor * 2),
                delay: 0,
                // 6
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {sender.view!.center = finalPoint },
                completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
