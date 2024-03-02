//
//  ViewController.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

import UIKit
import SnapKit

protocol HomeViewProtocol {
    func successNotes(notes: [String])
}

class HomeView: UIViewController, UICollectionViewDelegate {
    
    private var controller: HomeControllerProtocol?

    private var notes: [String] = ["Do homework", "Buy gigabyte", "Meet friends", "Go to the gym!"]
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        view.delegate = self
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        view.backgroundColor = .red
        view.layer.cornerRadius = 22
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
            navigationItem.title = "Home"
            let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(itemButtonTapped))
            self.navigationController?.navigationBar.tintColor = UIColor.black
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
        
        @objc func itemButtonTapped() {
            let vc = SettingView()
            navigationController?.pushViewController(vc, animated: true)
        }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(noteSearchBar)
        view.addSubview(titleLabel)
        view.addSubview(notesCollectionView)
        view.addSubview(addButton)
        
        
        noteSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
       titleLabel.snp.makeConstraints { make in
           make.top.equalTo(noteSearchBar.snp.bottom).offset(22)
           make.horizontalEdges.equalToSuperview().inset(39)
        }

        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }

       addButton.snp.makeConstraints { make in
           make.bottom.equalToSuperview().offset(-133)
           make.centerX.equalToSuperview()
           make.height.equalTo(48)
           make.width.equalTo(48)
       }
    }
    


}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as? NoteCell
        cell?.transfer(title: notes[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 100)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [String]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
}

