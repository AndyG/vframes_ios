//
//  NetworkDataSourceListenerProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 2/15/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

protocol NetworkDataSourceListenerProtocol {
    func onResult(result: GetNetworkDataResult)
}