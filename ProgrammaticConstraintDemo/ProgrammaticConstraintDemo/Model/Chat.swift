//
//  Chat.swift
//  ProgrammaticConstraintDemo
//
//  Created by MacPro3 on 10/11/21.
//

import UIKit

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}
extension Chat{
    init(dictionary:[String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {
            self.init(users: [])
            return
        }
        self.init(users: chatUsers)
        
    }
}
