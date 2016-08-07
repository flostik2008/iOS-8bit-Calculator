//
//  ViewController.swift
//  S3L40retro-calulator
//
//  Created by Evgeny on 8/3/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    
    // we need this to keep track of operations. And the "enum" works here as its own type(like a class), so now we can create vars of type "Operation"
    
    enum Operation: String {
        case Devide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var outputLbl: UILabel!

    
    var bttnSound: AVAudioPlayer!
   
    // we need this to store intermediate label updates (those vars will be shown when we are still typing)
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var results = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // declare a path to the sond file
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        // audio player requres the sound to be wrapped as a url variable. Constracting it with previously created path to the sound file.
        let soundURL = NSURL(fileURLWithPath: path!)
        
        //do-try-catch construction to initialize the player and wrapping it to prevent crashes.
        do {
            try bttnSound = AVAudioPlayer(contentsOfURL: soundURL)

            // a func to make your player ready to play
            bttnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        // once a button was pressed we can not only play a sound, but also grag the value of "tag" (that we specified in the interface builder) and put that value into the "runningNumber" so latter we can display it on the label. 
        // we use the "add += " function because we are adding the string in the tag to the existing string " ".
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
        
// runningNumber = runningNumber + "\(btn.tag)"
        
        
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Devide)
        
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed (sender: AnyObject) {
    
        // play sound
        playSound()
        
        // clear current running number
        runningNumber = ""
        
        // clear current operation
        currentOperation = Operation.Empty
        
        // clear the label
        outputLbl.text = "0"
    
        
    }
    
    
    func processOperation (op:Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                // we will do some math here
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    results = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Devide {
                    results = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    results = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    results = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = results
                outputLbl.text = leftValStr
            
            }
          
            
            currentOperation = op
            
            
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    
    }
    
    
    //we currently don't have any sound played when we are pressing operation buttons. Instead of adding sound code to the oparation buttons we will put the sound code outside as a separate func
    
    func playSound () {
        if bttnSound.playing {
            bttnSound.stop()
        }
        
        bttnSound.play()
    }
    
    
    
    
    
    
}
























