//
//  SettingsVC.swift
//  MyNotes(5th-month)
//
//  Created by user on 24/2/24.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var bookBtn: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.setImage(UIImage(systemName: "character.book.closed.fill"), for: .normal)
        return view
    }()
    
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.text = "Язык"
        view.tintColor = .black
        view.font = .systemFont(ofSize: 18, weight: .light)
        return view
    }()
    
    private lazy var russianLabel: UILabel = {
        let view = UILabel()
        view.text = "Русский"
        view.tintColor = .black
        view.font = .systemFont(ofSize: 14, weight: .thin)
        return view
    }()
    
    private lazy var rightArrow: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return view
    }()
    
    private lazy var sliderUI: UISlider = {
        let view = UISlider()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private lazy var underlineView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var moonMoodBtn: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.setImage(UIImage(systemName: "moon"), for: .normal)
        return view
    }()
    
    private lazy var darkMoodLabel: UILabel = {
        let view = UILabel()
        view.text = "Темная тема"
        view.tintColor = .black
        view.font = .systemFont(ofSize: 18, weight: .light)
        return view
    }()
    
    private lazy var underlineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var trashBtn: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.setImage(UIImage(systemName: "trash"), for: .normal)
        return view
    }()
    
    private lazy var trashlabel: UILabel = {
        let view = UILabel()
        view.text = "Очистить данные"
        view.tintColor = .black
        view.font = .systemFont(ofSize: 18, weight: .light)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupUI()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainView)
        view.addSubview(bookBtn)
        view.addSubview(moonMoodBtn)
        view.addSubview(trashBtn)
        view.addSubview(underlineView1)
        view.addSubview(underlineView2)
        view.addSubview(languageLabel)
        view.addSubview(darkMoodLabel)
        view.addSubview(trashlabel)
        view.addSubview(russianLabel)
        view.addSubview(rightArrow)
        view.addSubview(sliderUI)
        
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(151)
            make.width.equalTo(370)
        }

        bookBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(26)
            make.leading.equalTo(bookBtn.snp.leading).offset(36)
        }
        
        russianLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(29.5)
            make.trailing.equalTo(view.snp.trailing).offset(-48)
        }
        
        rightArrow.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }
        
        underlineView1.snp.makeConstraints { make in
            make.top.equalTo(bookBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(22)
            make.height.equalTo(1)
        }
        
        moonMoodBtn.snp.makeConstraints { make in
            make.top.equalTo(bookBtn.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        darkMoodLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView1.snp.bottom).offset(14)
            make.leading.equalTo(moonMoodBtn.snp.leading).offset(36)
        }
        
        sliderUI.snp.makeConstraints { make in
            make.top.equalTo(underlineView1.snp.bottom).offset(12)
            make.trailing.equalTo(view.snp.trailing).offset(-33)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
        
        underlineView2.snp.makeConstraints { make in
            make.top.equalTo(moonMoodBtn.snp.bottom).offset(11)
            make.horizontalEdges.equalToSuperview().inset(22)
            make.height.equalTo(1)
        }
        
        trashBtn.snp.makeConstraints { make in
            make.top.equalTo(moonMoodBtn.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        trashlabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView2.snp.bottom).offset(14)
            make.leading.equalTo(trashBtn.snp.leading).offset(36)
        }
    }
    
}
