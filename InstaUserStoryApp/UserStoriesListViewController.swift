//
//  UserStoriesListViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class UserStoriesListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var userStoriesListView: UICollectionView!
    
    var usersStoriesArray: [UserModelClass]? = [UserModelClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.createUsers()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.usersStoriesArray?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStoryCell", for: indexPath) as! UserCollectionViewCell
        let user = self.usersStoriesArray![indexPath.item]
        cell.profileImageView.image = user.photo
        cell.UserNameLabel.text = user.name
        cell.profileImageView.layer.borderColor = UIColor.white.cgColor
        cell.profileImageView.layer.borderWidth = 2.0
        cell.containerView.layer.cornerRadius = 35
        cell.containerView.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let storyViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
//        storyViewcontroller.asserts = self.usersStoriesArray![indexPath.item].statusAssets as! [String]
        
        let storyMasterVC = self.storyboard?.instantiateViewController(withIdentifier: "masterVC") as! MasterViewController
        
        storyMasterVC.usersArray = self.usersStoriesArray
        storyMasterVC.index = indexPath.item
        
        
        
        self.present(storyMasterVC, animated: true, completion: nil)
        
        
    }

    
    func createUsers() {
        
       let firstUser = UserModelClass.init(name: "firstUser", photo: UIImage.init(named: "firstUser.jpeg"))
//        firstUser.statusAssets = [UIImage.init(named: "image1.jpg")!,UIImage.init(named: "image2.jpeg")!,UIImage.init(named: "image3.jpeg")!]
        firstUser.statusAssets = ["image1.jpg"]
        self.usersStoriesArray?.append(firstUser)
        let secondUser = UserModelClass.init(name: "secondUser", photo: UIImage.init(named: "secondUser.jpeg"))
//        secondUser.statusAssets = [UIImage.init(named: "image4.jpeg")!,UIImage.init(named: "image5.jpeg")!,UIImage.init(named: "image6.jpeg")!,UIImage.init(named: "image7.jpeg")!,UIImage.init(named: "image8.jpeg")!]
        secondUser.statusAssets = ["image4.jpeg","image5.jpeg","video1.mp4","video2.mp4","image6.jpeg"]
        self.usersStoriesArray?.append(secondUser)
        let thirdUser = UserModelClass.init(name: "thirdUser", photo: UIImage.init(named: "thirdUser.jpeg"))
//        thirdUser.statusAssets = [UIImage.init(named: "image9.jpg")!,UIImage.init(named: "image1.jpg")!,UIImage.init(named: "image5.jpeg")!,UIImage.init(named: "image8.jpeg")!]
        thirdUser.statusAssets = ["image9.jpg","video6.mp4","image2.jpeg","video4.mp4","image4.jpeg"]
        self.usersStoriesArray?.append(thirdUser)
        let fourthUser = UserModelClass.init(name: "fourthUser", photo: UIImage.init(named: "fourthUser.jpeg"))
//        fourthUser.statusAssets = [UIImage.init(named: "image9.jpg")!]
        fourthUser.statusAssets = ["video5.mp4","video10.mp4","video7.mp4"]
        self.usersStoriesArray?.append(fourthUser)
        
        
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
