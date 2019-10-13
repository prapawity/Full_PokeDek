//
//  ViewController.swift
//  Pokedek
//
//  Created by Prapawit Patthasirivichot on 13/10/2562 BE.
//  Copyright © 2562 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
enum Section: Int,CaseIterable{
    case pokemonList,loadMore
    
    
}

class ViewController: UIViewController {
    
    var arrayData: [PokemonModel] = []
    var isLoadmore = false
    let controlApi = PokeAPIManager()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collection")
    }
    override func viewDidAppear(_ animated: Bool) {
        for i in 0...101 {
            controlApi.getPokemonDate(id: i) { (PokemonModel) in
                self.arrayData.append(PokemonModel)
                let indexPath = IndexPath(row: self.arrayData.count - 1, section: 0)
                self.collectionView.insertItems(at: [indexPath])
            }
            
        }
        isLoadmore = true
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .pokemonList:
            return arrayData.count
        case .loadMore:
            return isLoadmore ? 1 : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .pokemonList:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as? CollectionViewCell{
                cell.setImg(url: arrayData[indexPath.row].sprites!.front_default!, name: arrayData[indexPath.row].name!)
                return cell
            }
        case .loadMore:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as? UICollectionViewCell{
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cgWidth = (self.view.frame.width - 4 * 8)/2
        return CGSize(width: cgWidth, height: cgWidth+10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == Section.loadMore.rawValue {
            updateData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: arrayData[indexPath.row])
    }
    
    private func updateData() {
//        isLoadmore = false
        for j in 0...30{
            controlApi.getPokemonDate(id: Int.random(in: 101...130)) { (PokemonModel) in
                self.arrayData.append(PokemonModel)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.reloadData()
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let destination = segue.destination as? ShowDetailViewController{
                let data = (sender as? PokemonModel)!
                destination.data = data
            }
        }
    }
}
