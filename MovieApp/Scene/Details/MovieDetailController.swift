//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import UIKit
import YouTubePlayerKit

class MovieDetailController: BaseController {
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backdropImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var posterImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDate : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taglineLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Overview", "Trailers"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .appMainBackground
        sc.selectedSegmentTintColor = .orangeLetterboxd
        
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        sc.setTitleTextAttributes([.foregroundColor: UIColor(resource: .placeHolder)], for: .normal)
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private lazy var overviewLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trailersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isHidden = true
        table.register(TrailerCell.self, forCellReuseIdentifier: "TrailerCell")
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    

    
    
    
    private var viewModel : MovieDetailViewModel
    
    private var videos = [VideoResult]()
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTransparentNavigationBar()
    }
    
    override func configureUI() {
        view.backgroundColor = .appMainBackground
    }
    
    override func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImageView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDate)
        contentView.addSubview(taglineLabel)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(trailersTableView)
        contentView.addSubview(overviewLabel)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            backdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 300),
            
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 110),
            posterImageView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -16),
            
            releaseDate.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDate.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -16),
            
            taglineLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 24),
            taglineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taglineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            segmentedControl.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 30),
            segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            
            trailersTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            trailersTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailersTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trailersTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            trailersTableView.heightAnchor.constraint(equalToConstant: 400),
            
            overviewLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            
            
            
        ])
    }
    
    override func configureViewModel() {
        viewModel.getMovieDetail()
        
        viewModel.success = {
            DispatchQueue.main.async {
                guard let detail = self.viewModel.detailItems else { return }
                self.configureData(detail: detail)
            }
        }
        
        viewModel.error = { errorMessage in
            print(errorMessage)
        }
    }
    
    private func configureData(detail: MovieDetail) {
        if let backdropPath = detail.backdropPath {
            backdropImageView.loadURL(data: backdropPath)
        }
        
        if let posterPath = detail.posterPath {
            posterImageView.loadURL(data: posterPath)
        }
        
        titleLabel.text = detail.title
        releaseDate.text = detail.releaseDate
        taglineLabel.text = detail.tagline
        overviewLabel.text = detail.overview
        
        fetchTrailer()
        
    }
    
    private func setupTransparentNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let isOverViewSelected = sender.selectedSegmentIndex == 0
        
        
        UIView.animate(withDuration: 0.3) {
            self.trailersTableView.isHidden = isOverViewSelected
            self.trailersTableView.alpha = isOverViewSelected ? 0 : 1
            
            self.overviewLabel.isHidden = !isOverViewSelected
            self.overviewLabel.alpha = isOverViewSelected ? 1 : 0
        }
    }
    
    private func fetchTrailer() {
        guard let id = viewModel.detailItems?.id else { return }
        
        NetworkManager.shared.getMovieTrailer(movieID: id) { [weak self] result in
            switch result {
            case .success(let videos):
                self?.videos = videos
                DispatchQueue.main.async {
                    self?.trailersTableView.reloadData()
                }
            case .failure(let error):
                print("Trailer Error: \(error.localizedDescription)")
            }
        }
    }
}

extension MovieDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! TrailerCell
        let video = videos[indexPath.row]
        cell.configure(video: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let video = videos[indexPath.row]
        guard let videoKey = video.key else { return }
      
        
        let player = YouTubePlayer(
            source: .video(id: videoKey),
        )
        
        let playerViewController = YouTubePlayerViewController(player: player)
        self.present(playerViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
