//
//  RMExtensions.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/16/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach ({
            addSubview($0)
        })
    }
}

extension String {
    func addWhitespaceBeforeCapitalLetters() -> String {
        guard !self.isEmpty else { return self }

        var output = ""
        output.append(self.first!) // Add the first character to the output string

        for (previous, current) in zip(self, self.dropFirst()) {
            if CharacterSet.uppercaseLetters.contains(current.unicodeScalars.first!) && !CharacterSet.uppercaseLetters.contains(previous.unicodeScalars.first!) {
                // If the current character is a capital letter and the previous character is not, insert a whitespace
                output.append(" ")
            }
            output.append(current) // Add the current character to the output string
        }

        return output
    }
}


extension Bundle {
    var appName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
