//
//  VIewProtocol.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit

protocol Initialization:NSObjectProtocol{
    
    /// init
    dynamic func initializeSubViews()
    
    /// add in View
    dynamic func addSubViews()
    
    /// Set constraints
    dynamic func setupSubViewMargins()
    
    /// Quick settings navigation bar Items
    dynamic func setupNavigationItems()
    
    
}
