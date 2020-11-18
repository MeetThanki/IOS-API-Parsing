//
//  UserModel.swift
//  JsonParsingOne
//
//  Created by Meet Thanki on 20/10/20.
//

import Foundation

struct UserModel: Decodable {
    let users_list: [UsersList]
    let status: Bool
    let message: String

}

struct UsersList: Decodable {
    let user_id, user_name, user_mobile, user_status,created_date: String
}
