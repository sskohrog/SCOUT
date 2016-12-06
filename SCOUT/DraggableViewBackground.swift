//
//  DraggableViewBackground.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//  Used by Mohammed Islubee & Sophie Kohrogi

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

    //initializer of profile boxes
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        users = []
        allCards = []
        loadedCards = []
        userImage = []
        cardsLoadedIndex = 0
        self.fetchUsers()
        
    }
    
    // fetchUsers()
    //
    // Gets all the users in the database and places them inside thr userr array
    func fetchUsers() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            
                let user = User(snapshot: snapshot)
                self.userr.append(user)
     
                self.reloadCards(Index: self.userr.count)
        
        }, withCancel: nil)
    }

    // setupView() -> Void
    //
    // Sets up the view
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
        
        print(userr[index].email)
        if let profileImageUrl = userr[index].userprofileimage {
            let url = Foundation.URL(string: profileImageUrl)

            Foundation.URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
               
                DispatchQueue.main.async {
                    if let image = UIImage(data:data!) {
                        draggableView.imageView?.image = UIImage(data:data!)
                    }
                }
            }).resume()
        }
        
        draggableView.username.text = userr[index].username
        draggableView.email.setTitle(userr[index].email, for: .normal)
        draggableView.userType.text = userr[index].usertypee
        draggableView.delegate = self
        return draggableView
    }

    func reloadCards(Index: Int) {
        let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(Index - 1)
        allCards.append(newCard)
        
        loadedCards.append(newCard)
        self.insertSubview(loadedCards[Index-1], belowSubview: loadedCards[Index - 1])
        
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
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
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
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            dragView.overlayView.alpha = 1
        })
        
        dragView.leftClickAction()
    }
}
