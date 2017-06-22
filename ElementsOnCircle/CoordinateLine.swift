//
//  CoordinateLine.swift
//  ElementsOnCircle
//
//  Created by Эрик Вильданов on 22.06.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

struct Coordinate {
    var startPoint: [CGPoint] = []
    var endPoint: [CGPoint] = []
}

class CoordinateLine {
    
    var hord: Double
    var diameter: Double
    var radius: Double
    var hord_02: Double
    
    let angle: Double
    let angle_02: Double
    let centralAngle: Double
    let centralAngle_02: Double
    let arcLength: Double
    let circleLength: Double

    
    let xCentral = UIScreen.main.bounds.size.width/2
    let yCentral = UIScreen.main.bounds.size.height/2
    
    var  coordinatePoint = Coordinate()
    var numberOfLines: Int
    
    init(radius: Double, hord: Double) {
        self.hord = hord
        self.radius = radius
        self.diameter = 2*radius
        self.hord_02 = hord*0.2
        self.angle = asin(hord/self.diameter)
        self.angle_02 = asin(hord_02/self.diameter)
        self.centralAngle = angle*360/Double.pi
        self.centralAngle_02 = angle_02*360/Double.pi
        self.arcLength = self.diameter*self.angle
        self.circleLength = 2*Double.pi*self.radius
        self.numberOfLines = Int(circleLength/(arcLength + self.diameter*self.angle_02))
    }
    
    func calcPoint(centralAngle_02: Double) -> Coordinate{
        
        let ii = Int(circleLength/arcLength)*2
        var commonAngle: Double = 0
        
        for i in 0..<ii{
            
            var point = CGPoint()
            
            if i%2==0 {
                commonAngle += centralAngle
            } else {
                commonAngle += centralAngle_02
            }
            
            guard commonAngle + centralAngle_02 <= 360 else {
                break
            }
            
            
            point.x = xCentral + CGFloat(radius * cos(commonAngle*Double.pi/180))
            point.y = yCentral + CGFloat(radius * sin(commonAngle*Double.pi/180))

            coordinatePoint.startPoint.append(point)
            
            if i == 0 {
                point.x = UIScreen.main.bounds.size.width/2 + CGFloat(radius)
                point.y = UIScreen.main.bounds.size.height/2
            } else {
                point.x = coordinatePoint.startPoint[i-1].x
                point.y = coordinatePoint.startPoint[i-1].y
            }
            
            coordinatePoint.endPoint.append(point)
            }
        return coordinatePoint
        
    }

    
    
    
}
