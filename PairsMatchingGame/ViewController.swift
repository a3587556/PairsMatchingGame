//
//  ViewController.swift
//  PairsMatchingGame
//
//  Created by darkgod on 14/11/12.
//  Copyright (c) 2014 darkgod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var revealButton: UIButton! = UIButton()
    var shuffleButton: UIButton! = UIButton()
    var stepper: UIStepper! = UIStepper()
    var pairsCount: Int {
        return Int(stepper.value)
    }
    var cardsCount: Int {
        return pairsCount * 2
    }
    var gameLayout = GameLayout()
    var cardViews = [CardView]()
    var firstSelectedCardView: CardView?
    var matchedPairs: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupControls()
        //setupCards()
        shuffleCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupControls() {
        // An UIStepper
        let stepperFrame = CGRect(x: 113, y: 20, width: 94, height: 29)
        // An UIButton
        let revealButtonFrame = CGRect(x: 16, y: 20, width: 55, height: 30)
        // An UIButton
        let shuffleButtonFrame = CGRect(x: 256, y: 20, width: 56, height: 30)
        
        // TODO: Add the UI controls in code.
        let rButton = UIButton()
        rButton.frame = revealButtonFrame
        rButton.setTitle("Reveal", forState: UIControlState.Normal)
        rButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.revealButton = rButton
        self.view.addSubview(self.revealButton)
        rButton.addTarget(self, action: "revealTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let sButton = UIButton()
        sButton.frame = shuffleButtonFrame
        sButton.setTitle("Shuffle", forState: UIControlState.Normal)
        sButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.shuffleButton = sButton
        self.view.addSubview(self.shuffleButton)
        sButton.addTarget(self, action: "shuffleTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // TODO: Configure the stepper to allow values beween 1 and 10 (default: 4).
        // The step increment should be 1.
        let stepper = UIStepper(frame: stepperFrame)
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 4
        self.stepper = stepper
        self.view.addSubview(self.stepper)
        stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func shuffleTapped(button: UIButton) {
        self.shuffleCards()
    }
    
    func revealCards() {
        for cardView in self.cardViews {
            cardView.selected = true
        }
    }
    
    func hideCards() {
        for cardView in self.cardViews {
            cardView.selected = false
        }
    }
    
    func revealTapped(button: UIButton) {
        self.revealCards()
    }
    
    func assignCards() {
        // assign cards to cardViews
        var deck = Card.fullDeck()
        shuffle(&deck)
        var pairs = [Card]()
        for i in 0..<self.pairsCount {
            let card = deck[i]
            pairs.append(card)
            pairs.append(card)
        }
        shuffle(&pairs)
        for (i,cardView) in enumerate(cardViews) {
            cardView.card = pairs[i]
        }
    }
    
    func setupLayout() {
        var toRemove = self.cardViews.count - self.cardsCount
        // TODO: Remove excess card views
        while (toRemove > 0) {
            let cardView = self.cardViews.removeLast()
            cardView.removeFromSuperview()
            toRemove--
        }
        
        var toAdd = self.cardsCount - self.cardViews.count
        // TODO: Add card views
        let grid = gameLayout.grid
        while (toAdd > 0) {
            let cardView = CardView()
            let rectIndex = (toAdd % 1) + self.cardViews.count
            let test = self.cardViews.count
            cardView.frame = grid[rectIndex]
            cardViews.append(cardView)
            self.view.addSubview(cardView)
            toAdd--
        }

    }
    
    func shuffleCards() {
        for cardV in cardViews {
            cardV.removeFromSuperview()
        }
        cardViews.removeAll(keepCapacity: true)
        
        matchedPairs = 0
        let rects = gameLayout.forPairs(self.pairsCount)
        for rectIndex in 0..<self.cardsCount {
            let cardView = CardView()
            cardView.addTarget(self, action: "tapCardView:", forControlEvents: UIControlEvents.TouchUpInside)
            cardView.frame = rects[rectIndex]
            cardViews.append(cardView)
            self.view.addSubview(cardView)
        }
        self.assignCards()
        self.revealCards()
        delay(1.0,hideCards)
        
    }
    
    func stepperValueChanged(stepper: UIStepper) {
        //setupLayout()
        shuffleCards()
    }
    
    func setupCards() {
      
            for rectIndex in 0..<self.cardsCount {
                let cardView = CardView(frame: gameLayout.grid[rectIndex])
                cardView.frame = gameLayout.grid[rectIndex]
                cardView.addTarget(self, action: "tapCardView:", forControlEvents: UIControlEvents.TouchUpInside)
                cardViews.append(cardView)
                self.view.addSubview(cardView)
            }
            assignCards()
    }
    
    func showWinMessage() {
        let alert = UIAlertController(title: "You Won", message: "Play another game!", preferredStyle: UIAlertControllerStyle.Alert)
        let shuffle = UIAlertAction(title: "Shuffle", style: UIAlertActionStyle.Default, handler: {
            _ in
            self.shuffleCards()
        })
        
        alert.addAction(shuffle)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func foundMatchingPair(#a: CardView, b: CardView) {
        self.matchedPairs++
        if self.matchedPairs == self.pairsCount {
            self.showWinMessage()
        }
    }
    
    func tapCardView(cardView: CardView) {
        //println("test")
        if (cardView.selected == true) {
            return
        }
        
        if (self.firstSelectedCardView == nil) {
            cardView.selected = true
            firstSelectedCardView = cardView
            return
        }
        
        cardView.selected = true
        var first = firstSelectedCardView!
        firstSelectedCardView = nil
        
        if first.card! == cardView.card! {
            self.foundMatchingPair(a: first, b: cardView)
        } else {
            delay(0.3, hideCards)
            self.matchedPairs = 0
        }
    }


}

