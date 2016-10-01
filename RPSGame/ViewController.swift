//
//  ViewController.swift
//  RPSGame
//
//  Created by Duncan on 2016/2/17.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var winCount = 0
    var loseCount = 0
    var myTimer:NSTimer!
    
    @IBOutlet weak var ScissorsButton: UIButton!
    @IBOutlet weak var RockButton: UIButton!
    @IBOutlet weak var PaperButton: UIButton!
    @IBOutlet weak var loseOrWinImage: UIImageView!
    //判定猜拳結果輸贏function  2016.2
    //0:Rock, 1:Paper, 2:Scissors
    //return true = win, false = lose, nil = 平手
    var myRPSInput = 0
    var computerRPSInput = 0
    
    func isRPSResultWin(me:Int, opponent:Int) -> Bool?{
        var result:Bool?
        if (me == 0 && opponent == 2) || (me == 1 && opponent == 0) || (me == 2 && opponent == 1){
            result = true
        }else if
            (me == 0 && opponent == 1) || (me == 1 && opponent == 2) || (me == 2 && opponent == 0){
                result = false
        }
        return result
    }
    //按鈕共同動作
    func buttonCommon() -> (){
        myTimer.invalidate()
        loseOrWinImage.hidden = false
        if computerRPSInput == 0{
            computerPic.image = UIImage(named: "rock_downside")
        }else if computerRPSInput == 1{
            computerPic.image = UIImage(named: "paper_downside")
        }else if computerRPSInput == 2{
            computerPic.image = UIImage(named: "scissor_downside")
        }
        let result = isRPSResultWin(myRPSInput, opponent: computerRPSInput)
        if result == true{
            winCount++
            loseOrWinImage.image = UIImage(named: "You-Win")
        }
        else if result == false{
            loseCount++
            loseOrWinImage.image = UIImage(named: "You-lose")
        }else{
            loseOrWinImage.image = UIImage(named: "Draw")
        }
        numberOfWin.text = "WIN：\(winCount)"
        numberOfLose.text = "LOSE：\(loseCount)"
        
        ScissorsButton.userInteractionEnabled = false
        RockButton.userInteractionEnabled = false
        PaperButton.userInteractionEnabled = false
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("viewReload"), userInfo: nil, repeats: false)
        
        let winAlert = UIAlertController(title: "恭喜！", message: "你贏了", preferredStyle: UIAlertControllerStyle.Alert)
        let loseAlert = UIAlertController(title: "很抱歉！", message: "你輸了", preferredStyle: UIAlertControllerStyle.Alert)
        let playagainAction = UIAlertAction(title: "再玩一次", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction) -> () in
            self.dismissViewControllerAnimated(true, completion:nil)
            super.viewDidLoad()
        })
        winAlert.addAction(playagainAction)
        loseAlert.addAction(playagainAction)
        
        if winCount > 2{
            self.presentViewController(winAlert, animated: true, completion: nil)
            winCount = 0
            loseCount = 0
        }else if loseCount > 2{
            self.presentViewController(loseAlert, animated: true, completion: nil)
            winCount = 0
            loseCount = 0
        }
    }
    //Computre Picture
    @IBOutlet weak var computerPic: UIImageView!
    var blinkPicNow = 0
    func picBlink(){
        if blinkPicNow == 0{
            computerPic.image = UIImage(named: "paper_downside")
            blinkPicNow = 1
        }else if blinkPicNow == 1{
            computerPic.image = UIImage(named: "rock_downside")
            blinkPicNow = 2
        }else{
            computerPic.image = UIImage(named: "scissor_downside")
            blinkPicNow = 0
        }
    }
    
    @IBOutlet weak var numberOfWin: UILabel!
    @IBOutlet weak var numberOfLose: UILabel!
    @IBAction func scissorButton(sender: UIButton) {
        myRPSInput = 2
        computerRPSInput = Int(arc4random_uniform(3))
        buttonCommon()
        /*if computerRPSInput == 0{
            computerRock.hidden = false
        }else if computerRPSInput == 1{
            computerPaper.hidden = false
        }else if computerRPSInput == 2{
            computerScissor.hidden = false
        }*/
        
        /*let result = isRPSResultWin(myRPSInput, opponent: computerRPSInput)
        if result == true{
            winCount++
        }else if result == false{
            loseCount++
        }else if result == nil{
        
        }
        numberOfWin.text = "WIN：\(winCount)"
        numberOfLose.text = "LOSE：\(loseCount)"
        
        let winAlert = UIAlertController(title: "恭喜！", message: "你贏了", preferredStyle: UIAlertControllerStyle.Alert)
        let loseAlert = UIAlertController(title: "很抱歉！", message: "你輸了", preferredStyle: UIAlertControllerStyle.Alert)
        let playagainAction = UIAlertAction(title: "再玩一次", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction) -> () in
            self.dismissViewControllerAnimated(true, completion:nil)
        })
        winAlert.addAction(playagainAction)
        loseAlert.addAction(playagainAction)
        
        if winCount > 2{
            self.presentViewController(winAlert, animated: true, completion: nil)
            winCount = 0
            loseCount = 0
        }else if loseCount > 2{
            self.presentViewController(loseAlert, animated: true, completion: nil)
            winCount = 0
            loseCount = 0
        }*/

    }
    @IBAction func RockButton(sender: UIButton) {
        myRPSInput = 0
        computerRPSInput = Int(arc4random_uniform(3))
        buttonCommon()
    }
    @IBAction func PaperButton(sender: UIButton) {
        myRPSInput = 1
        computerRPSInput = Int(arc4random_uniform(3))
        buttonCommon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer = NSTimer.scheduledTimerWithTimeInterval(0.12, target: self, selector: Selector("picBlink"), userInfo: nil, repeats: true)
        winCount = 0
        loseCount = 0
        numberOfWin.text = "WIN：0"
        numberOfLose.text = "LOSE：0"
    }
    func viewReload(){
        myTimer = NSTimer.scheduledTimerWithTimeInterval(0.12, target: self, selector: Selector("picBlink"), userInfo: nil, repeats: true)
        loseOrWinImage.hidden = true
        ScissorsButton.userInteractionEnabled = true
        RockButton.userInteractionEnabled = true
        PaperButton.userInteractionEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

