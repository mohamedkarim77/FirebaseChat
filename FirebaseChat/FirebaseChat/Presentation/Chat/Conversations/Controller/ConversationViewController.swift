//
//  ConversationsViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit
import MessageKit

class ConversationViewController: MessagesViewController {

    private var messages = [Message]()
    
   private var selfSender = Sender(senderId: "1", imageURL: "", displayName: "Mohamed Karim")
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There")))
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There, Hi From There, ")))
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There, Hi From There, Hi From There, ")))
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        view.backgroundColor = .orange
        title = "Conversation"
    }

}
extension ConversationViewController: MessagesLayoutDelegate, MessagesDataSource, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    
}

//extension ConversationViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//
//}
//
//extension ConversationViewController: UICollectionViewDelegate {
//
//}
//
//extension ConversationViewController: UICollectionViewDelegateFlowLayout {
//
//}
