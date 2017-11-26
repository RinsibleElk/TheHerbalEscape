//
//  WitcherContentPack.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Dummy data based on the Witcher game series.
class WitcherContentPack: ContentPack {
    var Name: String {
        get {
            return "Witcher"
        }
    }
    
    var Learnables: [Learnable] = []
    
    init() {
        // Balisse
        let balissePage1Elements : [BrowserPageElement] =
            [
                BrowserPageElement.heading(BrowserPageHeading(text: "Balisse", level: 1)),
                BrowserPageElement.etymology(BrowserPageEtymology(phrase1: BrowserPageEtymologyPhrase(word: "Maximus Vulputate", etymology: "largest seeds (from old Skelligan)"), phrase2: nil)),
                BrowserPageElement.text(BrowserPageText(text: "**Balisse fruit** is an edible berry characterized by subtle magic resonance. The fruit is apparently poisonous unless soaked in alcohol first, after which it can be used for medicines.", links: [])),
                BrowserPageElement.image(BrowserPageImage(imageName: "balisse", imageDescription: "A picture of the Balisse fruit"))
            ]
        let balissePages =
            [
                BrowserPage(elements: balissePage1Elements)
            ]
        let balisseFlower = Flower(commonName: "Balisse", latinName: "Maximus Vulputate", image: "balisse", level: 1.0, pages: balissePages)
        Learnables.append(balisseFlower)
        
        // Celandine
        let celandinePage1Elements : [BrowserPageElement] =
            [
                BrowserPageElement.heading(BrowserPageHeading(text: "Celandine", level: 1)),
                BrowserPageElement.etymology(BrowserPageEtymology(phrase1: BrowserPageEtymologyPhrase(word: "Quaerat", etymology: "This is some fake latin"), phrase2: BrowserPageEtymologyPhrase(word: "Voluptatem", etymology: "I only just noticed that I ended up with a similar word here"))),
                BrowserPageElement.text(BrowserPageText(text: "**Celandine** is a yellow flower. You can use it to prepare potions, oils, bombs and decoctions.", links: [])),
                BrowserPageElement.image(BrowserPageImage(imageName: "celandine", imageDescription: "A picture of the Celandine flower")),
                BrowserPageElement.text(BrowserPageText(text: "Celandine can be a bit hard to find in the wild – there’s only a couple of places in White Orchard where you can pick this plant. One batch of flowers can be found south of the inn, close to the river. Another good place to look for them is at the hut south-west of the inn. There are a lot of different species of plants around the house, and Celandine is one of them.", links: []))
        ]
        let celandinePages =
            [
                BrowserPage(elements: celandinePage1Elements)
        ]
        let celandineFlower = Flower(commonName: "Celandine", latinName: "Quaerat Voluptatem", image: "celandine", level: 1.0, pages: celandinePages)
        Learnables.append(celandineFlower)
        
        // Arenaria
        let arenariaPage1Elements : [BrowserPageElement] =
            [
                BrowserPageElement.heading(BrowserPageHeading(text: "Arenaria", level: 1)),
                BrowserPageElement.text(BrowserPageText(text: "**Arenaria** is a relatively rare plant outside of White Orchard but can also be found in Skellige. You can use it to prepare potions, oils, bombs and decoctions.", links: [])),
                BrowserPageElement.image(BrowserPageImage(imageName: "arenaria", imageDescription: "A picture of the Arenaria flower")),
                BrowserPageElement.text(BrowserPageText(text: "Here is a link to Celandine.", links: [BrowserPageTextLink(range: NSRange(location: 18, length: 9), target: "Celandine")])),
                ]
        let arenariaPages =
            [
                BrowserPage(elements: arenariaPage1Elements)
        ]
        let arenariaFlower = Flower(commonName: "Arenaria", latinName: "Luctus Massa", image: "arenaria", level: 1.0, pages: arenariaPages)
        Learnables.append(arenariaFlower)
        
        // Buckthorn
        let buckthornPage1Elements : [BrowserPageElement] =
            [
                BrowserPageElement.heading(BrowserPageHeading(text: "Buckthorn", level: 1)),
                BrowserPageElement.etymology(BrowserPageEtymology(phrase1: BrowserPageEtymologyPhrase(word: "Vivamus", etymology: "lively"), phrase2: BrowserPageEtymologyPhrase(word: "Faucibus", etymology: "stench"))),
                BrowserPageElement.text(BrowserPageText(text: "Buckthorn is an alchemy ingredient that is found in water, usually on ocean floors and lakebeds. It is used as a lure for Griffins, due to its rotting flesh smell.", links: [])),
                BrowserPageElement.image(BrowserPageImage(imageName: "buckthorn", imageDescription: "A picture of the Buckthorn weed")),
                ]
        let buckthornPage2Elements : [BrowserPageElement] =
            [
                BrowserPageElement.text(BrowserPageText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque porta vulputate pretium. Quisque consequat ornare elit eget porttitor. Proin fringilla quam eu arcu interdum, at egestas lectus sagittis. Curabitur feugiat, enim eget egestas semper, lorem sapien efficitur nunc, quis ullamcorper purus odio ut odio. Integer non lectus nec dui molestie scelerisque nec ac lacus. Quisque eget arcu pellentesque, sollicitudin turpis quis, placerat nulla. Sed tristique felis ut mi cursus mattis. Nunc ornare, ex vitae suscipit condimentum, est diam convallis ante, ac tincidunt dui ante in sem. Vivamus vitae laoreet velit, ac vestibulum dui. Mauris id fringilla libero, ac tempor ex. Praesent sagittis enim ac dui rhoncus lacinia. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus luctus odio ipsum, et scelerisque lorem luctus eu.", links: [])),
                BrowserPageElement.text(BrowserPageText(text: "Aliquam erat volutpat. Vivamus faucibus urna condimentum ex viverra molestie. Quisque porta dignissim gravida. Pellentesque id ultricies leo. Donec interdum metus neque, tempus accumsan erat ullamcorper a. Nullam gravida risus quis enim aliquet porttitor. Sed sagittis, nulla non condimentum consequat, sem nisl commodo massa, nec malesuada neque enim ultrices dolor. Pellentesque porta a justo at consequat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam porttitor aliquet aliquet. Nullam sed malesuada nisl. Nam placerat ultrices erat quis rutrum. Morbi convallis neque eu mauris mollis finibus sed ac ante. Curabitur gravida ligula sit amet dui imperdiet convallis. Duis ullamcorper, tortor luctus viverra rhoncus, ante ligula faucibus est, eu suscipit turpis nisl ut lacus.", links: [])),
                BrowserPageElement.text(BrowserPageText(text: "Suspendisse consectetur semper ipsum et lobortis. Nullam eu aliquam metus. Suspendisse tincidunt eros elit, nec malesuada justo mattis ac. Vivamus tristique, metus quis posuere ornare, ex quam sollicitudin magna, a placerat mi sapien id velit. Donec nec erat sed erat volutpat faucibus. Ut vehicula nulla ac est bibendum, quis molestie dui scelerisque. Phasellus vestibulum arcu et sagittis lobortis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer quis velit pellentesque, sodales elit id, tincidunt diam. Donec sapien dolor, semper quis auctor quis, feugiat at magna. Vivamus malesuada blandit libero sit amet volutpat. Praesent massa velit, porttitor ac sapien vitae, imperdiet tristique eros. Etiam at dolor venenatis, tempus erat id, convallis ligula. Vivamus fringilla sed orci id tincidunt. Sed sit amet suscipit nibh. Proin sed diam blandit, sollicitudin libero sed, posuere risus.", links: [])),
                BrowserPageElement.text(BrowserPageText(text: "Nullam ut eleifend eros. Aenean at purus vel leo interdum pretium. Praesent tellus neque, tincidunt eu elit sit amet, auctor tristique justo. Sed placerat nisl a dolor commodo, ac luctus orci bibendum. Phasellus ac dolor in lacus congue rhoncus. Sed mattis nulla quis augue aliquet viverra. Donec diam ex, luctus ac ligula vel, faucibus aliquam magna. Praesent congue tortor ut elit posuere, at sollicitudin ante vulputate. Nulla ac nibh justo. Fusce egestas at ipsum ac dignissim.", links: [])),
                BrowserPageElement.text(BrowserPageText(text: "In porta imperdiet lectus, quis tempor nisi. Aenean in nisl quis eros faucibus interdum. Quisque pulvinar tincidunt risus in luctus. Nunc commodo ante non ultrices ullamcorper. Vivamus sit amet enim quis augue tincidunt posuere. Proin vestibulum pulvinar rutrum. Phasellus elementum blandit metus, non placerat mi pharetra eu. In vitae lacus justo.", links: []))
            ]
        let buckthornPages =
            [
                BrowserPage(elements: buckthornPage1Elements),
                BrowserPage(elements: buckthornPage2Elements)
            ]
        let buckthornFlower = Flower(commonName: "Buckthorn", latinName: "Vivamus Faucibus", image: "buckthorn", level: 1.0, pages: buckthornPages)
        Learnables.append(buckthornFlower)
    }
}
