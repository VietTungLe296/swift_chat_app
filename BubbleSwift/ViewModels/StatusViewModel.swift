//
//  StatusViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import Foundation

final class StatusViewModel: ObservableObject {
    
    @Published var status: UserStatus = .notConfigured
    
    func updateStatus(_ status: UserStatus) {
        self.status = status
    }
}


enum UserStatus: String, CaseIterable {
    case notConfigured = "Click here to update"
    case available = "Available"
    case school = "School"
    case movies = "Movies"
    case work = "Work"
    case batteryLow = "Battery Low"
    case meeting = "On the meeting"
    case gym = "Gym"
    case sleeping = "Sleeping"
    case urgentCallsOnly = "Urgent calls only"
}
