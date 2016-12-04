//
//  DraggableViewBackground.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels: [String]!
    
    var allCards: [DraggableView]!
    var users: [String]!
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 290

    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    var userImage = [UIImage]()
    var userr = [User]()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        users = []
        exampleCardLabels = ["first", "second", "third", "fourth","fifth", "last"]
        allCards = []
        loadedCards = []
        userImage = []
        cardsLoadedIndex = 0
        self.fetchUsers()
        
    }
    
    func fetchUsers()
    {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            
                let user = User(snapshot: snapshot)
                self.userr.append(user)
            
            
     
                self.reloadCards(Index: self.userr.count)
            
               //print("user afterrrrrrr")
             //  print(self.userr.count)
            
            
            
        }, withCancel: nil)
    }

    func setupView() -> Void {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1)

        xButton = UIButton(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2 + 35, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 10, width: 59, height: 59))
        xButton.setImage(UIImage(named: "xButton"), for: UIControlState())
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), for: UIControlEvents.touchUpInside)

        checkButton = UIButton(frame: CGRect(x: self.frame.size.width/2 + CARD_WIDTH/2 - 85, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 10, width: 59, height: 59))
        checkButton.setImage(UIImage(named: "checkButton"), for: UIControlState())
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), for: UIControlEvents.touchUpInside)

        self.addSubview(xButton)
        self.addSubview(checkButton)
    }

    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2, y: (self.frame.size.height - CARD_HEIGHT)/2, width: CARD_WIDTH, height: CARD_HEIGHT))
        
        
        print(index)
        print(userr[index].email)
        if let profileImageUrl = userr[index].userprofileimage{
            let url = Foundation.URL(string: profileImageUrl)
           // print(url)
            Foundation.URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
               
                DispatchQueue.main.async {
                    if let image = UIImage(data:data!)
                    {
                        draggableView.imageView?.image = UIImage(data:data!)
                    }
                }
                    //self.userImage.append(UIImage(data: data!)!)
                
            }).resume()
        }
        
        draggableView.username.text = userr[index].username
        draggableView.email.text = userr[index].email
        draggableView.userType.text = userr[index].usertypee
        //draggableView.imageView.image = userImage[index]
        draggableView.delegate = self
        return draggableView
    }

    func reloadCards(Index: Int)
    {
        let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(Index - 1)
        allCards.append(newCard)
        
        loadedCards.append(newCard)
        self.insertSubview(loadedCards[Index-1], belowSubview: loadedCards[Index - 1])
        
    }
    func loadCards() -> Void {
        if users.count > 0 {
            let numLoadedCardsCap = users.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : users.count
            for i in 0 ..< users.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }

            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    self.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }

    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)

        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }

    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }

    func swipeLeft() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
}
