//
//  InputElementCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class InputElementCell: UICollectionViewCell {
    @IBOutlet weak var inputImage: UIImageView!
    
    func setInput(inputElement: InputElement) {
        var imageId: String
        switch(inputElement) {
        case .ALL_KICKS:
            imageId = "input_icon_all_kicks"
        case .ALL_PUNCHES:
            imageId = "input_icon_all_punches"
        case .ARROW:
            imageId = "input_icon_arrow"
        case .BACK:
            imageId = "input_direction_back"
        case .CHARGE_BACK:
            imageId = "input_direction_charge_back"
        case .CHARGE_DOWN:
            imageId = "input_direction_charge_down"
        case .DOWN:
            imageId = "input_direction_down"
        case .DOWN_BACK:
            imageId = "input_direction_down_back"
        case .DOWN_FORWARD:
            imageId = "input_direction_down_forward"
        case .FORWARD:
            imageId = "input_direction_forward"
        case .HCB:
            imageId = "input_direction_hcb"
        case .HCF:
            imageId = "input_direction_hcf"
        case .HK:
            imageId = "input_icon_hk"
        case .HP:
            imageId = "input_icon_hp"
        case .KICK:
            imageId = "input_icon_generic_kick"
        case .LK:
            imageId = "input_icon_lk"
        case .LP:
            imageId = "input_icon_lp"
        case .MK:
            imageId = "input_icon_mk"
        case .MP:
            imageId = "input_icon_mp"
        case .PLUS:
            imageId = "input_icon_plus"
        case .PUNCH:
            imageId = "input_icon_generic_punch"
        case .QCB:
            imageId = "input_direction_qcb"
        case .QCF:
            imageId = "input_direction_qcf"
        case .RELEASE_FORWARD:
            imageId = "input_direction_release_forward"
        case .RELEASE_UP:
            imageId = "input_direction_release_up"
        case .SPD:
            imageId = "input_direction_spd"
        case .SRK:
            imageId = "input_direction_srk"
        case .SRK_BACK:
            imageId = "input_direction_srk_back"
        case .UP:
            imageId = "input_direction_up"
        case .UP_BACK:
            imageId = "input_direction_up_back"
        case .UP_FORWARD:
            imageId = "input_direction_up_forward"
        default:
            imageId = "input_icon_unknown"
        }
        inputImage.image = UIImage(named: imageId)
    }
    
}
