//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NetworkDataSourceListenerProtocol {
    
    @IBOutlet var updateDataButton: UIButton!
    @IBOutlet var updateDataActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var characterSelectCollectionView: UICollectionView!
        
    var charactersModel: CharactersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharactersModel()
        if (shouldShowFeedbackRequest()) {
            showFeedbackRequest()
        }
    }
    
    @IBAction func updateButtonClicked(sender: UIButton) {
        updateDataButton.hidden = true
        updateDataActivityIndicator.startAnimating()
        updateDataActivityIndicator.hidden = false
        let dataSource = NetworkDataSource()
        dataSource.loadData(self, currentVersion: charactersModel.version)
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
        let cellWidth = getCellWidth()
        let size = CGSizeMake(cellWidth, cellWidth)
        return size;
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let smallerDimen = min(screenSize.width, screenSize.height)
        
        let sideInset = smallerDimen * 0.02
        
        return UIEdgeInsets(top: 0.0, left: sideInset, bottom: 0.0, right: sideInset)
    }
    
    private func getCellWidth() -> CGFloat {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let smallerDimen = min(screenSize.width, screenSize.height)
        return smallerDimen * 0.4 //Replace the divisor with the column count requirement + 1 (in float)
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
        
        print("on result")
        //Update the UI appropriately
        dispatch_async(dispatch_get_main_queue(), {
            self.updateDataButton.hidden = false
            self.updateDataActivityIndicator.stopAnimating()
        })
        
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

    private func setupCharactersModel() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        charactersModel = appDelegate.charactersModel
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
    
    private func shouldShowFeedbackRequest() -> Bool {
        let launchCountKey = "PREFS_LAUNCH_COUNT_KEY"
        let hasShownFeedbackKey = "PREFS_SHOWN_FEEDBACK_KEY"
        let prefs = NSUserDefaults.standardUserDefaults()
        let launchCount = prefs.integerForKey(launchCountKey)
        let hasShownFeedback = prefs.boolForKey(hasShownFeedbackKey)
        
        return (launchCount >= 5 && !hasShownFeedback)
    }
    
    private func showFeedbackRequest() {
        //Ensure they don't see the message again
        let hasShownFeedbackKey = "PREFS_SHOWN_FEEDBACK_KEY"
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setBool(true, forKey: hasShownFeedbackKey)
        
        let alertTitle = NSLocalizedString("rating_request_title", comment: "title for dialog")
        let alertMessage = NSLocalizedString("rating_request_message", comment: "message for dialog")
        let rateButtonText = NSLocalizedString("rating_request_positive_button", comment: "positive button")
        let declineButtonText = NSLocalizedString("rating_request_negative_button", comment: "negative button")
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)

        let confirmAction = UIAlertAction(title: rateButtonText, style: .Default, handler: { (action: UIAlertAction!) in
            //TODO: fix this URL as it is not working on simulator
            let url = NSURL(string: "http://itunes.apple.com/app/id1084560583")!
            UIApplication.sharedApplication().openURL(url)
        })
        
        let denyAction = UIAlertAction(title: declineButtonText, style: .Cancel, handler: nil);

        alert.addAction(confirmAction)
        alert.addAction(denyAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}

