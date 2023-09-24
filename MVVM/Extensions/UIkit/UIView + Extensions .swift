//
//  UIView + Extensions .swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import UIKit

extension UIView {
    
    func addViewsTAMIC(_ views: UIView) {
        self.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false
    }
}
