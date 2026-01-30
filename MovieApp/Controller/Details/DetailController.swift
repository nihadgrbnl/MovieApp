//
//  DetailController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 12.01.26.
//

import UIKit
import SDWebImage
import YouTubePlayerKit

class DetailController: UIViewController {
    
    var movie : Movie?
    private var videos = [VideoResult]()
    
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
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    //    @IBOutlet weak var directorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
//      setUpBookmarkButton()
        
        setUpSegmentedControl()
        setUpTrailerTableView()
        fetchTrailer()
        
    }
    
    //    private func testTrailers() {
    //            guard let movieID = movie?.id else {
    //                print("❌ Hata: Film ID'si bulunamadı!")
    //                return
    //            }
    //
    //            print("🚀 İstek atılıyor: Movie ID \(movieID) için trailerlar aranıyor...")
    //
    //        NetworkManager.shared.getMovieTrailer(movieID: movieID) { [weak self] result in
    //                switch result {
    //                case .success(let videos):
    //                    print("\n✅ BAŞARILI! Toplam \(videos.count) adet video geldi.\n")
    //                    print("--------------------------------------------------")
    //
    //                    for (index, video) in videos.enumerated() {
    //                        print("🎥 Video #\(index + 1)")
    //                        print("   📛 İsim: \(video.name ?? "Bilinmiyor")")
    //                        print("   🏷 Tür : \(video.type ?? "Bilinmiyor")") // Trailer, Teaser vs.
    //                        print("   🔑 Key : \(video.key ?? "Bilinmiyor")")  // YouTube ID
    //                        print("   🔗 Site: \(video.site ?? "Bilinmiyor")")
    //                        print("--------------------------------------------------")
    //                    }
    //
    //                    // Eğer burası çalışıyorsa UI yapmaya hazırız demektir.
    //
    //                case .failure(let error):
    //                    print("\n❌ HATA OLUŞTU:")
    //                    print("   ⚠️ \(error.localizedDescription)")
    //                }
    //            }
    //        }
    
    private func configureUI() {
        guard let movie = movie else { return }
        
        posterImage.contentMode = .scaleAspectFill
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        //        if let director = movie.director {
        //            directorLabel.text = "Directed by: \(director)"
        //        }
        
        
        if let date = movie.releaseDate {
            releaseDateLabel.text = "\(date)"
        }
        
        //        if let runtime = movie.runtime {
        //            runtimeLabel.text = "\(runtime) minute"
        //        }
        //
        
        
        if let path = movie.backdropPath {
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            backdropImage.sd_setImage(with: fullURL)
        }
        
        
        if let path = movie.posterPath {
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            posterImage.sd_setImage(with: fullURL)
        }
        
        posterImage.layer.cornerRadius = 12
        posterImage.clipsToBounds = true
        backdropImage.contentMode = .scaleAspectFill
    }
    
    private func setUpSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 30),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setUpTrailerTableView() {
        view.addSubview(trailersTableView)
        NSLayoutConstraint.activate([
            trailersTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            trailersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trailersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //    private func setUpBookmarkButton() {
    //        updateBookmarkIcon()
    //    }
    
    //    private func updateBookmarkIcon() {
    //        guard let movie = movie else { return }
    //        let isSaved = CoreDataManager.shared.isMovieSaved(movieID: movie.id ?? "")
    //        let iconName = isSaved ? "bookmark.fill" : "bookmark"
    //        let bookmarkButton = UIBarButtonItem(
    //            image: UIImage(systemName: "iconName"),
    //            style: .plain,
    //            target: self,
    //            action: #selector(bookmarkTapped)
    //        )
    //        navigationItem.rightBarButtonItem = bookmarkButton
    //    }
    
    //    @objc func bookmarkTapped () {
    //        guard let movie = movie else { return }
    //        if CoreDataManager.shared.isMovieSaved(movieID: movie.id ?? "") {
    //            CoreDataManager.shared.deleteMovie(movieID: movie.id ?? "")
    //        } else {
    //            CoreDataManager.shared.saveMovie(movie: movie)
    //        }
    //        updateBookmarkIcon()
    //    }
    
    
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
        guard let id = movie?.id else { return }
        
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

extension DetailController: UITableViewDelegate, UITableViewDataSource {
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
