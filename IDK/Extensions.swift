//
//  Extensions.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 3/18/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

//extension UIColor {
//
//    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
//        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
//    }
//
//}
//
//extension UIView {
//    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
//        }
//
//        if let left = left {
//            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
//        }
//
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
//        }
//
//        if let right = right {
//            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
//        }
//
//        if width != 0 {
//            widthAnchor.constraint(equalToConstant: width).isActive = true
//        }
//
//        if height != 0 {
//            heightAnchor.constraint(equalToConstant: height).isActive = true
//        }
//    }
//
//}

//MARK: - 2nd Version with leading trailing 

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

}

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, centerXConstant: CGFloat = 0, centerYConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    var anchors = [NSLayoutConstraint]()

    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
    }

    if let leading = leading {
      anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
    }

    if let trailing = trailing {
      anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
    }

    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }

    if let centerX = centerX {
      anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant))
    }

    if let centerY = centerY {
      anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant))
    }

    if let width = width {
      anchors.append(widthAnchor.constraint(equalTo: width, constant: widthConstant))
    } else if widthConstant != 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
    }

    if let height = height {
      anchors.append(heightAnchor.constraint(equalTo: height, constant: heightConstant))
    } else if heightConstant != 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
    }

    anchors.forEach({$0.isActive = true})
  }
}

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
  }

  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(r: r, g: g, b: b, a: 1)
  }
}

extension Date {
  func timeAgo() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))

    let minute = 60
    let hour = minute * 60
    let day = 24 * hour
    let week = 7 * day
    let month = 30 * day

    let quotient: Int
    let unit: String

    if secondsAgo < 5 {
      quotient = 0
      unit = "Just now"
    } else if secondsAgo < minute {
      quotient = secondsAgo
      if quotient > 1 {
        unit = "seconds"
      } else {
        unit = "second"
      }
    } else if secondsAgo < hour {
      quotient = secondsAgo / minute
      if quotient > 1 {
        unit = "minutes"
      } else {
        unit = "minute"
      }
    } else if secondsAgo < day {
      quotient = secondsAgo / hour
      if quotient > 1 {
        unit = "hours"
      } else {
        unit = "hour"
      }
    } else if secondsAgo < week {
      quotient = secondsAgo / day
      if quotient > 1 {
        unit = "days"
      } else {
        unit = "day"
      }
    } else if secondsAgo < month {
      quotient = secondsAgo / week
      if quotient > 1 {
        unit = "weeks"
      } else {
        unit = "week"
      }
    } else {
      quotient = 0
      let formatter = DateFormatter()
      formatter.dateFormat = "ddmmmmyyyy"
      unit = formatter.string(from: self)
    }

    let quotientStr = quotient > 0 ? "\(quotient) " : ""
    let postfix = quotientStr.isEmpty ? "" : " ago"
    let result = quotientStr + unit + postfix
    return result
  }
}

