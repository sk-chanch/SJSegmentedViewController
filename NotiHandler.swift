//
//  NotiHandler.swift
//  SJSegmentedScrollView
//
//  Created by Chanchana Koedtho on 27/5/2564 BE.
//

import Foundation

public struct NotiHandler {
   
    static let shared = NotiHandler()
    let key:String
    private init() {
        key = "\(Date().timeIntervalSince1970)"
    }
}
