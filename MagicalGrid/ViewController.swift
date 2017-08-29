//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Raghav Nyati on 8/28/17.
//  Copyright © 2017 Raghav Nyati. All rights reserved.
//

import UIKit

struct Constants{
    static let numViewPerRow = 15
}

class ViewController: UIViewController {
    
    var cells = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = view.frame.width / CGFloat(Constants.numViewPerRow)
        
        for j in 0...30{
            for i in 0...Constants.numViewPerRow{
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y:CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    var selectedCell: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(Constants.numViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print(i, j)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else{
            return
        }
        
        if selectedCell != cellView{
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

}

