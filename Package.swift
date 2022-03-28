// swift-tools-version:5.5
//
//  Package.swift
//  SJSegmentedScrollViewDemo
//
//  Created by Chanchana Koedtho on 28/3/2565 BE.
//  Copyright © 2565 BE CocoaPods. All rights reserved.
//


import PackageDescription

let package = Package(
    name: "SJSegmentedViewController",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "SJSegmentedViewController", targets: ["SJSegmentedViewController"]),
    ],
    targets: [
        .target(name: "SJSegmentedViewController", path: "SJSegmentedScrollView/Classes")
    ]
)
