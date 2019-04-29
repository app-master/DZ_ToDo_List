//
//  String+Extension.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

extension String {
    
    var capitalizedWithSpace: String {
        
        let str = self.reduce("") { (result, char) -> String in
            if char.isUppercase {
                return "\(result) \(char)"
            } else {
                return "\(result)\(char)"
            }
        }
        
        return str.capitalized
    }
    
}

