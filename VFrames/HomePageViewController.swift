//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NetworkDataSourceListenerProtocol {
    
    @IBOutlet var characterSelectCollectionView: UICollectionView!
    @IBOutlet var settingsContainerView: UIView!
    
    @IBOutlet var deleteButton: UIButton!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var charactersModel: CharactersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharactersModel()
        showCorrectView()
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
    
    //MARK: methods for character select collection view
    
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
    
    //MARK: methods for getting data from the network
    func onResult(result: GetNetworkDataResult) {
        switch(result) {
        case .UPDATED:
            dispatch_async(dispatch_get_main_queue(), {
                self.showUpdatedAlert()
            })
            setupCharactersModel()
        case .ALREADY_UP_TO_DATE:
            dispatch_async(dispatch_get_main_queue(), {
                self.showAlreadyUpToDateAlert()
            })
        case .UNSUPPORTED:
            dispatch_async(dispatch_get_main_queue(), {
                self.showUnsupportedAlert()
            })
        case .ERROR:
            dispatch_async(dispatch_get_main_queue(), {
                self.showErrorFetchingDataAlert()
            })
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        showCorrectView()
    }
    
    @IBAction func updateButtonClicked(sender: UIButton) {
        let dataSource = NetworkDataSource()
        dataSource.loadData(self, currentVersion: charactersModel.version)
    }
    
    @IBAction func clearButtonClicked(sender: AnyObject) {
        let appSupportUtil = AppSupportUtil()
        appSupportUtil.clearData()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.reloadCharactersModel()
        setupCharactersModel()
    }
    
    private func setupCharactersModel() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        charactersModel = appDelegate.charactersModel
    }
    
    private func showCorrectView() {
        if (segmentControl.selectedSegmentIndex == 0) {
            characterSelectCollectionView.hidden = false
            settingsContainerView.hidden = true
        } else {
            settingsContainerView.hidden = false
            characterSelectCollectionView.hidden = true
        }
    }
    
    private func showUpdatedAlert() {
        let alert = UIAlertController(title: "Data Updated", message: "You have updated to the latest moves list and frame data. Remember to check for new versions of VFrames in the app store so you can see all the latest additional info, like descriptions and move property specifics. Thank you for using VFrames!", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Ok, thanks!", style: .Default, handler: nil);

        alert.addAction(confirmAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showAlreadyUpToDateAlert() {
        let alert = UIAlertController(title: "Already Up to Date", message: "You already have the latest moves list and frame data. Remember to check for new versions of VFrames in the app store so you can see all the latest additional info, like descriptions and move property specifics. Thank you for using VFrames!", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Ok, thanks!", style: .Default, handler: nil);
        
        alert.addAction(confirmAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showUnsupportedAlert() {
        let alert = UIAlertController(title: "Unsupported VFrames Version", message: "This version of VFrames is no longer supported. Please check for an update in the App Store.", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .Default, handler: nil);
        
        alert.addAction(confirmAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showErrorFetchingDataAlert() {
        let alert = UIAlertController(title: "Error Fetching Data", message: "There was an error updating your data. Please try again later.", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .Default, handler: nil);
        
        alert.addAction(confirmAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

