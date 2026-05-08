{
    "name": "Span",
    "variables": [
        {
            "name": "BlockSection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "BS_NOT_BLOCK",
                    "description": "Блок-участок не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Перегон_блокировка_блок_участка",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "BS_BLOCK",
                    "description": "Блок-участок блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Перегон_блокировка_блок_участка",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrackCircuit1",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NO_INFO",
                    "description": "Рельсовая цепь перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x30",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "1_рельсовая_цепь_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_OCCUPIED",
                    "description": "1-я рельсовая цепь перегона - занята",
                    "contexts": [
                        {
                            "eventId": "0x31",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "1_рельсовая_цепь_блок_участка",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "TC_FREE",
                    "description": "1-я рельсовая цепь перегона - свободна",
                    "contexts": [
                        {
                            "eventId": "0x32",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "1_рельсовая_цепь_блок_участка",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrackCircuit2",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NO_INFO",
                    "description": "Рельсовая цепь перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x33",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "2_рельсовая_цепь_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_OCCUPIED",
                    "description": "2-я рельсовая цепь перегона - занята",
                    "contexts": [
                        {
                            "eventId": "0x34",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "2_рельсовая_цепь_блок_участка",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "TC_FREE",
                    "description": "2-я рельсовая цепь перегона - свободна",
                    "contexts": [
                        {
                            "eventId": "0x35",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "2_рельсовая_цепь_блок_участка",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrackCircuit3",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NO_INFO",
                    "description": "Рельсовая цепь перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x36",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "3_рельсовая_цепь_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_OCCUPIED",
                    "description": "3-я рельсовая цепь перегона - занята",
                    "contexts": [
                        {
                            "eventId": "0x37",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "3_рельсовая_цепь_блок_участка",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "TC_FREE",
                    "description": "3-я рельсовая цепь перегона - свободна",
                    "contexts": [
                        {
                            "eventId": "0x38",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "3_рельсовая_цепь_блок_участка",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrackCircuit4",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NO_INFO",
                    "description": "Рельсовая цепь перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x39",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "4_рельсовая_цепь_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_OCCUPIED",
                    "description": "4-я рельсовая цепь перегона - занята",
                    "contexts": [
                        {
                            "eventId": "0x3A",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "4_рельсовая_цепь_блок_участка",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "TC_FREE",
                    "description": "4-я рельсовая цепь перегона - свободна",
                    "contexts": [
                        {
                            "eventId": "0x3B",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "4_рельсовая_цепь_блок_участка",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrackCircuit5",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NO_INFO",
                    "description": "Рельсовая цепь перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x3C",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "5_рельсовая_цепь_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_OCCUPIED",
                    "description": "5-я рельсовая цепь перегона - занята",
                    "contexts": [
                        {
                            "eventId": "0x3D",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "5_рельсовая_цепь_блок_участка",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "TC_FREE",
                    "description": "5-я рельсовая цепь перегона - свободна",
                    "contexts": [
                        {
                            "eventId": "0x3E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "5_рельсовая_цепь_блок_участка",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockTrackCircuit1",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NOT_BLOCKED",
                    "description": "1-я рельсовая цепь перегона - не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x60",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_1_рельсовой_цепи_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_BLOCKED",
                    "description": "1-я рельсовая цепь перегона - блокирована",
                    "contexts": [
                        {
                            "eventId": "0x61",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_1_рельсовой_цепи_блок_участка",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockTrackCircuit2",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NOT_BLOCKED",
                    "description": "2-я рельсовая цепь перегона - не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x62",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_2_рельсовой_цепи_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_BLOCKED",
                    "description": "2-я рельсовая цепь перегона - блокирована",
                    "contexts": [
                        {
                            "eventId": "0x63",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_2_рельсовой_цепи_блок_участка",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockTrackCircuit3",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NOT_BLOCKED",
                    "description": "3-я рельсовая цепь перегона - не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x64",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_3_рельсовой_цепи_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_BLOCKED",
                    "description": "3-я рельсовая цепь перегона - блокирована",
                    "contexts": [
                        {
                            "eventId": "0x65",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_3_рельсовой_цепи_блок_участка",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockTrackCircuit4",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NOT_BLOCKED",
                    "description": "4-я рельсовая цепь перегона - не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x66",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_4_рельсовой_цепи_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_BLOCKED",
                    "description": "4-я рельсовая цепь перегона - блокирована",
                    "contexts": [
                        {
                            "eventId": "0x67",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_4_рельсовой_цепи_блок_участка",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockTrackCircuit5",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TC_NOT_BLOCKED",
                    "description": "5-я рельсовая цепь перегона - не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x6A",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_5_рельсовой_цепи_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TC_BLOCKED",
                    "description": "5-я рельсовая цепь перегона - блокирована",
                    "contexts": [
                        {
                            "eventId": "0x6B",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_5_рельсовой_цепи_блок_участка",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "TransmitterCode1",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "CODE_KJ",
                    "description": "1-я рельсовая цепь перегона - включен код 'КЖ'",
                    "contexts": [
                        {
                            "eventId": "0x5C",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_J",
                    "description": "1-я рельсовая цепь перегона - включен код 'Ж'",
                    "contexts": [
                        {
                            "eventId": "0x5D",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_Z",
                    "description": "1-я рельсовая цепь перегона - включен код 'З'",
                    "contexts": [
                        {
                            "eventId": "0x5E",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_PROTECT",
                    "description": "1-я рельсовая цепь перегона - включен код 'Защитный код'",
                    "contexts": [
                        {
                            "eventId": "0x5F",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "TransmitterCode2",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "CODE_KJ",
                    "description": "2-я рельсовая цепь перегона - включен код 'КЖ'",
                    "contexts": [
                        {
                            "eventId": "0x4C",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_J",
                    "description": "2-я рельсовая цепь перегона - включен код 'Ж'",
                    "contexts": [
                        {
                            "eventId": "0x4D",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_Z",
                    "description": "2-я рельсовая цепь перегона - включен код 'З'",
                    "contexts": [
                        {
                            "eventId": "0x4A",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_PROTECT",
                    "description": "2-я рельсовая цепь перегона - включен код 'Защитный код'",
                    "contexts": [
                        {
                            "eventId": "0x4F",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "TransmitterCode3",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "CODE_KJ",
                    "description": "3-я рельсовая цепь перегона - включен код 'КЖ'",
                    "contexts": [
                        {
                            "eventId": "0x80",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_J",
                    "description": "3-я рельсовая цепь перегона - включен код 'Ж'",
                    "contexts": [
                        {
                            "eventId": "0x81",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_Z",
                    "description": "3-я рельсовая цепь перегона - включен код 'З'",
                    "contexts": [
                        {
                            "eventId": "0x82",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_PROTECT",
                    "description": "3-я рельсовая цепь перегона - включен код 'Защитный код'",
                    "contexts": [
                        {
                            "eventId": "0x83",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "TransmitterCode4",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "CODE_KJ",
                    "description": "4-я рельсовая цепь перегона - включен код 'КЖ'",
                    "contexts": [
                        {
                            "eventId": "0x88",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_J",
                    "description": "4-я рельсовая цепь перегона - включен код 'Ж'",
                    "contexts": [
                        {
                            "eventId": "0x89",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_Z",
                    "description": "4-я рельсовая цепь перегона - включен код 'З'",
                    "contexts": [
                        {
                            "eventId": "0x8A",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_PROTECT",
                    "description": "4-я рельсовая цепь перегона - включен код 'Защитный код'",
                    "contexts": [
                        {
                            "eventId": "0x8B",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "CodeGen1",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "GEN_OFF",
                    "description": "1-я рельсовая цепь перегона - выключена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x59",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_ON",
                    "description": "1-я рельсовая цепь перегона - включена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x5A",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "CodeGen2",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "GEN_OFF",
                    "description": "2-я рельсовая цепь перегона - выключена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x29",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_ON",
                    "description": "2-я рельсовая цепь перегона - включена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x2A",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "CodeGen3",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "GEN_OFF",
                    "description": "3-я рельсовая цепь перегона - выключена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x28",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_ON",
                    "description": "3-я рельсовая цепь перегона - включена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x2B",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "CodeGen4",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "RESERVED",
                    "description": "4-я рельсовая цепь перегона - зарезервировано",
                    "contexts": [
                        {
                            "eventId": "0x8C",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_OFF",
                    "description": "4-я рельсовая цепь перегона - выключена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x8D",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_ON",
                    "description": "4-я рельсовая цепь перегона - включена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x8E",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "RESERVED2",
                    "description": "4-я рельсовая цепь перегона - зарезервировано",
                    "contexts": [
                        {
                            "eventId": "0x8F",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "CodeGen5",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "RESERVED",
                    "description": "5-я рельсовая цепь перегона - зарезервировано",
                    "contexts": [
                        {
                            "eventId": "0x84",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_OFF",
                    "description": "5-я рельсовая цепь перегона - выключена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x85",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "GEN_ON",
                    "description": "5-я рельсовая цепь перегона - включена генерация кода",
                    "contexts": [
                        {
                            "eventId": "0x86",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "RESERVED2",
                    "description": "5-я рельсовая цепь перегона - зарезервировано",
                    "contexts": [
                        {
                            "eventId": "0x87",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "SignalPoint",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "SP_NO_INFO",
                    "description": "Сигнальная точка-нет информации",
                    "contexts": [
                        {
                            "eventId": "64",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "SP_RED",
                    "description": "Красный",
                    "contexts": [
                        {
                            "eventId": "65",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "SP_YELLOW",
                    "description": "Жёлтый",
                    "contexts": [
                        {
                            "eventId": "67",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 3
                        }
                    ]
                },
                {
                    "name": "SP_GREEN",
                    "description": "Зеленый",
                    "contexts": [
                        {
                            "eventId": "69",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 5
                        }
                    ]
                },
                {
                    "name": "SP_YELLOW_FLASHING",
                    "description": "Жёлтый мигающий",
                    "contexts": [
                        {
                            "eventId": "72",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 8
                        }
                    ]
                },
                {
                    "name": "SP_GREEN_AND_YELLOW",
                    "description": "Зеленый + Жёлтый",
                    "contexts": [
                        {
                            "eventId": "73",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 9
                        }
                    ]
                },
                {
                    "name": "SP_GREEN_FLASHING",
                    "description": "Зеленый мигающий",
                    "contexts": [
                        {
                            "eventId": "66",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 13
                        }
                    ]
                },
                {
                    "name": "SP_DARK",
                    "description": "Темный",
                    "contexts": [
                        {
                            "eventId": "78",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнальная_точка_блок_участка",
                            "value": 7
                        }
                    ]
                }
            ]
        }
    ]
}
