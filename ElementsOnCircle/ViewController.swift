//
//  ViewController.swift
//  ElementsOnCircle
//
//  Created by Эрик Вильданов on 22.06.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myView = View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        myView.calcButton.addTarget(self, action: #selector(buttonCalc(button:)), for: .touchDown)
        myView.evenlyButton.addTarget(self, action: #selector(buttonEvenly(button:)), for: .touchDown)
        addDoneButton()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: nil, action: #selector(checkValue))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        myView.radTextField.inputAccessoryView = keyboardToolbar
        myView.widthTextField.inputAccessoryView = keyboardToolbar
    }
    
    func checkValue(){
        if myView.radTextField.text == "" && myView.widthTextField.text == "" {
            let alert = UIAlertController(title: "Заполнены не все поля", message: "", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion:{
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            })
        } else if 2 * Int(myView.radTextField.text!)! < Int(myView.widthTextField.text!)! {
            let alert = UIAlertController(title: "Хорда не может быть больше диаметра", message: "", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion:{
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            })
        } else {
            self.view.endEditing(true)
            myView.path.removeAllPoints()
            myView.line.removeFromSuperlayer()
            
        }
    }
    
    func buttonCalc(button: UIButton){
        let coordLine = CoordinateLine(radius: Double(myView.radTextField.text!)!, hord: Double(myView.widthTextField.text!)!)
        calcAndDraw(centralAngle_02: coordLine.centralAngle_02)
    }
    
    func buttonEvenly(button: UIButton){
        let coordLine = CoordinateLine(radius: Double(myView.radTextField.text!)!, hord: Double(myView.widthTextField.text!)!)
        let summCentrlAngle = Double(coordLine.numberOfLines) * coordLine.centralAngle
        let newCentralAngle_02 = (360 - summCentrlAngle)/Double(coordLine.numberOfLines)
        calcAndDraw(centralAngle_02: newCentralAngle_02)
    }
    
    func calcAndDraw(centralAngle_02: Double){
        let coordLine = CoordinateLine(radius: Double(myView.radTextField.text!)!, hord: Double(myView.widthTextField.text!)!)
        let point = coordLine.calcPoint(centralAngle_02: centralAngle_02)
        myView.drawCircle(rad: CGFloat(coordLine.radius))
        for i in 0..<point.endPoint.count {
            myView.addLine(fromPoint: point.startPoint[i], toPoint: point.endPoint[i])
        }
        myView.answerLbl.text = "\(Int(coordLine.numberOfLines))"
        
    }
    
    func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

