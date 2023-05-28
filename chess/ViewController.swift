//
//  ViewController.swift
//  chess
//
//  Created by 陳佩琪 on 2023/5/28.
//

import UIKit

class ViewController: UIViewController {
    

    var i :[Int] = []
    var j :[Int] = []
    
    let themeDarkBrown = UIColor(red: 182/255, green: 136/255, blue: 100/255, alpha: 1)
    let themLightBrown = UIColor(red: 241/255, green: 217/255, blue: 181/255, alpha: 1)
    var buttons:[UIButton] = []
    
    var answerRow:[Int] = []
    var answerColumn:[Int] = []
    let winLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeCheckerboard()
        
        
        let showAnswersButton = UIButton(type: .system,primaryAction: UIAction(handler:  { [unowned self] action in
            lookUpAnswers()
            eightQueens()
        }))
        showAnswersButton.frame = CGRect(x: 215, y: 600, width: 140, height: 45)
        showAnswersButton.setTitle("Show Answer(s)", for: .normal)
        showAnswersButton.tintColor = UIColor.white
        buttons.append(showAnswersButton)
        
        let resetButton = UIButton(type: .system,primaryAction: UIAction(handler: { [unowned self] action in
            makeCheckerboard()
         }))
        resetButton.frame = CGRect(x: 25, y: 600, width: 140, height: 45)
        resetButton.setTitle("Restart", for: .normal)
        buttons.append(resetButton)
        
        for button in buttons {
            button.backgroundColor = themeDarkBrown
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            view.addSubview(button)
        }
        

        winLabel.text = "You\nWin\n👑"
        winLabel.numberOfLines = 0
        winLabel.textAlignment = .center
        winLabel.font = UIFont.boldSystemFont(ofSize: 48)
        winLabel.backgroundColor = UIColor(white: 1, alpha: 0.92)
        winLabel.layer.cornerRadius = 40
        winLabel.clipsToBounds = true
        winLabel.frame = CGRect(x: 51, y: 228, width: 288, height: 288)
        view.addSubview(winLabel)
        
        
        let titleImageView = UIImageView()
        titleImageView.image = UIImage(named: "title")
        titleImageView.frame = CGRect(x: 48.75, y: 12, width: 292.5, height: 166.5)
        view.addSubview(titleImageView)
        
        let chessView = UIView()
        let chessImage = UIImageView()
        chessImage.image = UIImage(named: "chess")
        chessImage.frame = CGRect(x: 0, y: 0, width: 195, height: 111)
        chessView.frame = chessImage.frame
        chessView.backgroundColor = themeDarkBrown
        chessView.frame = CGRect(x: 102.5, y: 670, width: 195, height: 111)
        chessView.addSubview(chessImage)
        view.addSubview(chessView)
            }
    
    func lookUpAnswers() {
        
        var x = [1,2,3,4,5,6,7,8]
        var y = [1,2,3,4,5,6,7,8]
        var sums:[Int] = []
        var differences:[Int] = []
        var numbering = 1
        var a = 0
        var b = 0
        var loopTimes = 0
        
        
        
        while !x.isEmpty {
            
            if x.count > 1 {
                a = 0
                b = Int.random(in: 0..<y.count)
            } else {
                a = 0
                b = 0
            }
            
            let sumCheck = x[a]+y[b]
            let differenceCheck = x[a]-y[b]
            
                
                if !sums.contains(sumCheck) && !differences.contains(differenceCheck) {
                    print("\(numbering).(\(x[a]),\(y[b]))")
                        i.append(x[a])
                        j.append(y[b])
                        x.remove(at: a)
                        y.remove(at: b)
                        a += 1
                        numbering += 1
                    
                    
                    sums.append(sumCheck)
                    differences.append(differenceCheck)

                    print(sums)
                    print(differences)
                    
                    
                    } else {
                        x = [1,2,3,4,5,6,7,8]
                        y = [1,2,3,4,5,6,7,8]
                        a = 0
                        numbering = 1
                        loopTimes += 1
                        i.removeAll()
                        j.removeAll()
                        sums.removeAll()
                        differences.removeAll()
                        print("loop",loopTimes)
                    }
            }
    }
    
    
    func eightQueens() {
        for row in 1...8 {
            for column in 1...8 {
                let button = UIButton(type: .system)
                button.frame = CGRect(x: 3 + 48 * (row-1), y: 180 + 48 * (column-1), width:48 , height:48 )
                
                if (row + column) % 2 == 0 {
                    button.backgroundColor = themeDarkBrown
                } else {
                    button.backgroundColor = themLightBrown
                }
                
                let index = i.firstIndex(of: row)
                
                if column == j[index!] {
                    button.setTitle("♛", for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 48)
                    button.tintColor = UIColor.black
                }

                view.addSubview(button)
            }
        }

    }
    
    
    func makeCheckerboard() {

        winLabel.isHidden = true
        answerRow.removeAll()
        answerColumn.removeAll()
        var queenCount = 0
        var moveCount = 0
        var wrongStatus:Bool = false
        
        for row in 1...8 {
            for column in 1...8 {
                let button = UIButton(type: .system)
                
                button.addAction(UIAction(handler:  { [self, weak button] _ in
                    
                    if button?.currentTitle == nil {
                        button?.setTitle("♛", for: .normal)
                        button?.tintColor = UIColor.black
                        button?.titleLabel?.font = UIFont.systemFont(ofSize: 48)
                        queenCount += 1
                        moveCount += 1
                        print("queen",queenCount,"move",moveCount)
                        
                    for i in 0..<answerRow.count {
                        if (row + column == answerRow[i]+answerColumn[i]) || (row - column == answerRow[i]-answerColumn[i]) || (row == answerRow[i]) || (column == answerColumn[i]) {
                            wrongStatus = true
                        }
                    }
                        if wrongStatus == true {
                            button?.tintColor = UIColor.red
                            queenCount -= 1
                            print("wrong move: queen",queenCount,"move",moveCount)
                            wrongStatus = false
                        }
                        
                        answerRow.append(row)
                        answerColumn.append(column)
                        print("answerRow",answerRow)
                        print("answerColumn",answerColumn)
                        
                        
                        
                    } else {
                        button?.setTitle(nil, for: .normal)
                        
                        print("removed before: queen",queenCount,"move",moveCount)
                        if queenCount == moveCount {
                            queenCount -= 1
                            moveCount -= 1
                        } else {
                            moveCount -= 1
                        }
                        print("removed after: queen",queenCount,"move",moveCount)
                        
                        
                        if answerRow.contains(row)  {
                                let index = answerRow.lastIndex(where: {$0 == row})
                                print("index to be removed",index)
                                answerRow.remove(at: index!)
                                print("removed answerRow",answerRow)
                                answerColumn.remove(at: index!)
                                print("removed answerColumn",answerColumn)
                            }
                        
                    
                        
                    }
                    
                    if queenCount == 8 {
                        view.addSubview(winLabel)
                        winLabel.isHidden = false
                    }
                    
                }), for: .touchUpInside)
                                      
                button.frame = CGRect(x: 3 + 48 * (row-1), y: 180 + 48 * (column-1), width:48 , height:48 )

                if (row + column) % 2 == 0 {
                    button.backgroundColor = themeDarkBrown
                } else {
                    button.backgroundColor = themLightBrown
                }

                view.addSubview(button)
            }
        }

    }
        }
        
        
                                      
