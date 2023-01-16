//
//  RMExtensions.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/16/23.
//

import UIKit

/// printSomething is the new "print" function since fucking autocomplete works against me with printContent
public func printSomething(something: String){
   print(something)
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach ({
            addSubview($0)
        })
    }
}
