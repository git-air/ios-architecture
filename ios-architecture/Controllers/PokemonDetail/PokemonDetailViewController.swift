//
//  PokemonDetailViewController.swift
//  ios-architecture
//
//  Created by AIR on 2023/05/09.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var model: PokemonDetailModel! {
        didSet {
            registerModel()
        }
    }
    
    deinit {
        model.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
        _ = model.notificationCenter.addObserver(forName: .init("pokemonDetail"), object: nil, queue: nil) { [weak self] notification in
            if let pokemonDetail = notification.userInfo?["pokemonDetail"] as? PokemonDetail {
                DispatchQueue.main.sync {
                    self?.updateView(pokemonDetail: pokemonDetail)
                }
            }
        }
    }
    
    private func updateView(pokemonDetail: PokemonDetail) {
        myView.numberLabel.text = String(pokemonDetail.number)
        myView.nameLabel.text = pokemonDetail.name
        myView.heightLabel.text = String(pokemonDetail.height)
        myView.weightLabel.text = String(pokemonDetail.weight)
        myView.setImage(pokemonDetail.imageUrl)
    }
    
    private func requestPokemonDetail() {
        model.requestPokemonDetail { result in
            switch result {
            case .success:
                break
            case .failure:
                print("failure")
            }
        }
    }
    
    private lazy var myView = PokemonDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPokemonDetail()
        addBottomLineToView()
    }
    
    override func loadView() {
        view = myView
    }
    
    private func addBottomLineToView() {
        let borderWidth = 0.5
        let borderColor = UIColor.black
        myView.numberView.addBorder(width: borderWidth, color: borderColor)
        myView.nameView.addBorder(width: borderWidth, color: borderColor)
        myView.heightView.addBorder(width: borderWidth, color: borderColor)
        myView.weightView.addBorder(width: borderWidth, color: borderColor)
    }
}
