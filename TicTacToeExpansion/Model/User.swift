/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Nguyen Bao Khang
    ID: s3817970
    Created  date: 12/08/2022
    Last modified: 07/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    
    init (name: String) {
        self.name = name
    }
}

func getAllUser() -> [User] {
    let users: [User] = []
    if let data = UserDefaults.standard.data(forKey: "AllUser") {
        if let decoded = try? JSONDecoder().decode([User].self, from: data) {
             return decoded
        }
    }

    return users
}

func saveUser() {
    if let encoded = try? JSONEncoder().encode(allUser) {
        UserDefaults.standard.set(encoded, forKey: "AllUser")
    }
}

var allUser = getAllUser()
