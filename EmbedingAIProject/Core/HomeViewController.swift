//
//  HomeViewController.swift
//  EmbedingAIProject
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    // high volume words
    private let highVolumeTexts =
        "The movie was a thrilling roller coaster ride from start to finish. The plot twists kept me on the edge of my seat and the acting was top-notch. I highly recommend it to anyone who loves suspenseful films."
    
    private var embedResponseArray: [String] = []
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getResponse(input: highVolumeTexts) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.embedResponseArray.append(contentsOf: success)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("failed response \(error.localizedDescription)")
            }
        }
    }
}
// MARK: - UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        embedResponseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let modelArray = embedResponseArray[indexPath.row]
        cell.textLabel?.text = modelArray
        return cell
    }
}
// MARK: - UITableViewDelegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(70)
    }
}
