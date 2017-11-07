//
//  MasterViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/3/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

protocol stopPlayBack {
    func stopPlayBack(stop:Bool)
}

class MasterViewController: UIViewController {
    
    var usersArray = [UserModelClass]()
    var index      : Int = 0
    var reverse  : Bool = false
    var swipe : Bool = false
    var playBackDelegate : stopPlayBack?

    @IBOutlet weak var containerView: UIView!
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController()
    }
    
    //MARK:- Helper Methods
    func  addChildViewController() -> Void {
        let newVC = self.createNewViewControllerInstance()
        self.addChildViewController(newVC)
        self.containerView.addSubview(newVC.view)
        newVC.view.frame = self.containerView.bounds
        newVC.didMove(toParentViewController: self)
    }
    
    func createNewViewControllerInstance() -> StoryViewController{
        let storyViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        storyViewcontroller.asserts = self.usersArray[index].statusAssets as! [String]
        return storyViewcontroller
    }
    
    
    func finishedDisplayingViewController(oldVC:StoryViewController){
        
        index = index + (reverse ? -1 : 1)
        
        if ((index <= (usersArray.count - 1)) && index >= 0){
            self.playBackDelegate?.stopPlayBack(stop: true)
            let newVC = self.createNewViewControllerInstance()
            self.switchBetweenViews(fromVC: oldVC, toVC: newVC)
        }
        else{
            if swipe{
                self.playBackDelegate?.stopPlayBack(stop: !swipe)
                index = index + (reverse ? 1 : -1)
            }
            else{
                oldVC.timer.invalidate()
                oldVC.player?.pause()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    //MARK:- Animation Methods
    func switchBetweenViews(fromVC:UIViewController,toVC:UIViewController) {
        let containerView = self.containerView
        let toViewController = toVC
        let fromViewController = fromVC
        let toView = toViewController.view
        let fromView = fromViewController.view
        let direction : CGFloat = reverse ? -1 : 1

        let const: CGFloat = -0.003
        toView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1 , y: 0.5)
        fromView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0 , y: 0.5)
        
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * .pi/2, 0.0, 1.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * .pi/2, 0.0, 1.0, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        containerView?.transform = CGAffineTransform(translationX: direction * (containerView?.frame.size.width)! / 2.0, y: 0)
        toView?.layer.transform = viewToTransform
        self.addChildViewController(toVC)
        containerView?.addSubview(toView!)
        
        self.transition(from: fromVC, to: toVC, duration: 0.5, options:UIViewAnimationOptions.curveLinear, animations: {
            containerView?.transform = CGAffineTransform(translationX: -direction * (containerView?.frame.size.width)! / 2.0, y: 0)
            fromView?.layer.transform = viewFromTransform
            toView?.layer.transform = CATransform3DIdentity
        }) { (finished) in
            containerView?.transform = CGAffineTransform.identity
            fromView?.layer.transform = CATransform3DIdentity
            toView?.layer.transform = CATransform3DIdentity
            fromView?.layer.anchorPoint = CGPoint(x:0.5, y:0.5)
            toView?.layer.anchorPoint = CGPoint(x:0.5, y:0.5)
            
            fromVC.removeFromParentViewController()
            toVC.didMove(toParentViewController: self)
        }
    }
    
}
