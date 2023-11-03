//
//  PokemonTableViewController.swift
//  Digimon(Pokemon)
//
//  Created by Tony Lieu on 11/2/23.
//

import UIKit
class PokemonTableViewController: UIViewController {
    var pokeList: [PokemonModel] = []
    @IBOutlet weak var tables: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tables.dataSource = self
        tables.delegate = self
        let cellXib = UINib(nibName: "TableViewCell", bundle: nil)
        tables.register(cellXib, forCellReuseIdentifier: "PokemonTable")
        CallAPI()
        // Do any additional setup after loading the view.
    }
    func CallAPI(){
        let nM = NetworkManager()
        guard let url = URL(string:"https://digimon-api.vercel.app/api/digimon") else{return}
        nM.getDataFromAPI(url: url, modelType: [PokemonModel].self ) { results in
            switch results{
            case .success(let PokemonData):
                self.pokeList.append(contentsOf: PokemonData)
                DispatchQueue.main.async {
                    self.tables.reloadData()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PokemonTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTable", for: indexPath) as! TableViewCell
        let number = pokeList[indexPath.row]
        cell.pokemonName.text = number.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
extension PokemonTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let poke = storyboard.instantiateViewController(identifier: "PokemonViewController") as! PokemonViewController
        let number = pokeList[indexPath.row].name
        let number2 = pokeList[indexPath.row].level
        let number3 = pokeList[indexPath.row].img
        //poke.pokemonNameLabel.text = number.name
        poke.name = number
        poke.lvl = number2
        poke.pokeImg = number3
//        poke.pokemonImage(img: number.img)

        self.navigationController?.pushViewController(poke, animated:true)
    }
}
extension UIImageView{
    func toImage(urlString:String) {
            guard let url = URL(string: urlString) else {
                        return
                    }
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.image = image
                                }
                            }
                        }
                    }
                }
           }

