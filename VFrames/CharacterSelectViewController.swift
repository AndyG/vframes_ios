//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var charactersModel: CharactersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        charactersModel = appDelegate.charactersModel
        print(charactersModel.toString())
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CharacterID.allValuesAlphabetic.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let character = CharacterID.allValuesAlphabetic[indexPath.item]
        let characterSelectCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CharacterSelectCell
        
        characterSelectCell.setTargetCharacter(character)
        return characterSelectCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! CharacterInfoViewController
        destination.targetCharacterId = CharacterID(rawValue: sender as! String)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CharacterSelectCell
        performSegueWithIdentifier("showCharacterInfo", sender: selectedCell.targetCharacter!.rawValue)
    }
}

