//
//  UITableView+Register.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type,
                                                        for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self),
                                        for: indexPath) as! T
    }
}
