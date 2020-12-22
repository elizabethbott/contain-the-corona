//
//  GameViewController.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/21/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit
import os.log

import GoogleMobileAds
/////////////////////////////////
var roundCounter = 1


//var minMove = [spot]()

var currentNode = 0



var userPlayed = false
var winner = false
var coronaRow = -1
var coronaCol = -1

var userWon = false
//var coronaWon = false

var levelCount = 1





class GameViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    
    //stack views
    @IBOutlet weak var stack1: UIStackView!
    
    
    @IBOutlet weak var stack2: UIStackView!
    
    
    @IBOutlet weak var stack3: UIStackView!
    
    @IBOutlet weak var stack4: UIStackView!
    @IBOutlet weak var stack5: UIStackView!
    @IBOutlet weak var stack6: UIStackView!
    @IBOutlet weak var stack7: UIStackView!
    @IBOutlet weak var stack8: UIStackView!
    @IBOutlet weak var stack9: UIStackView!
    @IBOutlet weak var stack10: UIStackView!
    @IBOutlet weak var stack11: UIStackView!
    
    
//top barr
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
   
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var goHomeButton: UIButton!
    @IBOutlet weak var stayButton: UIButton!
    
   
    var disCounter = 0
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelUp()
        setUp()
        
        settingsButton.isSelected = false
        soundButton.isHidden = true
        musicButton.isHidden = true
        homeButton.isHidden = true
        
        goHomeButton.layer.cornerRadius = goHomeButton.frame.height / 2
        stayButton.layer.cornerRadius = stayButton.frame.height / 2
        
        soundButton.setImage(UIImage(named: "mute audio"), for: .selected)
        soundButton.setImage(UIImage(named: "audio"), for: .normal)
        
        if buttonSound{
            soundButton.isSelected = true
        }
        musicButton.setImage(UIImage(named: "mute music"), for: .selected)
        musicButton.setImage(UIImage(named: "music"), for: .normal)
        
        if musicOn{
            musicButton.isSelected = true
        }
        //MusicPlayer.shared.startBackgroundMusic()
        //MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        //MusicPlayer.shared.stopBackgroundMusic()
       // play()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        //real ad unit id  = ca-app-pub-1819387077062484/6332027027
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
        interstitial = createAndLoadInterstitial()
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        //real id ca-app-pub-1819387077062484/8122130155
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    //
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        
        if !musicOn{
            GSAudio.sharedInstance.playSoundMp3(soundFileName: "slowmotion")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "finalViewController")
        show(newViewController, sender: self)
    }
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }//
    
    
    func levelUp(){
        
        
        //levelCount = levelCount + 1
        levelLabel.text = "Level " + String(levelCount)
  
        
        
    }
    
    func setUp(){
        winner = false
        stackSetUp()
        userWon = false
        
        //initalize everything to starting place
       // nextLabel.isHidden = true
        //nextButton.isHidden = true
       // nextLabel.alpha = 0.0
        
        
        //freeLabel.text = "place 3 more disinfectants!"
        for row in 0...10{
            for col in 0...4{
                spaceGrid[row][col].isSelected = false
               
                
                spaceGrid[row][col].setImage(UIImage(named: "default"), for: .normal)
                spaceGrid[row][col].setImage(UIImage(named: "blocker"), for: .selected)
                
            }
        }
        
        //NEED TO RANDOMLY PICK spots to have beginning
        let spotsGiven = Int.random(in: 1 ... 5)
        
        for _ in 0..<spotsGiven{
            let row = Int.random(in: 1 ... 9)
            let col = Int.random(in: 1 ... 3)
            
            spaceGrid[row][col].isSelected = true
            
          //  let index = (row * 6) + col
            //minMove.remove(at: index)
            
        }
        
        //picking starting spot for the virus
        
        let row = Int.random(in: 1 ... 9)
        let col = Int.random(in: 1 ... 3)
        
        coronaRow = row
        coronaCol = col
        
        
        spaceGrid[row][col].isSelected = true
        
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .normal)
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .selected)
        
        let index = (row * 6) + col
        
      //  minMove[index].visited = true
        currentNode = index
        
        
        
    }//setUp()
    
    
    func stackSetUp(){
       // let bundle = Bundle(for: type(of: self))
        //let filledSpace = UIImage(named: "blocker", in: bundle, compatibleWith: self.traitCollection)
        //let emptySpace = UIImage(named:"default", in: bundle, compatibleWith: self.traitCollection)
        for (_, _) in spaceGrid.enumerated() {
            spaceGrid.popLast()
        }
        
        
        stack(stackView: stack1)
        stack(stackView: stack2)
        stack(stackView: stack3)
        stack(stackView: stack4)
        stack(stackView: stack5)
        stack(stackView: stack6)
        stack(stackView: stack7)
        stack(stackView: stack8)
        stack(stackView: stack9)
        stack(stackView: stack10)
        stack(stackView: stack11)
        
        
    }
    
 
    func stack(stackView: UIStackView){
        
        var spaces = [UIButton]()
        for _ in 0..<5 {
            
            let button = UIButton()
            // Set the button images
            button.setImage(UIImage(named: "default"), for: .normal)
            button.setImage(UIImage(named: "blocker"), for: .selected)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 64).isActive = true
            button.widthAnchor.constraint(equalToConstant: 70).isActive = true
            spaces.append(button)
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(GridControl.GridButtonTapped(button:)), for: .touchUpInside)
            
            
        }
        spaceGrid.append(spaces)
        
    }
    
    
    @objc func GridButtonTapped(button: UIButton) {
        //print("Button pressed 👍")
      // MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        
        //MusicPlayer.shared.startBackgroundMusic()
        if winner == false{
            if !button.isSelected{
                if !buttonSound{
                    GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
                }
                
              
                userPlayed = true
                button.isSelected = true
                
                print("YOU MOVED")
                
                if disCounter < 2{
                    disCounter += 1
                    //freeLabel.text = "place " + String(3 - disCounter) + " more disinfectants!"
                }else{
                    //freeLabel.isHidden = true
                    GamePlay().play()
                    
                    if winner{
                        print("winner")
                        stack1.isHidden = true
                        stack2.isHidden = true
                        stack3.isHidden = true
                        stack4.isHidden = true
                        stack5.isHidden = true
                        stack6.isHidden = true
                        stack7.isHidden = true
                        stack8.isHidden = true
                        stack9.isHidden = true
                        stack10.isHidden = true
                        stack11.isHidden = true
                        
                        //if roundCounter = 5 show intersitital ad
                        
                        if roundCounter == 5{
                            GSAudio.sharedInstance.stopBackgroundMusicMp3(soundFileName: "slowmotion")
                            if interstitial.isReady {
                                interstitial.present(fromRootViewController: self)
                            }
                            
                            roundCounter = 1
                        }else{
                            roundCounter += 1
                        }
                      
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyboard.instantiateViewController(withIdentifier: "finalViewController")
                        show(newViewController, sender: self)
                        
                      
                        
                        
                    }//if winner
           
                }//disCounter

            }//button selected
        
      
        
        }//winner == false
        
    }//button tapped
    
    
   
    @IBAction func gameDone(_ sender: UITapGestureRecognizer) {
        
        if winner{
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
            stack4.isHidden = true
            stack5.isHidden = true
            stack6.isHidden = true
            stack7.isHidden = true
            stack8.isHidden = true
            stack9.isHidden = true
            stack10.isHidden = true
            stack11.isHidden = true
          
            winner = false
        }else{
            print("tapped")
        }
    }//gamedone
    
    
    @IBAction func settingsClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        if settingsButton.isSelected {
            settingsButton.isSelected = false
            musicButton.isHidden = true
            soundButton.isHidden = true
            homeButton.isHidden = true
        }else{
            settingsButton.isSelected = true
            musicButton.isHidden = false
            soundButton.isHidden = false
            homeButton.isHidden = false
        }
    }//settings clicked
    
    @IBAction func soundButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            buttonSound = true
            soundButton.isSelected = true
        }else{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
            buttonSound = false
            soundButton.isSelected = false
        }
        
    }//sound clicked
    
    @IBAction func musicClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        if !musicOn{
            //MusicPlayer.shared.stopBackgroundMusic()
            
            GSAudio.sharedInstance.stopBackgroundMusicMp3(soundFileName: "slowmotion")
            musicOn = true
            musicButton.isSelected = true
        }else{
            musicOn = false
            //MusicPlayer.shared.startBackgroundMusic()
            GSAudio.sharedInstance.playSoundMp3(soundFileName: "slowmotion")
            musicButton.isSelected = false
        }
    }
    
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        questionImage.isHidden = false
        questionLabel.isHidden = false
        goHomeButton.isHidden = false
        stayButton.isHidden = false
    }
    
    
    @IBAction func goHomeClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        questionImage.isHidden = true
        questionLabel.isHidden = true
        goHomeButton.isHidden = true
        stayButton.isHidden = true
    }
    
    
    
    @IBAction func stayButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        questionImage.isHidden = true
        questionLabel.isHidden = true
        goHomeButton.isHidden = true
        stayButton.isHidden = true
        
    }
    

}//gameViewControllerr
