//
//  HeadwordEntryParser.swift
//  App
//
//  Created by Yusei Nishiyama on 05/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import OxfordDictionary

class RetrieveEntryEntryParser: Parser {

    class func parse(_ retrieveEntry: OxfordDictionary.RetrieveEntry) -> HeadwordEntry {

        guard let headwordEntries = retrieveEntry.results, headwordEntries.count == 1 else {
            preconditionFailure("Success response should contain one headword")
        }

        let headwordEntry = headwordEntries[0]

        let lexicalEntries = headwordEntry.lexicalEntries
        let numberOfHomographs = lexicalEntries.reduce(0) { max($0, $1.entries?.count ?? 0) }

        let homographs: [Homograph] = (1..<numberOfHomographs + 1).map { homographIndex in

            let lexicalEntries: [LexicalEntry] = lexicalEntries.compactMap { lexicalEntry in

                guard let entries = lexicalEntry.entries else {
                    preconditionFailure("LexicalEntry should have entries")
                }

                let availableSenses: [[Sense]] = entries.compactMap { entry in

                    guard let homographNumber = entry.homographNumber else {
                        preconditionFailure("Entry should have homograph number")
                    }

                    let homographNumberDigits = homographNumber.map(String.init)
                    precondition(homographNumberDigits.count == 3, "homographNumber should consist of 3 digits")

                    guard String(homographIndex) == homographNumberDigits[0] else { return nil }

                    guard let senses = entry.senses, senses.count > 0 else {
                        fatalError("Entry should have at least one sense")
                    }

                    let parsedSenses: [Sense] = senses.compactMap { sense in

                        let parsedSubsenses: [Subsense] = sense.subsenses?.map { subsense in

                            guard let definitions = subsense.definitions, definitions.count == 1 else {
                                fatalError("Subsense should have one definition")
                            }

                            return Subsense(definition: definitions[0])
                            } ?? []

                        guard let definitions = sense.definitions, definitions.count == 1 else {
                            fatalError("Sense should have one definition")
                        }

                        return Sense(definition: definitions[0], subsenses: parsedSubsenses)
                    }

                    return parsedSenses
                }

                if availableSenses.count == 0 { return nil } // No sense found in this category

                guard availableSenses.count == 1 else {
                    preconditionFailure("There should be only one set of senses in a lexical entry")
                }

                return LexicalEntry(lexicalCategory: lexicalEntry.lexicalCategory, senses: availableSenses[0])
            }

            return Homograph.init(word: headwordEntry.word, pronunciation: "", lexicalEntries: lexicalEntries)
        }

        return HeadwordEntry(homographs: homographs)
    }
}
