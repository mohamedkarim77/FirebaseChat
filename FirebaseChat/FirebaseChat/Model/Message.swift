//
//  File.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 19/07/2022.
//

import Foundation
import MessageKit

struct Message: MessageType {
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    
}

struct Sender: SenderType {
    public var senderId: String
    public var imageURL: String
    public var displayName: String
    
}

extension MessageKind {
    var messageKindString: String {
        switch self {case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "linkPreview"
        case .custom(_):
            return "custom"
        }
    }
}
