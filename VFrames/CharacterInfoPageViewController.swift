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
        return [self.newViewController("movesListViewController"), self.newViewController("frameDataViewController")]
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
        
        if let firstViewController = orderedViewControllers.first as? MovesListViewController {
            firstViewController.targetCharacterId = targetCharacterId
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
}

extension CharacterInfoPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            if viewController.isKindOfClass(MovesListViewController) {
                return nil
            } else {
                let movesListViewController = self.newViewController("movesListViewController") as! MovesListViewController
                movesListViewController.targetCharacterId = targetCharacterId
                return movesListViewController
            }
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            if viewController.isKindOfClass(MovesListViewController) {
                return self.newViewController("frameDataViewController")
            } else {
                return nil
            }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}


