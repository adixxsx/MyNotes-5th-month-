//
//  MakerView.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

import UIKit

class MakerView {
    
    static let shared = MakerView()
    
    func createLabel(
        text: String = "",
        textColor: UIColor = .black,
        fontSize: CGFloat = 12,
        fontWeight: UIFont.Weight = .regular,
        numberOfLines: Int = 1,
        textAlignment: NSTextAlignment = .left,
        opacity: Float = 1
    ) -> UILabel {
        let view = UILabel()
        view.text = text
        view.textColor = textColor
        view.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        view.numberOfLines = numberOfLines
        view.textAlignment = textAlignment
        view.layer.opacity = opacity
        return view
    }
    
func createImage(
        image: UIImage? = nil,
        tintColor: UIColor = .black,
        cornerRadius: CGFloat = 0,
        masksToBounds: Bool = true
    ) -> UIImageView {
        let view = UIImageView()
        view.image = image
        view.tintColor = tintColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = masksToBounds
        return view
    }
    
    func createButton(
        text: String = "",
        textColor: UIColor = .black,
        fontSize: CGFloat = 12,
        fontWeight: UIFont.Weight = .regular,
        tintColor: UIColor = .black,
        setImage: UIImage? = nil,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = .clear,
        isEnabled: Bool = true
    ) -> UIButton {
        let view = UIButton()
        view.setTitle(text, for: .normal)
        view.setTitleColor(textColor, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        view.tintColor = tintColor
        view.setImage(setImage, for: .normal)
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = backgroundColor
        view.isEnabled = isEnabled
        return view
    }
    
    func createView(
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0,
        borderWidth: CGFloat = 0,
        borderColor: UIColor = .clear
    ) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
        return view
    }
    
    func createTF(
        textColor: UIColor = .black,
        placeholder: String = "",
        backgroundColor: UIColor = .clear,
        ofSize: CGFloat = 14,
        weight: UIFont.Weight = .regular,
        cornerRadius: CGFloat = 0,
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0,
        leftView: Bool = false,
        rightView: Bool = false
    ) -> UITextField {
        let view = UITextField()
        view.textColor = textColor
        view.placeholder = placeholder
        view.backgroundColor = backgroundColor
        view.font = .systemFont(ofSize: ofSize, weight: weight)
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        if leftView == true {
            let leftUIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            view.leftView = leftUIView
            view.leftViewMode = .always
        }
        if rightView == true {
            let rightUIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            view.rightView = rightUIView
            view.rightViewMode = .always
        }
        return view
    }
}
