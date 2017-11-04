//
//  StoryViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class StoryViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var ProgressBarArray = [UIProgressView]()
    var timer = Timer()
    var count :Float = 0
    var counter:Float = 0
    var selectedProgressView : UIProgressView?
    var assertIndex: Int = 0
    var asserts: [String]!
    
    var player : AVPlayer?
    var playerLayer : AVPlayerLayer?
    var progressContainerView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
         timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:(#selector(triggeredBytimer)), userInfo: nil, repeats: true)
        self.progressContainerView = UIView.init(frame: CGRect.init(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: 100))
        
      self.ProgressBarArray =   self.createProgressBarsForAssets(assets: asserts.count)
        self.view.addSubview(self.progressContainerView!)
        selectedProgressView = self.ProgressBarArray[assertIndex]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func triggeredBytimer(){
        if count == 0{
            self.fetchAsset()
        }
        self.updateProgressBar()
        counter = counter + 1
        if counter == self.count*100 {
            counter = 0
            assertIndex = assertIndex + 1
            if assertIndex == asserts.count{
                timer.invalidate()
                self.dismissViewController()
            }
            else{
                playerLayer?.removeFromSuperlayer()
                self.fetchAsset()
                self.selectedProgressView = self.ProgressBarArray[assertIndex]

                
            }
        }
        
    }
    func fetchAsset(){
        let assert = asserts[assertIndex]
        let fileName = URL.init(string: assert)?.deletingPathExtension().absoluteString
        let fileType = URL.init(string: assert)?.pathExtension
      
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,fileType! as CFString,nil)?.takeRetainedValue()

        if UTTypeConformsTo(uti!, kUTTypeImage){
            print("this is image")
            count = 5
        }
        else if UTTypeConformsTo(uti!, kUTTypeMovie){
            print("this is video")
        }
        if (fileType == "mp4"){
            print("assert is video with name:\(assert)")
            self.playVideo(name: fileName!, fileType: fileType!)
        }
        else{
            print("assert is image with name: \(assert)")
            self.view.bringSubview(toFront: self.photoImageView)
            self.view.bringSubview(toFront: self.progressContainerView!)
            self.view.bringSubview(toFront: self.closeButton)
            self.photoImageView.image = UIImage.init(named: assert)
        }
    }
    
    
    
   @objc func updateProgressBar(){
    UIView.animate(withDuration: 0.01) {
        self.selectedProgressView?.setProgress((self.counter/(self.count*100)), animated: true)
    }
    }
    
    @objc func updateNextAsset() -> Void {
        assertIndex = assertIndex + 1
        if assertIndex != asserts.count{
           // self.displayAssert()
        count = 0
    }
        else{
            self.dismissViewController()
        }
    }
    


    
    func playVideo(name:String, fileType:String){
        
        let urlPath = Bundle.main.path(forResource: name, ofType: fileType)
        let videoURL = URL(fileURLWithPath: urlPath!)
        let asset = AVURLAsset(url: videoURL)
        print("asset duration\(CMTimeGetSeconds(asset.duration))")
        if CMTimeGetSeconds(asset.duration) < 15{
            self.count = Float(ceil(CMTimeGetSeconds(asset.duration)))
        }
        else{
            self.count = 15
        }
        let assetItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: assetItem)
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer!.frame = self.view.frame
        
        playerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(playerLayer!)
        self.view.bringSubview(toFront: self.progressContainerView!)
        self.view.bringSubview(toFront: self.closeButton)

        player!.play()
        

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
        self.progressContainerView!.addSubview(progressView)
        return progressView
    }
    
    func dismissViewController() -> Void {
     player?.pause()
        
        
        let parentViewcontroller = self.parent as! MasterViewController
    
        parentViewcontroller.finishedDisplayingViewController(oldVC: self)
       // self.hideContentController(content: self)
                //self.dismiss(animated: true, completion: nil)
    }
    
    func hideContentController(content:UIViewController) -> Void {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }

}
