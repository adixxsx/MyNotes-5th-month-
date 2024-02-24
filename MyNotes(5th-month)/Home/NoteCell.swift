//
//  NoteCell.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

import UIKit
import SnapKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
    
    let colors: [UIColor] = [.purple, .cyan, .orange, .systemPink]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    func  transfer(title: String) {
        titleLabel.text = title
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
