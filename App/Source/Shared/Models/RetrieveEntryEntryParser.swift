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

        var homographs = [Homograph]()
        for homographIndex in (0..<numberOfHomographs) {

            var parsedLexicalEntries = [LexicalEntry]()
            for lexicalEntry in lexicalEntries {

                guard let entries = lexicalEntry.entries else {
                    preconditionFailure("LexicalEntry should have entries")
                }

                var availableSenses: [Sense]?

                for entry in entries {

                    guard let homographNumber = entry.homographNumber else {
                        preconditionFailure("Entry should have homograph number")
                    }

                    let homographNumberDigits = homographNumber.map(String.init)
                    precondition(homographNumberDigits.count == 3, "homographNumber should consist of 3 digits")
                    precondition(homographNumberDigits[0] <= String(numberOfHomographs), "homographNumber should be smaller than or equal to number of homographs")

                    // Skip entries in different homographs
                    guard homographNumberDigits[0] == String(homographIndex+1) else { continue }

                    precondition(availableSenses == nil, "There should be only one set of senses in a lexical entry")

                    guard let senses = entry.senses, senses.count > 0 else {
                        preconditionFailure("Entry should have at least one sense")
                    }

                    var parsedSenses = [Sense]()
                    for sense in senses {

                        var parsedSubsenses = [Subsense]()
                        for subsense in sense.subsenses ?? [] {

                            guard let definitions = subsense.definitions, definitions.count == 1 else {
                                preconditionFailure("Subsense should have one definition")
                            }

                            parsedSubsenses.append(Subsense(definition: definitions[0]))
                        }

                        guard let definitions = sense.definitions, definitions.count == 1 else {
                            preconditionFailure("Sense should have one definition")
                        }

                        parsedSenses.append(Sense(definition: definitions[0], subsenses: parsedSubsenses))
                    }

                    availableSenses = parsedSenses
                }

                // No sense found in this lexical entry
                guard let senses = availableSenses else { continue }

                precondition(senses.count > 0, "Lexical entry should have at least one sense")

                parsedLexicalEntries.append(LexicalEntry(lexicalCategory: lexicalEntry.lexicalCategory, senses: senses))
            }

            precondition(parsedLexicalEntries.count > 0, "Homograph should have at least one lexical entry")

            homographs.append(Homograph(word: headwordEntry.word, pronunciation: "", lexicalEntries: parsedLexicalEntries))
        }

        return HeadwordEntry(homographs: homographs)
    }
}
