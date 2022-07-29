//
//  Conversation.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 28/07/2022.
//

import Foundation

struct Chat {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}


struct LatestMessage{
    let date: String
    let text: String
    let isRead: Bool
}
