//
//  OnBoardingView.swift
//  MyNotes(5th-month)
//
//  Created by user on 5/3/24.
//

import UIKit

var currentPage = 0

class OnBoardingView: UIViewController  {
    
    var StructBoarding: [StructBoardings] = []
    
    private lazy var onBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.reuseID)
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var uIPageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.red, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttons()
        setupParamets()
        onBoardingCollectionView.reloadData()
        DispatchQueue.main.async {
            self.scrollToCurrentPage(animated: false)
        }
    }
    
    func test() {
        guard StructBoarding.count > currentPage + 0 else { return }
        
        onBoardingCollectionView.isPagingEnabled = false
        onBoardingCollectionView.scrollToItem(at: IndexPath(item: currentPage + 0, section: 0), at: .centeredHorizontally, animated: true)
        onBoardingCollectionView.isPagingEnabled = true
    }
    
    
    private func setupUI() {
        view.addSubview(onBoardingCollectionView)
        view.addSubview(uIPageControl)
        NSLayoutConstraint.activate([
            onBoardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onBoardingCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            onBoardingCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            onBoardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uIPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            uIPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupParamets() {
        StructBoarding = [
        StructBoardings(image: "firstImage", mainLabel: "Welcome to The Note", label: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!."),
        StructBoardings(image: "secondImage", mainLabel: "Set Up Your Profile", label: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
        StructBoardings(image: "thirdImage", mainLabel: "Dive into The Note", label: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")
        ]
        onBoardingCollectionView.reloadData()
    }
    
    
    private func buttons() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            skipButton.heightAnchor.constraint(equalToConstant: 42),
            skipButton.widthAnchor.constraint(equalToConstant: 173),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 42),
            nextButton.widthAnchor.constraint(equalToConstant: 173)
        ])
    }
    
    @objc private func nextButtonTapped() {
        UserDefaults.standard.set(true, forKey: "one_board_cell")
        if currentPage < StructBoarding.count - 1 {
            currentPage += 1
            scrollToCurrentPage(animated: true)
        } else {
            transitionToHomeView()
        }
    }
    
    private func scrollToCurrentPage(animated: Bool) {
        let indexPath = IndexPath(item: currentPage, section: 0)
        onBoardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        uIPageControl.currentPage = currentPage
    }
    
    private func transitionToHomeView() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func skipButtonTapped() {
            let vc = HomeView()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

    extension OnBoardingView: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return StructBoarding.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.reuseID, for: indexPath) as! OnBoardCell
            cell.configure(with: StructBoarding[indexPath.row])
            return cell
        }
    }

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSet = scrollView.contentOffset.x
        
        let page = (contentOffSet / view.frame.width)
        
        switch page {
        case 0.0:
            uIPageControl.currentPage = 0
            currentPage = 0
        case 1.0:
            uIPageControl.currentPage = 1
            currentPage = 1
        case 2.0:
            uIPageControl.currentPage = 2
            currentPage = 2
        default:
            ()
        }
    }
}
