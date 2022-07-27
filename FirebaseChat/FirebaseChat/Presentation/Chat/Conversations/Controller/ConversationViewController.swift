//
//  ConversationsViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ConversationViewController: MessagesViewController {
     
    init(email: String){
       self.otherUserEmail = email
       super .init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    public static var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    public var isNewConversation = true
    private var messages = [Message]()
    private var otherUserEmail: String
    private var selfSender: Sender? {
        guard let senderId = UserDefaults.standard.string(forKey: "EMAIL")  else {
            return nil
        }
     return   Sender(senderId: senderId,
               imageURL: "",
               displayName: "Mohamed Karim")}
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There")))
//        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There, Hi From There, ")))
//        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi From There, Hi From There, Hi From There, ")))
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        //title = "Conversation"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }

}

extension ConversationViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let selfSender = self.selfSender,
              let messageId = createMessageId() else {
                  return }
        // send message
        let message = Message(sender: selfSender,
                              messageId: messageId,
                              sentDate: Date(),
                              kind: .text(text))
        if isNewConversation {
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, name: self.title ?? "User",
                                                         firstMessage: message,
                                                         completion: { [ weak self ] success in
                guard let self = self else {return}
                if success {
                    self.isNewConversation = false
                    print("message sent")
                }else {
                    print("message failed")
                }
            })
        } else {
            
        }
    }
    
    func createMessageId() -> String? {
       
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "EMAIL")
              else {
            return nil }
        let safeCurrentEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let dateString = Self.dateFormatter.string(from: Date())
        let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"
        return newIdentifier
    }
    
//    func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {
//        <#code#>
//    }
//
//    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
//        <#code#>
//    }
//
//    func inputBar(_ inputBar: InputBarAccessoryView, didSwipeTextViewWith gesture: UISwipeGestureRecognizer) {
//        <#code#>
//    }
   
}

extension ConversationViewController: MessagesLayoutDelegate, MessagesDataSource, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        if let sender = selfSender {
            return sender
        }
        fatalError("Self sender is nil, email should be cashed")
       // return Sender(senderId: "", imageURL: "123", displayName: "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    
}
