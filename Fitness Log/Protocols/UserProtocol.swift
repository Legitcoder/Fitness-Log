//
//  UserControllerProtocol.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

protocol UserProtocol {
    var userController: UserController? {get set}
    var user: User? {get set}
}
