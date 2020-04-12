//
//  ViewController.swift
//  AnimateCircle
//
//  Created by Asif Newaz on 12/4/20.
//  Copyright © 2020 Asif Newaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIViewX!
    @IBOutlet weak var startButton: UIButtonX!
    
    var panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        roundedView.isUserInteractionEnabled = true
        roundedView.addGestureRecognizer(panGesture)
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(roundedView)
        let translation = sender.translation(in: self.view)
        roundedView.center = CGPoint(x: roundedView.center.x + translation.x, y: roundedView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func moveAction(_ sender: UIButton) {
        self.roundedView.moveAnimation(withDuration: 5.0, withAxis: .x, withAnimStepCount: UIScreen.main.bounds.width - 100, complition: nil)
    }
}


enum Axis {
    case x
    case y
    case both
    case custom
}
extension UIView{
    func moveAnimation(withDuration duration : Double,withAxis axis:Axis,withAnimStepCount step:CGFloat,complition : ((Bool) -> Swift.Void)?) {
        let oldFrame = self.frame
        UIView.animate(withDuration: duration, animations: {
            if axis == .both
            {
                self.frame.origin.x += step
                self.frame.origin.y += step
            }
            else if axis == .y
            {
                self.frame.origin.y += step
            }
            else  if axis == .custom {
                self.frame.origin.x += step
                self.frame.origin.y += step - 50
            }
            else
            {
                self.frame.origin.x += step
            }
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                //self.frame = oldFrame
            }, completion: { _ in
                complition?(true)
            })
        }
    }
    
    
}

