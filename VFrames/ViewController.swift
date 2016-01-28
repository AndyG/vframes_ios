//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(CharacterID.CHUN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func characterButtonClicked(sender: UIButton) {
        switch (sender.tag) {
            case 0:
                print("ryu clicked")
            case 1:
                print ("chun clicked")
        default:
            print ("invalid clicked")
        }
    }
    
    @IBAction func loadDataPressed(sender: UIButton) {
        print("loadDataPressed")
        loadFile()
    }
    
    func loadFile() {
        let path = NSBundle.mainBundle().pathForResource("vframes_data", ofType: "json")
        let jsonData = NSData(contentsOfMappedFile: path!)
        let dataString = String(data: jsonData!, encoding: NSUTF8StringEncoding)
        print(dataString!)
    }
}

