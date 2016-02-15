//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var charactersModel: CharactersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        charactersModel = appDelegate.charactersModel
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CharacterID.allValuesAlphabetic.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let character = CharacterID.allValuesAlphabetic[indexPath.item]
        let characterSelectCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CharacterSelectCell
        
        characterSelectCell.setTargetCharacter(character)
        characterSelectCell.layer.cornerRadius = 10.0
        characterSelectCell.layer.borderWidth = 1
        characterSelectCell.layer.borderColor = UIColor().getPrimaryColorForCharacter(character).colorWithAlphaComponent(0.5).CGColor
        return characterSelectCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! CharacterInfoPageViewController
        destination.targetCharacterId = CharacterID(rawValue: sender as! String)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CharacterSelectCell
        performSegueWithIdentifier("showCharacterInfo", sender: selectedCell.targetCharacter!.rawValue)
    }
    
    //This method guarantees we have two columns for the character select screen.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        let cellWidth = screenWidth / 2.5; //Replace the divisor with the column count requirement + 1 (in float)
        
        let size = CGSizeMake(cellWidth, cellWidth);
        
        return size;
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CharacterSelectCell
        selectedCell.backgroundColor = UIColor().getPrimaryColorForCharacter(selectedCell.targetCharacter!).colorWithAlphaComponent(0.05)
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CharacterSelectCell
        selectedCell.backgroundColor = nil
    }
    
}

