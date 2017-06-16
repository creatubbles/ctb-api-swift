//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class SearchTagDAO: NSObject, APIClientDAO {
    fileprivate let requestSender: RequestSender

    required init(dependencies: DAODependencies) {
        self.requestSender = dependencies.requestSender
    }

    func fetchSearchTags(completion: SearchTagsClosure?) -> RequestHandler {
        //Mock method - until it's ready on API's side, this method will return some premade mock SearchTags.
        let request = SearchTagsFetchRequest()
        let objects = prepareMockSearchTags()

        completion?(objects, nil)

        return RequestHandler(object: request as Cancelable)
    }

    private func prepareMockSearchTags() -> Array<SearchTag> {
        //Please note, that imageTagURL can be changed in future. For best experience, you can use (probably after scaling) images from Resources/MockSearchTagImages folder. Sorry for inconvinience!

        //Lego
        let legoTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/lego-b8ad79890b22bee5d8c55dc4ac17a446.jpg"
        let legoNames = [NameTranslationObject(code:"en", name:"Lego", original: true),
                         NameTranslationObject(code:"ja", name:"Lego", original: false),
                         NameTranslationObject(code:"it", name:"Lego", original: false)]
        let legoTag = SearchTag(name: "Lego", imageURL: legoTagURL, identifier: "search-tag-lego", translatedNames: legoNames)

        //Minecraft
        let minecraftTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/minecraft-857ee3b90a20e1c5ac16bcd399824673.jpg"
        let minecraftNames = [NameTranslationObject(code:"en", name:"Minecraft", original: true),
                              NameTranslationObject(code:"ja", name:"マインクラフト", original: false),
                              NameTranslationObject(code:"it", name:"Minecraft", original: false)]
        let minecraftTag = SearchTag(name: "Minecraft", imageURL: minecraftTagURL, identifier: "search-tag-minecraft", translatedNames: minecraftNames)

        //Beads
        let beadsTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/beads-1a9a1fca6f88d0326097ae6333a1c979.jpg"
        let beadsNames = [NameTranslationObject(code:"en", name:"Beads", original: true),
                          NameTranslationObject(code:"ja", name:"ビーズ", original: false),
                          NameTranslationObject(code:"it", name:"Beads", original: false)]
        let beadsTag = SearchTag(name: "Beads", imageURL: beadsTagURL, identifier: "search-tag-beads", translatedNames: beadsNames)

        //Rainbow loom
        let rainbowLoomTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/rainbow_loom-3b41da1a4863086ccb5ed6a7da2242c3.jpg"
        let rainbowLoomNames = [NameTranslationObject(code:"en", name:"Rainbow loom", original: true),
                                NameTranslationObject(code:"ja", name:"Rainbow loom", original: false),
                                NameTranslationObject(code:"it", name:"Rainbow loom", original: false)]
        let rainbowLoomTag = SearchTag(name: "Rainbow loom", imageURL: rainbowLoomTagURL, identifier: "search-tag-rainbow-loom", translatedNames: rainbowLoomNames)

        //Hue Animation
        let hueAnimationTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/hue_animation-d4fc39474f8a97566143d314b5590ff9.jpg"
        let hueAnimationNames = [NameTranslationObject(code:"en", name:"Hue Animation", original: true),
                                 NameTranslationObject(code:"ja", name:"Hue Animation", original: false),
                                 NameTranslationObject(code:"it", name:"Hue Animation", original: false)]
        let hueAnimationTag = SearchTag(name: "Hue Animation", imageURL: hueAnimationTagURL, identifier: "search-tag-hue-animation", translatedNames: hueAnimationNames)

        //Origami
        let origamiTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/origami-9ceedaeb753a3234fc547e2703eca108.jpg"
        let origamiNames = [NameTranslationObject(code:"en", name:"Origami", original: true),
                            NameTranslationObject(code:"ja", name:"おりがみ", original: false),
                            NameTranslationObject(code:"it", name:"Origami", original: false)]
        let origamiTag = SearchTag(name: "Origami", imageURL: origamiTagURL, identifier: "search-tag-origami", translatedNames: origamiNames)

        //Quirkbots
        let quirkbotsTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/quirkbots-edda7203aa03108ffd365fd743a8677f.jpg"
        let quirkbotsNames = [NameTranslationObject(code:"en", name:"Quirkbots", original: true),
                              NameTranslationObject(code:"ja", name:"Quirkbots", original: false),
                              NameTranslationObject(code:"it", name:"Quirkbots", original: false)]
        let quirkbotsTag = SearchTag(name: "Quirkbots", imageURL: quirkbotsTagURL, identifier: "search-tag-quirkbots", translatedNames: quirkbotsNames)

        //Cars
        let carsTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/cars-1f5d8ac794566ef1ae2410fe6c59bb3f.jpg"
        let carsNames = [NameTranslationObject(code:"en", name:"Cars", original: true),
                         NameTranslationObject(code:"ja", name:"Cars", original: false),
                         NameTranslationObject(code:"it", name:"Cars", original: false)]
        let carsTag = SearchTag(name: "Cars", imageURL: carsTagURL, identifier: "search-tag-cars", translatedNames: carsNames)

        //3D
        let threeDTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/3d-b549feb76a4b126f7ddb65d755caf179.jpg"
        let threeDNames = [NameTranslationObject(code:"en", name:"3D", original: true),
                       NameTranslationObject(code:"ja", name:"3D", original: false),
                       NameTranslationObject(code:"it", name:"3D", original: false)]
        let threeDTag = SearchTag(name: "3D", imageURL: threeDTagURL, identifier: "search-tag-3d", translatedNames: threeDNames)

        //Scratch
        let scratchTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/scratch-f07bb305df1932ef81ccc1fe5617b04e.jpg"
        let scratchNames = [NameTranslationObject(code:"en", name:"Scratch", original: true),
                            NameTranslationObject(code:"ja", name:"スクラッチ", original: false),
                            NameTranslationObject(code:"it", name:"Scratch", original: false)]
        let scratchTag = SearchTag(name: "Scratch", imageURL: scratchTagURL, identifier: "search-tag-scratch", translatedNames: scratchNames)

        //Pokemon
        let pokemonTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/pokemon-e23319f7d2402bf3bd6607978d8684b6.jpg"
        let pokemonNames = [NameTranslationObject(code:"en", name:"Pokemon", original: true),
                            NameTranslationObject(code:"ja", name:"ポケモン", original: false),
                            NameTranslationObject(code:"it", name:"Pokemon", original: false)]
        let pokemonTag = SearchTag(name: "Pokemon", imageURL: pokemonTagURL, identifier: "search-tag-pokemon", translatedNames: pokemonNames)

        //Blocks
        let blocksTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/blocks-b75c1eebf84f0143d7b5aa19af56c3a2.jpg"
        let blocksNames = [NameTranslationObject(code:"en", name:"Blocks", original: true),
                           NameTranslationObject(code:"ja", name:"ブロック", original: false),
                           NameTranslationObject(code:"it", name:"Blocks", original: false)]
        let blocksTag = SearchTag(name: "Blocks", imageURL: blocksTagURL, identifier: "search-tag-blocks", translatedNames: blocksNames)

        //Strawbees
        let strawbeesTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/strawbees-f1ea6ed75d6185519cea654da9667c90.jpg"
        let strawbeesNames = [NameTranslationObject(code:"en", name:"Strawbees", original: true),
                              NameTranslationObject(code:"ja", name:"Strawbees", original: false),
                              NameTranslationObject(code:"it", name:"Strawbees", original: false)]
        let strawbeesTag = SearchTag(name: "Strawbees", imageURL: strawbeesTagURL, identifier: "search-tag-strawbees", translatedNames: strawbeesNames)

        //Littlebits
        let littlebitsTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/littlebits-00fdf5d7ecc0808929e10cb3399cfd2d.jpg"
        let littlebitsNames = [NameTranslationObject(code:"en", name:"Littlebits", original: true),
                               NameTranslationObject(code:"ja", name:"Littlebits", original: false),
                               NameTranslationObject(code:"it", name:"Littlebits", original: false)]
        let littlebitsTag = SearchTag(name: "Littlebits", imageURL: littlebitsTagURL, identifier: "search-tag-littlebits", translatedNames: littlebitsNames)

        //Characters
        let charactersTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/characters-b7ab1dcd40b0682823ba0885e56532f9.jpg"
        let charactersNames = [NameTranslationObject(code:"en", name:"Characters", original: true),
                               NameTranslationObject(code:"ja", name:"キャラクター", original: false),
                               NameTranslationObject(code:"it", name:"Characters", original: false)]
        let charactersTag = SearchTag(name: "Characters", imageURL: charactersTagURL, identifier: "search-tag-characters", translatedNames: charactersNames)

        //Paper craft
        let paperCraftTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/paper_craft-e86d08da9149ce2c2d1de54cf5921498.jpg"
        let paperCraftNames = [NameTranslationObject(code:"en", name:"Paper craft", original: true),
                               NameTranslationObject(code:"ja", name:"ペーパークラフト", original: false),
                               NameTranslationObject(code:"it", name:"Paper craft", original: false)]
        let paperCraftTag = SearchTag(name: "Paper craft", imageURL: paperCraftTagURL, identifier: "search-tag-paper-craft", translatedNames: paperCraftNames)

        //Robots
        let robotsTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/robots-2f8a784d4bc67468da2a2ae1ebf5020c.jpg"
        let robotsNames = [NameTranslationObject(code:"en", name:"Robots", original: true),
                           NameTranslationObject(code:"ja", name:"ロボット", original: false),
                           NameTranslationObject(code:"it", name:"Robots", original: false)]
        let robotsTag = SearchTag(name: "Robots", imageURL: robotsTagURL, identifier: "search-tag-robots", translatedNames: robotsNames)

        //Tinkercad
        let tinkercadTagURL = "https://d3i3mct63wvprb.cloudfront.net/assets/images/suggested-searches/thinkercard-75d78701eb6c02c42b424f9c206b0d9c.jpg"
        let tinkercadNames = [NameTranslationObject(code:"en", name:"Tinkercad", original: true),
                              NameTranslationObject(code:"ja", name:"Tinkercad", original: false),
                              NameTranslationObject(code:"it", name:"Tinkercad", original: false)]
        let tinkercadTag = SearchTag(name: "Tinkercad", imageURL: tinkercadTagURL, identifier: "search-tag-tinkercad", translatedNames: tinkercadNames)

        return [legoTag, minecraftTag, beadsTag, rainbowLoomTag, hueAnimationTag, origamiTag, quirkbotsTag, carsTag, threeDTag, scratchTag, pokemonTag, blocksTag, strawbeesTag, littlebitsTag, charactersTag, paperCraftTag, robotsTag, tinkercadTag]
    }
}
