//
//  EntryService.swift
//  App
//
//  Created by Yusei Nishiyama on 24/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import APIClient
import OxfordDictionary

class EntryService: Service {
    func headwordEntry(completion: (Result<HeadwordEntry, APIClient.Error>) -> ()) {

//        let entries = Entries(wordID: wordID)
//        let apiClient = OxfordDictionaryClient(environment: Environment())
//        apiClient.request(endpoint: entries) { result in
//            switch result {
//            case let .success(retrieveEntry):
//                self.headwordEntry = retrieveEntry.results ?? []
//            case let .failure(error):
//                print(error)
//            }
//        }

        let retriveEntry = mockRetrivedEntry()

        guard let headwordEntries = retriveEntry.results, headwordEntries.count == 1 else {
            preconditionFailure("Success response should contain one headword")
        }

        let lexicalEntries = headwordEntries[0].lexicalEntries
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

            return Homograph.init(word: "", pronunciation: "", lexicalEntries: lexicalEntries)
        }

        let headwordEntry = HeadwordEntry(homographs: homographs)
        completion(.success(headwordEntry))
    }

    func mockRetrivedEntry() -> RetrieveEntry {
        let dataString = "{\n    \"metadata\": {\n        \"provider\": \"Oxford University Press\"\n    },\n    \"results\": [\n        {\n            \"id\": \"ace\",\n            \"language\": \"en\",\n            \"lexicalEntries\": [\n                {\n                    \"entries\": [\n                        {\n                            \"etymologies\": [\n                                \"Middle English (denoting the ‘one’ on dice): via Old French from Latin as ‘unity, a unit’\"\n                            ],\n                            \"grammaticalFeatures\": [\n                                {\n                                    \"text\": \"Singular\",\n                                    \"type\": \"Number\"\n                                }\n                            ],\n                            \"homographNumber\": \"100\",\n                            \"senses\": [\n                                {\n                                    \"definitions\": [\n                                        \"a playing card with a single spot on it, ranked as the highest card in its suit in most card games\"\n                                    ],\n                                    \"domains\": [\n                                        \"Cards\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"registers\": [\n                                                \"figurative\"\n                                            ],\n                                            \"text\": \"life had started dealing him aces again\"\n                                        },\n                                        {\n                                            \"text\": \"the ace of diamonds\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.006\",\n                                    \"short_definitions\": [\n                                        \"playing card with single spot on it, ranked as highest card in its suit in most card games\"\n                                    ]\n                                },\n                                {\n                                    \"definitions\": [\n                                        \"a person who excels at a particular sport or other activity\"\n                                    ],\n                                    \"domains\": [\n                                        \"Sport\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"a motorcycle ace\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.010\",\n                                    \"registers\": [\n                                        \"informal\"\n                                    ],\n                                    \"short_definitions\": [\n                                        \"person who excels at particular sport or other activity\"\n                                    ],\n                                    \"subsenses\": [\n                                        {\n                                            \"definitions\": [\n                                                \"a pilot who has shot down many enemy aircraft\"\n                                            ],\n                                            \"domains\": [\n                                                \"Air Force\"\n                                            ],\n                                            \"examples\": [\n                                                {\n                                                    \"text\": \"a Battle of Britain ace\"\n                                                }\n                                            ],\n                                            \"id\": \"m_en_gbus0005680.011\",\n                                            \"short_definitions\": [\n                                                \"pilot who has shot down many enemy aircraft\"\n                                            ]\n                                        }\n                                    ],\n                                    \"thesaurusLinks\": [\n                                        {\n                                            \"entry_id\": \"ace\",\n                                            \"sense_id\": \"t_en_gb0000173.001\"\n                                        }\n                                    ]\n                                },\n                                {\n                                    \"definitions\": [\n                                        \"(in tennis and similar games) a service that an opponent is unable to return and thus wins a point\"\n                                    ],\n                                    \"domains\": [\n                                        \"Tennis\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"Nadal banged down eight aces in the set\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.013\",\n                                    \"short_definitions\": [\n                                        \"(in tennis and similar games) service that opponent is unable to return and thus wins point\"\n                                    ],\n                                    \"subsenses\": [\n                                        {\n                                            \"definitions\": [\n                                                \"a hole in one\"\n                                            ],\n                                            \"domains\": [\n                                                \"Golf\"\n                                            ],\n                                            \"examples\": [\n                                                {\n                                                    \"text\": \"his hole in one at the 15th was Senior\'s second ace as a professional\"\n                                                }\n                                            ],\n                                            \"id\": \"m_en_gbus0005680.014\",\n                                            \"registers\": [\n                                                \"informal\"\n                                            ],\n                                            \"short_definitions\": [\n                                                \"hole in one\"\n                                            ]\n                                        }\n                                    ]\n                                }\n                            ]\n                        },\n                        {\n                            \"etymologies\": [\n                                \"early 21st century: abbreviation of asexual, with alteration of spelling on the model of ace\"\n                            ],\n                            \"grammaticalFeatures\": [\n                                {\n                                    \"text\": \"Singular\",\n                                    \"type\": \"Number\"\n                                }\n                            ],\n                            \"homographNumber\": \"200\",\n                            \"senses\": [\n                                {\n                                    \"definitions\": [\n                                        \"a person who has no sexual feelings or desires\"\n                                    ],\n                                    \"domains\": [\n                                        \"Sex\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"both asexual, they have managed to connect with other aces offline\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus1190638.004\",\n                                    \"short_definitions\": [\n                                        \"asexual person\"\n                                    ]\n                                }\n                            ]\n                        }\n                    ],\n                    \"language\": \"en\",\n                    \"lexicalCategory\": \"Noun\",\n                    \"pronunciations\": [\n                        {\n                            \"audioFile\": \"http://audio.oxforddictionaries.com/en/mp3/ace_1_gb_1_abbr.mp3\",\n                            \"dialects\": [\n                                \"British English\"\n                            ],\n                            \"phoneticNotation\": \"IPA\",\n                            \"phoneticSpelling\": \"eɪs\"\n                        }\n                    ],\n                    \"text\": \"ace\"\n                },\n                {\n                    \"entries\": [\n                        {\n                            \"grammaticalFeatures\": [\n                                {\n                                    \"text\": \"Positive\",\n                                    \"type\": \"Degree\"\n                                }\n                            ],\n                            \"homographNumber\": \"101\",\n                            \"senses\": [\n                                {\n                                    \"definitions\": [\n                                        \"very good\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"Ace! You\'ve done it!\"\n                                        },\n                                        {\n                                            \"text\": \"an ace swimmer\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.016\",\n                                    \"registers\": [\n                                        \"informal\"\n                                    ],\n                                    \"short_definitions\": [\n                                        \"very good\"\n                                    ],\n                                    \"thesaurusLinks\": [\n                                        {\n                                            \"entry_id\": \"ace\",\n                                            \"sense_id\": \"t_en_gb0000173.002\"\n                                        }\n                                    ]\n                                }\n                            ]\n                        },\n                        {\n                            \"grammaticalFeatures\": [\n                                {\n                                    \"text\": \"Positive\",\n                                    \"type\": \"Degree\"\n                                }\n                            ],\n                            \"homographNumber\": \"201\",\n                            \"senses\": [\n                                {\n                                    \"definitions\": [\n                                        \"(of a person) having no sexual feelings or desires; asexual\"\n                                    ],\n                                    \"domains\": [\n                                        \"Sex\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"I didn\'t realize that I was ace for a long time\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus1190638.006\",\n                                    \"short_definitions\": [\n                                        \"asexual\"\n                                    ]\n                                }\n                            ]\n                        }\n                    ],\n                    \"language\": \"en\",\n                    \"lexicalCategory\": \"Adjective\",\n                    \"pronunciations\": [\n                        {\n                            \"audioFile\": \"http://audio.oxforddictionaries.com/en/mp3/ace_1_gb_1_abbr.mp3\",\n                            \"dialects\": [\n                                \"British English\"\n                            ],\n                            \"phoneticNotation\": \"IPA\",\n                            \"phoneticSpelling\": \"eɪs\"\n                        }\n                    ],\n                    \"text\": \"ace\"\n                },\n                {\n                    \"entries\": [\n                        {\n                            \"grammaticalFeatures\": [\n                                {\n                                    \"text\": \"Transitive\",\n                                    \"type\": \"Subcategorization\"\n                                },\n                                {\n                                    \"text\": \"Present\",\n                                    \"type\": \"Tense\"\n                                }\n                            ],\n                            \"homographNumber\": \"102\",\n                            \"senses\": [\n                                {\n                                    \"definitions\": [\n                                        \"(in tennis and similar games) serve an ace against (an opponent)\"\n                                    ],\n                                    \"domains\": [\n                                        \"Tennis\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"he can ace opponents with serves of no more than 62 mph\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.020\",\n                                    \"registers\": [\n                                        \"informal\"\n                                    ],\n                                    \"short_definitions\": [\n                                        \"(in tennis and similar games) serve ace against\"\n                                    ],\n                                    \"subsenses\": [\n                                        {\n                                            \"definitions\": [\n                                                \"score an ace on (a hole) or with (a shot)\"\n                                            ],\n                                            \"domains\": [\n                                                \"Golf\"\n                                            ],\n                                            \"examples\": [\n                                                {\n                                                    \"text\": \"there was a prize for the first player to ace the hole\"\n                                                }\n                                            ],\n                                            \"id\": \"m_en_gbus0005680.026\",\n                                            \"short_definitions\": [\n                                                \"score ace on hole or with\"\n                                            ]\n                                        }\n                                    ]\n                                },\n                                {\n                                    \"definitions\": [\n                                        \"achieve high marks in (a test or exam)\"\n                                    ],\n                                    \"examples\": [\n                                        {\n                                            \"text\": \"I aced my grammar test\"\n                                        }\n                                    ],\n                                    \"id\": \"m_en_gbus0005680.028\",\n                                    \"regions\": [\n                                        \"North American\"\n                                    ],\n                                    \"registers\": [\n                                        \"informal\"\n                                    ],\n                                    \"short_definitions\": [\n                                        \"achieve high marks in\"\n                                    ],\n                                    \"subsenses\": [\n                                        {\n                                            \"definitions\": [\n                                                \"outdo someone in a competitive situation\"\n                                            ],\n                                            \"examples\": [\n                                                {\n                                                    \"text\": \"the magazine won an award, acing out its rivals\"\n                                                }\n                                            ],\n                                            \"id\": \"m_en_gbus0005680.029\",\n                                            \"notes\": [\n                                                {\n                                                    \"text\": \"\\\"ace someone out\\\"\",\n                                                    \"type\": \"wordFormNote\"\n                                                }\n                                            ],\n                                            \"short_definitions\": [\n                                                \"outdo someone in competitive situation\"\n                                            ]\n                                        }\n                                    ]\n                                }\n                            ]\n                        }\n                    ],\n                    \"language\": \"en\",\n                    \"lexicalCategory\": \"Verb\",\n                    \"pronunciations\": [\n                        {\n                            \"audioFile\": \"http://audio.oxforddictionaries.com/en/mp3/ace_1_gb_1_abbr.mp3\",\n                            \"dialects\": [\n                                \"British English\"\n                            ],\n                            \"phoneticNotation\": \"IPA\",\n                            \"phoneticSpelling\": \"eɪs\"\n                        }\n                    ],\n                    \"text\": \"ace\"\n                }\n            ],\n            \"type\": \"headword\",\n            \"word\": \"ace\"\n        }\n    ]\n}"

        let data = dataString.data(using: .utf8)
        return try! JSONDecoder().decode(RetrieveEntry.self, from: data!)
    }
}
