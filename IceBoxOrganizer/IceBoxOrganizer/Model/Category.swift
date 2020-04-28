//
//  Category.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum Category: String {
  
  case condiment, grainAndNuts, meat, processedFoodAndDairy, seafood, vegetableAndFruit
  
  static let allCases = [condiment, grainAndNuts, meat, processedFoodAndDairy, seafood, vegetableAndFruit]
  
  static let allValues = [
    [
      Condiment.butter,
      Condiment.chiliPaste,
      Condiment.dressing,
      Condiment.ketchup,
      Condiment.miso,
      Condiment.mustard,
      Condiment.sesameOil,
      Condiment.soy,
      Condiment.tabasco,
    ],
    [
      GrainAndNuts.corn,
      GrainAndNuts.nut,
      GrainAndNuts.peanut,
      GrainAndNuts.potato,
      GrainAndNuts.rice,
      GrainAndNuts.sweetPotato,
    ],
    [
      Meat.beef,
      Meat.chicken,
      Meat.pork,
    ],
    [
      ProcessedFoodAndDairy.bacon,
      ProcessedFoodAndDairy.beer,
      ProcessedFoodAndDairy.bread,
      ProcessedFoodAndDairy.cheese,
      ProcessedFoodAndDairy.cookie,
      ProcessedFoodAndDairy.egg,
      ProcessedFoodAndDairy.fishCake,
      ProcessedFoodAndDairy.flour,
      ProcessedFoodAndDairy.ham,
      ProcessedFoodAndDairy.iceCream,
      ProcessedFoodAndDairy.laver,
      ProcessedFoodAndDairy.milk,
      ProcessedFoodAndDairy.pickledRadish,
      ProcessedFoodAndDairy.ramen,
      ProcessedFoodAndDairy.riceCake,
      ProcessedFoodAndDairy.sausage,
      ProcessedFoodAndDairy.soju,
      ProcessedFoodAndDairy.tofu,
      ProcessedFoodAndDairy.tuna,
    ],
    [
      Seafood.anchovy,
      Seafood.clam,
      Seafood.crab,
      Seafood.croaker,
      Seafood.kelp,
      Seafood.mackerel,
      Seafood.mussel,
      Seafood.oyster,
      Seafood.shrimp,
    ],
    [
      VegetableAndFruit.apple,
      VegetableAndFruit.beanSprouts,
      VegetableAndFruit.beans,
      VegetableAndFruit.broccoli,
      VegetableAndFruit.cabbage,
      VegetableAndFruit.carrot,
      VegetableAndFruit.chili,
      VegetableAndFruit.daikon,
      VegetableAndFruit.eggplant,
      VegetableAndFruit.garlic,
      VegetableAndFruit.kimchi,
      VegetableAndFruit.lemon,
      VegetableAndFruit.lettuce,
      VegetableAndFruit.mandarin,
      VegetableAndFruit.melon,
      VegetableAndFruit.onion,
      VegetableAndFruit.paprika,
      VegetableAndFruit.pear,
      VegetableAndFruit.persimmon,
      VegetableAndFruit.pumpkin,
      VegetableAndFruit.spinach,
      VegetableAndFruit.springOnion,
      VegetableAndFruit.strawberry,
      VegetableAndFruit.tangerine,
      VegetableAndFruit.tomato,
      VegetableAndFruit.watermelon,
      VegetableAndFruit.youngPumpkin
    ],
  ]
  
  enum Condiment: String {
    case butter, chiliPaste, dressing, ketchup, miso, mustard, sesameOil, soy, tabasco
    
    static let allValues = [butter, chiliPaste, dressing, ketchup, miso, mustard, sesameOil, soy, tabasco]
  }
  
  enum GrainAndNuts: String {
    case corn, nut, peanut, potato, rice, sweetPotato
    
    static let allValues = [corn, nut, peanut, potato, rice, sweetPotato]
  }
  
  enum Meat: String {
    case beef, chicken, pork
    
    static let allValues = [beef, chicken, pork]
  }
  
  enum ProcessedFoodAndDairy: String {
    case bacon, beer, bread, cheese, cookie, egg, fishCake, flour, ham, iceCream, laver, milk, pickledRadish, ramen, riceCake, sausage, soju, tofu, tuna
    
    static let allValues = [bacon, beer, bread, cheese, cookie, egg, fishCake, flour, ham, iceCream, laver, milk, pickledRadish, ramen, riceCake, sausage, soju, tofu, tuna]
  }
  
  enum Seafood: String {
    case anchovy, clam, crab, croaker, kelp, mackerel, mussel, oyster, shrimp
    
    static let allValues = [anchovy, clam, crab, croaker, kelp, mackerel, mussel, oyster, shrimp]
  }
  
  enum VegetableAndFruit: String {
    case apple, beanSprouts, beans, broccoli, cabbage, carrot, chili, daikon, eggplant, garlic, kimchi, lemon, lettuce, mandarin, melon, onion, paprika, pear, persimmon, pumpkin, spinach, springOnion, strawberry, tangerine, tomato, watermelon, youngPumpkin
    
    static let allValues = [apple, beanSprouts, beans, broccoli, cabbage, carrot, chili, daikon, eggplant, garlic, kimchi, lemon, lettuce, mandarin, melon, onion, paprika, pear, persimmon, pumpkin, spinach, springOnion, strawberry, tangerine, tomato, watermelon, youngPumpkin]
  }
}
