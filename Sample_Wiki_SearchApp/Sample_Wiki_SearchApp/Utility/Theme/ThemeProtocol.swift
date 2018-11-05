//
//  ThemeProtocol.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 30/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainFontName: String { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var tint: UIColor { get }
}
