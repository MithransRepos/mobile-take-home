//
//  StringExtensions.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/9/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
/*
 String extensions
 */
extension String
{
    func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}
