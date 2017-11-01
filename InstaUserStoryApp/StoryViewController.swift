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
    var ProgressBarArray = [UIProgressView]()
    var timer = Timer()
    var count :Float = 0
    var selectedProgressView : UIProgressView?
    var assertIndex: Int = 0
    var asserts: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImageView.image = self.asserts[0]
         timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:(#selector(self.updateProgressBar)), userInfo: nil, repeats: true)
      self.ProgressBarArray =   self.createProgressBarsForAssets(assets: asserts.count)
        selectedProgressView = self.ProgressBarArray[assertIndex]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismissViewController()
    }
   @objc func updateProgressBar(){
    UIView.animate(withDuration: 0.01) {
        self.selectedProgressView?.setProgress(self.count/500, animated: true)
    }
    count = count + 1
    if count == 500 {
        self.updateNextAsset()
    }
    }
    
    @objc func updateNextAsset() -> Void {
        assertIndex = assertIndex + 1
        if assertIndex != asserts.count{
        self.photoImageView.image = asserts[assertIndex]
        self.selectedProgressView = self.ProgressBarArray[assertIndex]
        count = 0
    }
        else{
            self.dismissViewController()
            
        }
    }
    
    
    
    func dismissViewController() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createProgressBarsForAssets(assets:Int) -> [UIProgressView] {
        let viewWidth = self.view.frame.width
        let widthForProgressView = viewWidth - 20
        let spaceBtwnBars = 3
        let totalAvailableSpace = Float(widthForProgressView) - Float((assets-1)*3)
        for i in 0 ..< assets{
         let barWidth = CGFloat(totalAvailableSpace/Float(assets))
        let x = 10 + CGFloat(spaceBtwnBars*i)+CGFloat(barWidth*CGFloat(i))
         let progressView = self.createProgressView(x: x, width: barWidth)
            self.ProgressBarArray.append(progressView)
        }
        return self.ProgressBarArray
        
        
    }
    
    func createProgressView(x:CGFloat, width:CGFloat) -> UIProgressView{
    let progressView = UIProgressView.init(frame: CGRect.init(x: x, y:20 , width: width, height: 2))
        progressView.progressTintColor = UIColor.white
        self.view.addSubview(progressView)
        return progressView
    
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
