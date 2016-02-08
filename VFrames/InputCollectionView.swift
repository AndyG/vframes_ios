//
//  InputCollectionView.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class InputCollectionView: UICollectionView {
    private var inputArray: Array<InputElement>!
    
    func setInput(inputArray: Array<InputElement>) {
        self.inputArray = inputArray
        reloadData()
    }
    
    func getInputArray() -> Array<InputElement> {
        return inputArray
    }
}
