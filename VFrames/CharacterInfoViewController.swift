//
//  CharacterInfoPageViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/11/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet var tabBar: UITabBar!
    
    @IBOutlet var movesListContainer: UIView!
    @IBOutlet var frameDataContainer: UIView!
    @IBOutlet var combosContainer: UIView!
    @IBOutlet var videosContainer: UIView!
    @IBOutlet var notesContainer: UIView!
    
    
    var targetCharacterId: CharacterID!

    
    override func viewDidLoad() {
        showFrameData()                
        
        let backgroundColor = UIColor.groupTableViewBackgroundColor()
        view.backgroundColor = backgroundColor
        
        title = CharacterID.toString(targetCharacterId)
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch (item.tag) {
        case 0:
            showFrameData()
        case 1:
            showMovesList()
        case 2:
            showCombos()
        case 3:
            showVideos()
        case 4:
            showNotes()
        default:
            //should never happen
            break
        }
    }
    
    private func showFrameData() {
        tabBar.selectedItem = tabBar.items![0]
        
        movesListContainer.hidden = true
        combosContainer.hidden = true
        videosContainer.hidden = true
        notesContainer.hidden = true
        
        frameDataContainer.hidden = false
    }
    
    private func showMovesList() {
        tabBar.selectedItem = tabBar.items![1]
        
        frameDataContainer.hidden = true
        combosContainer.hidden = true
        videosContainer.hidden = true
        notesContainer.hidden = true
        
        movesListContainer.hidden = false
    }
    
    private func showCombos() {
        tabBar.selectedItem = tabBar.items![2]
        
        frameDataContainer.hidden = true
        movesListContainer.hidden = true
        videosContainer.hidden = true
        notesContainer.hidden = true
        
        combosContainer.hidden = false
    }
    
    private func showVideos() {
        tabBar.selectedItem = tabBar.items![3]
        
        movesListContainer.hidden = true
        frameDataContainer.hidden = true
        combosContainer.hidden = true
        notesContainer.hidden = true
        
        videosContainer.hidden = false
    }
    
    private func showNotes() {
        tabBar.selectedItem = tabBar.items![4]
        
        movesListContainer.hidden = true
        frameDataContainer.hidden = true
        combosContainer.hidden = true
        videosContainer.hidden = true
        
        notesContainer.hidden = false
    }
    
    private func newViewController(restorationId: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier(restorationId)
    }
    
    private func createMovesListViewController() -> MovesListViewController {
        let movesListViewController = self.newViewController("movesListViewController") as! MovesListViewController
        movesListViewController.targetCharacterId = targetCharacterId
        return movesListViewController
    }
    
    private func createFrameDataViewController() -> FrameDataViewController {
        let frameDataViewController = self.newViewController("frameDataViewController") as! FrameDataViewController
        frameDataViewController.targetCharacterId = targetCharacterId
        return frameDataViewController
    }
    
    private func createBnbsViewController() -> BnBViewController {
        let bnbViewController = self.newViewController("bnbsViewController") as! BnBViewController
        bnbViewController.targetCharacterId = targetCharacterId
        return bnbViewController
    }
    
    private func createRecommendedVideosViewController() -> RecommendedVideosViewController {
        let recommendedVideosVC = self.newViewController("recommendedVideosViewController") as! RecommendedVideosViewController
        recommendedVideosVC.targetCharacterId = targetCharacterId
        return recommendedVideosVC
    }
    
    private func createNotesViewController() -> UIViewController {
        return self.newViewController("notesViewController")
    }    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "embedMovesList") {
            let destination = segue.destinationViewController as! MovesListViewController
            destination.targetCharacterId = targetCharacterId
        } else if (segue.identifier == "embedFrameData") {
            let destination = segue.destinationViewController as! FrameDataViewController
            destination.targetCharacterId = targetCharacterId
        } else if (segue.identifier == "embedCombos") {
            let destination = segue.destinationViewController as! BnBViewController
            destination.targetCharacterId = targetCharacterId
        } else if (segue.identifier == "embedVideos") {
            let destination = segue.destinationViewController as! RecommendedVideosViewController
            destination.targetCharacterId = targetCharacterId
        } else if (segue.identifier == "embedNotes") {
            //nothing to do for notes yet
        }
    }
}


