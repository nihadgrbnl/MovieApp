//
//  ActorTest.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import UIKit



class ActorTest: BaseController {
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(TopImageBottomLabelCell.self, forCellWithReuseIdentifier: TopImageBottomLabelCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let viewModel = ActorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appMainBackground

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
    
    override func configureViewModel() {
        viewModel.getActorDatas()
        viewModel.success = {
            self.collection.reloadData()
        }
        viewModel.error = { message in
            print(message)
        }
    }
}

extension ActorTest: CollectionConfiguration {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopImageBottomLabelCell.identifier, for: indexPath) as! TopImageBottomLabelCell
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 168)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedMovie = viewModel.items[indexPath.item]
//        onMovieSelected?(selectedMovie)
//    }
}
