//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Ivica Petrsoric on 30/11/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class Friend: NSObject{
    var name: String?
    var profileImageName: String?
}

class Message: NSObject{
    
    var text: String?
    var date: Date?
    var isSender: NSNumber?
    
    var friend: Friend?
}

extension FriendsController{
    
    func setupData(){
        let mark = Friend()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let message = Message()
        message.friend = mark
        message.text = "Hello, my name is Mark. Nice to meet you..."
        message.date = Date()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let donald = Friend()
        donald.name = "Donald Trump"
        donald.profileImageName = "donald_trump_profile"
        
        let gandi = Friend()
        gandi.name = "Mahatma Gandhi"
        gandi.profileImageName = "gandhi"
        
        let hillary = Friend()
        hillary.name = "Hillary Clinton"
        hillary.profileImageName = "hillary_profile"
        
        messages = [
            message,
            createMessageWithText(text: "Hello my frined!", minutesAgo: 2, friend: steve),
            createMessageWithText(text: "What do you thinkh about Apple?Hope you are heaving a good morning!", minutesAgo: 1, friend: steve),
            createMessageWithText(text: "Apple created great iOS Devices for the world... Would you like to buy one divece from South America To Croatia, make your order!", minutesAgo: 0, friend: steve),
            createMessageWithText(text: "I'm donald TRUMP", minutesAgo: 5, friend: donald),
            createMessageWithText(text: "Lofe, peace and joy!", minutesAgo: 60 * 24, friend: gandi),
            createMessageWithText(text: "Please vote for me, you did for Billy!", minutesAgo: 8 * 60 * 24, friend: hillary),
            createMessageWithText(text: "YES, totally looking to buy an iPhone 7.", minutesAgo: 0, friend: steve, isSender: true),
            createMessageWithText(text: "Totaly undrestant that you want the new iPhone 7, you you'll have to wait until September for the new release. Sorry but thats just how Apple likes to do things", minutesAgo: 0, friend: steve),
            createMessageWithText(text: "Absolutely, I'll just se my gigantic iphone 6s plus", minutesAgo: 0, friend: steve, isSender: true),

        ]
        
        sendMessages = messages
        
        var newMessages = [Message]()
        var namesInMessage = [String]()
        
        for (_,i) in messages!.enumerated(){
            if !namesInMessage.contains((i.friend?.name)!){
                namesInMessage.append((i.friend?.name)!)
                newMessages.append(i)
            }
        }
        
        messages = newMessages
    }
    
    func createMessageWithText(text: String, minutesAgo: Double, friend: Friend, isSender: Bool = false) -> Message{
        let message = Message()
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = NSNumber(booleanLiteral: isSender)
        return message
    }
}
