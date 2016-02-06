//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var charactersModel: CharactersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        charactersModel = appDelegate.charactersModel
        print(charactersModel.toString())
    }    
}

