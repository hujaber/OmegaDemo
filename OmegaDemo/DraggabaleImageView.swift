//
//  DraggabaleImageView.swift
//  OmegaDemo
//
//  Created by Administrator on 7/20/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit

class DraggabaleImageView: UIImageView {

    var lastLocation:CGPoint =  CGPoint.init(x: 0, y: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.detectRecognizer(recognizer:)))
        gestureRecognizers = [panRecognizer]
        isUserInteractionEnabled = true
    }

    override init(image: UIImage?) {
        super.init(image: image)
        let panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.detectRecognizer(recognizer:)))
        gestureRecognizers = [panRecognizer]
        isUserInteractionEnabled = true
        let rotateRec = UIRotationGestureRecognizer.init(target: self, action: #selector(self.detectRotation(recognizer:)))
        gestureRecognizers?.append(rotateRec)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func detectRecognizer(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: superview)
        center = CGPoint.init(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }

    func detectRotation(recognizer: UIRotationGestureRecognizer) {
        transform = CGAffineTransform.init(rotationAngle: recognizer.rotation)
        print(recognizer.rotation)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.bringSubview(toFront: self)
        lastLocation = center
    }
}
