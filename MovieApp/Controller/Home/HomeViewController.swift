//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit
import SwiftUI

class HomeViewController: BaseController {
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var newDataBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Yeni Filmler Geldi", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 4
        
        //        btn.addTarget(self, action: #selector(didTapNewDataBtn), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.alpha = 0
        btn.transform = CGAffineTransform(translationX: 0, y: -50)
        return btn
    }()
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setUpNewDataBtn()
        //        viewModel.viewDidLoad()
        //        DataPersistenceManager.shared.removeDuplicateMovies()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .appMainBackground
        
        guard let image = UIImage(named: "LogoTest") else {
            print("error: navigation image named logotest could not find")
            return
        }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        navigationItem.titleView = imageView
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    override func configureUI() {
        
        view.backgroundColor = .appMainBackground
    }
    
    override func configureViewModel() {
        viewModel.getMovies()
        viewModel.success = {
            self.collection.reloadData()
            print("self.viewModel.items.count: \(self.viewModel.items.count)")
        }
    }
    
    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view .leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.startMonitoring{ isConnected in
            if isConnected {
                print("🟢 İnternet Bağlantısı Sağlandı!")
            } else {
                print("🔴 İnternet Bağlantısı Koptu!")
            }
        }
    }
    
    private func navigateToDetail(movie: NewMovieResult) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailController = storyboard.instantiateViewController(withIdentifier: "DetailController") as? DetailController {
            detailController.movie = movie
            navigationController?.show(detailController, sender: nil)
        }
    }
    
    
    
    
    // MARK: - Setup & Configuration
    //    private func bindViewModel() {
    //
    //        viewModel.onDataUpdated = { [weak self] in
    //            DispatchQueue.main.async {
    //                self?.collection.reloadData()
    //                self?.hideToast()
    //            }
    //        }
    //
    //        viewModel.onShowUpdateToast = { [weak self] in
    //            DispatchQueue.main.async {
    //                self?.showToast()
    //            }
    //        }
    //
    //        viewModel.onError = { [weak self] errorMessage in
    //            DispatchQueue.main.async {
    //                print("Hata: \(errorMessage)")
    //            }
    //        }
    //    }
    //
    //
    //
    //    private func setupLogoutButton() {
    //        let logoutBtn = UIBarButtonItem(
    //            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
    //            style: .prominent,
    //            target: self,
    //            action: #selector(logoutTapped)
    //        )
    //        logoutBtn.tintColor = .orangeLetterboxd
    //        navigationItem.rightBarButtonItem = logoutBtn
    //    }
    //    // MARK: - Actions
    //    @objc func logoutTapped() {
    //        let alert = UIAlertController(title: "Exit", message: "Are you sure to exit", preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    //        alert.addAction(UIAlertAction(title: "Exit", style: .destructive) { _ in
    //            UserDefaults.standard.set(false, forKey: "isLoggedIn")
    //            self.navigateToLogin()
    //        })
    //        present(alert, animated: true)
    //    }
    //
    //    @objc private func didTapNewDataBtn() {
    //        let generator = UIImpactFeedbackGenerator(style: .medium)
    //        generator.impactOccurred()
    //        viewModel.userPressedRefreshBtn()
    //        collection.setContentOffset(.zero, animated: true)
    //    }
    //
    //
    //
    //    // MARK: - Helpers & Animations
    //    private func showToast() {
    //        guard newDataBtn.alpha == 0  else { return }
    //
    //        UIView.animate(withDuration: 0.5,
    //                       delay: 0,
    //                       usingSpringWithDamping: 0.6,
    //                       initialSpringVelocity: 0.8,
    //                       options: .curveEaseInOut) {
    //            self.newDataBtn.alpha = 1
    //            self.newDataBtn.transform = .identity
    //        }
    //    }
    //
    //    private func hideToast() {
    //        UIView.animate(withDuration: 0.3) {
    //            self.newDataBtn.alpha = 0
    //            self.newDataBtn.transform = CGAffineTransform(translationX: 0, y: -50)
    //        }
    //    }
    //
    //    private func navigateToLogin() {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let loginController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    //
    //        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
    //           let window = sceneDelegate.window {
    //
    //            window.rootViewController = loginController
    //
    //        }
    //    }
    //
    //// MARK: - CollectionView Layout Logic (Compositional Layout)
    //    private func createLayout() -> UICollectionViewLayout {
    //        return UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
    //
    //            switch sectionIndex {
    //            case 0:
    //                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
    //                let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    //
    //                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250))
    //                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //
    //                let section = NSCollectionLayoutSection(group: group)
    //                section.orthogonalScrollingBehavior = .groupPaging
    //                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
    //                return section
    //
    //            case 1:
    //                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
    //                let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //
    //                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
    //                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //
    //                let section = NSCollectionLayoutSection(group: group)
    //                section.orthogonalScrollingBehavior = .continuous
    //                section.interGroupSpacing = 15
    //                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
    //                return section
    //
    //            default:
    //                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(170))
    //                let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    //
    //                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
    //                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
    //                let section = NSCollectionLayoutSection(group: group)
    //                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
    //                return section
    //            }
    //        }
    //    }
    //
    //}
    //
}

extension HomeViewController: CollectionConfiguration {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.configure(data: viewModel.self.items[indexPath.item])
        cell.onMovieSelected = {[weak self] movie in
            self?.navigateToDetail(movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 312)
    }
    
}


//#Preview {
//    // Storyboard'dan yüklemezsen ekran simsiyah çıkar, o yüzden ID ile çekiyoruz
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//}

