//
//  StoryViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var timer = Timer()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImageView.image = UIImage.init(named: "UserPic.jpeg")
         timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector:(#selector(self.updateNextAsset)), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismissViewController()
    }
    
    
    @objc func updateNextAsset() -> Void {
        if count == 1{
            timer.invalidate()
            self.dismissViewController()
        }
        self.photoImageView.image = UIImage.init(named: "SecondPic.jpeg")
        count = count+1
        
    }
    
    func dismissViewController() -> Void {
        self.dismiss(animated: true, completion: nil)
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
