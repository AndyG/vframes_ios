//
//  CharacterInfoPageViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/11/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoPageViewController: UIPageViewController {
    
    var targetCharacterId: CharacterID!
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.createFrameDataViewController(),
            self.createMovesListViewController(),
            self.createBnbsViewController(),
            self.createRecommendedVideosViewController(),
            self.createNotesViewController()]
    }()
    
    private func newViewController(restorationId: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier(restorationId)
    }
    
    override func viewDidLoad() {
        setUpPageControlAppearance()
        let backgroundColor = UIColor.groupTableViewBackgroundColor()
        view.backgroundColor = backgroundColor
        
        title = CharacterID.toString(targetCharacterId)
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first as? FrameDataViewController {
            setViewControllers([firstViewController],
                direction: .Forward,
                animated: true,
                completion: nil)
        }
    }
    
    private func setUpPageControlAppearance() {
        let pageControlAppearance = UIPageControl.appearance()
        
        let backgroundColor = UIColor.groupTableViewBackgroundColor()
        pageControlAppearance.backgroundColor = backgroundColor
        
        let characterColor = UIColor().getPrimaryColorForCharacter(targetCharacterId)
        let characterColorFaded = characterColor.colorWithAlphaComponent(0.5)
        pageControlAppearance.currentPageIndicatorTintColor = characterColor
        pageControlAppearance.pageIndicatorTintColor = characterColorFaded
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
}

extension CharacterInfoPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            if viewController.isKindOfClass(FrameDataViewController) {
                return nil
            } else if viewController.isKindOfClass(MovesListViewController) {
                return createFrameDataViewController()
            } else if viewController.isKindOfClass(BnBViewController) {
                return createMovesListViewController()
            } else if viewController.isKindOfClass(RecommendedVideosViewController) {
                return createBnbsViewController()
            } else if viewController.isKindOfClass(NotesViewController) {
                return createRecommendedVideosViewController()
            } else {
                return nil
            }
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            if viewController.isKindOfClass(FrameDataViewController) {
                return createMovesListViewController()
            } else if viewController.isKindOfClass(MovesListViewController) {
                return createBnbsViewController()
            } else if viewController.isKindOfClass(BnBViewController) {
                return createRecommendedVideosViewController()
            } else if viewController.isKindOfClass(RecommendedVideosViewController) {
                return createNotesViewController()
            } else if viewController.isKindOfClass(NotesViewController) {
                return nil
            } else {
                return nil
            }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 5
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}


