//
//  MasterViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/3/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    
    var usersArray : [UserModelClass]?
    var index      : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  addChildViewController() -> Void {
        
        let storyViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        storyViewcontroller.asserts = self.usersArray![index!].statusAssets as! [String]
        
       self.addChildViewController(storyViewcontroller)
        self.view.addSubview(storyViewcontroller.view)
    storyViewcontroller.view.frame = self.view.bounds
        storyViewcontroller.didMove(toParentViewController: self)
    }
    
    func finishedDisplayingViewController(oldVC:UIViewController){
        
        index = index! + 1
        if (index! <= usersArray!.count-1) {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
            newVC.asserts = self.usersArray![index!].statusAssets as! [String]
            self.cycleFromViewController(oldVC: oldVC, newVC: newVC)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    func cycleFromViewController(oldVC:UIViewController,newVC:UIViewController) -> Void {
        oldVC.willMove(toParentViewController: nil)
        self.addChildViewController(newVC)
        newVC.view.frame = CGRect.init(x: self.view.frame.width, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        
        
        self.transition(from: oldVC, to: newVC, duration: 0.25, options:UIViewAnimationOptions.curveLinear, animations: {
            newVC.view.frame = oldVC.view.frame
            oldVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (finished) in
            oldVC.removeFromParentViewController()
            newVC.didMove(toParentViewController: self)
        }

      
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
