//
//  BasePresenterView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Foundation

@objc protocol BasePresenterView {
    @objc optional func onLoadingStart()
    @objc optional func onLoadingEnd()
    @objc optional func onError(error: String)
}
