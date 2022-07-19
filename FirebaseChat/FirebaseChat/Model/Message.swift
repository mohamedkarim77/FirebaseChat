//
//  File.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 19/07/2022.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

struct Sender: SenderType {
    var senderId: String
    var imageURL: String
    var displayName: String
    
}
