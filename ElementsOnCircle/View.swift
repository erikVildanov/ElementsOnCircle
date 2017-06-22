//
//  View.swift
//  ElementsOnCircle
//
//  Created by Эрик Вильданов on 22.06.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class View: UIView {

    let radTextField = UITextField()
    let widthTextField = UITextField()
    let calcButton = UIButton()
    let evenlyButton = UIButton()
    let answerLbl = UILabel()
    var path = UIBezierPath()
    var line = CAShapeLayer()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        initializeView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(){
        addSubview(radTextField)
        radTextField.placeholder = " Радиус"
        radTextField.backgroundColor = UIColor.gray
        radTextField.keyboardType = UIKeyboardType.numberPad
        radTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(widthTextField)
        widthTextField.placeholder = " Длинны хорды"
        widthTextField.backgroundColor = UIColor.gray
        widthTextField.keyboardType = UIKeyboardType.numberPad
        widthTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(evenlyButton)
        addSubview(calcButton)
        calcButton.translatesAutoresizingMaskIntoConstraints = false
        evenlyButton.translatesAutoresizingMaskIntoConstraints = false
        calcButton.setTitle("Расчитать", for: [])
        evenlyButton.setTitle("Равномерно", for: [])
        
        calcButton.backgroundColor = UIColor.black
        evenlyButton.backgroundColor = UIColor.black
        
        addSubview(answerLbl)
        answerLbl.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[radTextField(==widthTextField)]-20-[widthTextField]-10-|", options: [], metrics: nil, views: ["radTextField": radTextField, "widthTextField": widthTextField]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[radTextField(30)]", options: [], metrics: nil, views: ["radTextField": radTextField]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[widthTextField(30)]", options: [], metrics: nil, views: ["widthTextField": widthTextField]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[calcButton(30)]-20-|", options: [], metrics: nil, views: ["calcButton": calcButton]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[answerLbl(20)]-20-[evenlyButton(30)]-20-|", options: [], metrics: nil, views: ["evenlyButton": evenlyButton, "answerLbl": answerLbl]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[calcButton(==evenlyButton)]-20-[evenlyButton]-10-|", options: [], metrics: nil, views: ["calcButton": calcButton, "evenlyButton": evenlyButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[answerLbl(50)]-20-|", options: [], metrics: nil, views: ["answerLbl": answerLbl]))
        
    }

    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        line = CAShapeLayer()
        path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        line.path = path.cgPath
        line.strokeColor = UIColor.black.cgColor
        line.lineWidth = 2
        line.lineJoin = kCALineJoinRound
        layer.addSublayer(line)
    }
    
    func drawCircle(rad: CGFloat){
        path = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.size.width/2,y: UIScreen.main.bounds.size.height/2), radius: CGFloat(rad), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        line = CAShapeLayer()
        line.path = path.cgPath
        //change the fill color
        line.fillColor = UIColor.blue.cgColor
        //you can change the stroke color
        line.strokeColor = UIColor.red.cgColor
        //you can change the line width
        line.lineWidth = 2.0
        layer.addSublayer(line)
    }
    
}
