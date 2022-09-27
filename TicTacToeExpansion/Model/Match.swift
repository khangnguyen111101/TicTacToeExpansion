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
 
class Match: Identifiable, Codable {
    var id = UUID()
    var user: String
    var goal: Int
    var difficulty: String
    var result: String?
    
    init (user: String, goal: Int, difficulty: String) {
        self.user = user
        self.goal = goal
        self.difficulty = difficulty
    }
}

func getAllMatch() -> [Match] {
    let matches: [Match] = []
    if let data = UserDefaults.standard.data(forKey: "AllMatch") {
        if let decoded = try? JSONDecoder().decode([Match].self, from: data) {
             return decoded
        }
    }

    return matches
}

func saveMatch() {
    if let encoded = try? JSONEncoder().encode(allMatch) {
        UserDefaults.standard.set(encoded, forKey: "AllMatch")
    }
}

var allMatch = getAllMatch()
