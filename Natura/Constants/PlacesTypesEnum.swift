//
//  PlacesTypesEnum.swift
//  Natura
//
//  Created by Gerlandio on 7/28/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

enum PlacesTypesEnum: Int {
    
    case Accounting = 1,
    Airport,
    Amusement_park,
    Aquarium,
    Art_gallery,
    Atm,
    Bakery,
    Bank,
    Bar,
    Beauty_salon,
    Bicycle_store,
    Book_store,
    Bowling_alley,
    Bus_station,
    Cafe,
    Campground,
    Car_dealer,
    Car_rental,
    Car_repair,
    Car_wash,
    Casino,
    Cemetery,
    Church,
    City_hall,
    Clothing_store,
    Convenience_store,
    Courthouse,
    Dentist,
    Department_store,
    Doctor,
    Electrician,
    Electronics_store,
    Embassy,
    Establishment,
    Finance,
    Fire_station,
    Florist,
    Food,
    Funeral_home,
    Furniture_store,
    Gas_station,
    General_contractor,
    Grocery_or_supermarket,
    Gym,
    Hair_care,
    Hardware_store,
    Health,
    Hindu_temple,
    Home_goods_store,
    Hospital,
    Insurance_agency,
    Jewelry_store,
    Laundry,
    Lawyer,
    Library,
    Liquor_store,
    Local_government_office,
    Locksmith,
    Lodging,
    Meal_delivery,
    Meal_takeaway,
    Mosque,
    Movie_rental,
    Movie_theater,
    Moving_company,
    Museum,
    Night_club,
    Painter,
    Park,
    Parking,
    Pet_store,
    Pharmacy,
    Physiotherapist,
    Place_of_worship,
    Plumber,
    Police,
    Post_office,
    Real_estate_agency,
    Restaurant,
    Roofing_contractor,
    Rv_park,
    School,
    Shoe_store,
    Shopping_mall,
    Spa,
    Stadium,
    Storage,
    Store,
    Subway_station,
    Synagogue,
    Taxi_stand,
    Train_station,
    Travel_agency,
    University,
    Veterinary_care,
    ZOO
    
    func textDescription() -> String {
        switch self {
        case .Accounting:
            return "Contabilidade"
        case .Airport:
            return "Aeroporto"
        case .Amusement_park:
            return "Parque de Diversões"
        case .Aquarium:
            return "Aquário"
        case .Art_gallery:
            return "Galeria de Arte"
        case .Atm:
            return "Caixa Eletrônico"
        case .Bakery:
            return "Padaria"
        case .Bank:
            return "Banco"
        case .Bar:
            return "Barra"
        case .Beauty_salon:
            return "Salão de Beleza"
        case .Bicycle_store:
            return "Bicycle_store"
        case .Book_store:
            return "Livraria"
        case .Bowling_alley:
            return "Bowling_alley"
        case .Bus_station:
            return "Estação de Onibus"
        case .Cafe:
            return "Café"
        case .Campground:
            return "Área de Camping"
        case .Car_dealer:
            return "Vendedor de Carros"
        case .Car_rental:
            return "Aluguel de carros"
        case .Car_repair:
            return "Mecânica"
        case .Car_wash:
            return "Lava-Jato"
        case .Casino:
            return "Cassino"
        case .Cemetery:
            return "Cemitério"
        case .Church:
            return "Igreja"
        case .City_hall:
            return "Prefeitura"
        case .Clothing_store:
            return "Loja de Roupas"
        case .Convenience_store:
            return "Loja de Conveniência"
        case .Courthouse:
            return "Tribunal"
        case .Dentist:
            return "Dentista"
        case .Department_store:
            return "loja de Departamento"
        case .Doctor:
            return "Médico"
        case .Electrician:
            return "Eletricista"
        case .Electronics_store:
            return "Loja de Eletrônicos"
        case .Embassy:
            return "Embaixada"
        case .Establishment:
            return "Estabelecimento"
        case .Finance:
            return "Finança"
        case .Fire_station:
            return "Corpo de Bombeiros"
        case .Florist:
            return "Florista"
        case .Food:
            return "Comida"
        case .Funeral_home:
            return "Funeral"
        case .Furniture_store:
            return "Loja de Móveis"
        case .Gas_station:
            return "Posto de Gasolina"
        case .General_contractor:
            return "Empreiteiro Geral"
        case .Grocery_or_supermarket:
            return "Supermercado"
        case .Gym:
            return "Academia"
        case .Hair_care:
            return "Cuidado Capilar"
        case .Hardware_store:
            return "Loja de Hardware"
        case .Health:
            return "Saúde"
        case .Hindu_temple:
            return "Templo Hindu"
        case .Home_goods_store:
            return "Bens para casa"
        case .Hospital:
            return "Hospital"
        case .Insurance_agency:
            return "Agência de seguros"
        case .Jewelry_store:
            return "Joalheria"
        case .Laundry:
            return "Lavanderia"
        case .Lawyer:
            return "Advogado"
        case .Library:
            return "Biblioteca"
        case .Liquor_store:
            return "Loja de bebidas"
        case .Local_government_office:
            return "Escritório do governo local"
        case .Locksmith:
            return "Chaveiro"
        case .Lodging:
            return "Alojamento"
        case .Meal_delivery:
            return "Entrega de comida"
        case .Meal_takeaway:
            return "Drive-tru"
        case .Mosque:
            return "Mesquita"
        case .Movie_rental:
            return "Aluguel de filmes"
        case .Movie_theater:
            return "Cinema"
        case .Moving_company:
            return "Transportadora"
        case .Museum:
            return "Museu"
        case .Night_club:
            return "Boate"
        case .Painter:
            return "Pintor"
        case .Park:
            return "Parque"
        case .Parking:
            return "Estacionamento"
        case .Pet_store:
            return "Loja de Animais"
        case .Pharmacy:
            return "Farmacia"
        case .Physiotherapist:
            return "Fisioterapeuta"
        case .Place_of_worship:
            return "Local de Culto"
        case .Plumber:
            return "Encanador"
        case .Police:
            return "Polícia"
        case .Post_office:
            return "Agência dos Correios"
        case .Real_estate_agency:
            return "Agência Imobiliária"
        case .Restaurant:
            return "Restaurante"
        case .Roofing_contractor:
            return "Coberturas contratante"
        case .Rv_park:
            return "Estacionamento"
        case .School:
            return "Escola"
        case .Shoe_store:
            return "Loja de Sapatos"
        case .Shopping_mall:
            return "Centro de Compras"
        case .Spa:
            return "Estância Termal"
        case .Stadium:
            return "Estádio"
        case .Storage:
            return "Armazenamento"
        case .Store:
            return "Loja"
        case .Subway_station:
            return "Estação de metrô"
        case .Synagogue:
            return "Sinagoga"
        case .Taxi_stand:
            return "Ponto de Taxi"
        case .Train_station:
            return "Estação de Trem"
        case .Travel_agency:
            return "agência de Viagens"
        case .University:
            return "Universidade"
        case .Veterinary_care:
            return "Veterinário"
        case .ZOO:
            return "Jardim Zoológico"
        }
    }
    
    static func listOfObjects() -> [String] {
        let lastValue = PlacesTypesEnum.ZOO.rawValue
        var listOfPlacesString = [String]()
        for i in 1..<lastValue {
            let object = PlacesTypesEnum(rawValue: i)
            listOfPlacesString.append(object?.textDescription() ?? "")
        }
        
        return listOfPlacesString
    }
    
    func nameOption() -> String {
        return "\(self)".lowercaseString
    }
}
