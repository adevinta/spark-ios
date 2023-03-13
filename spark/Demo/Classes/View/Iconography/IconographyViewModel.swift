//
//  IconographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographyViewModel {

    // MARK: - Properties

    let sectionViewModels: [IconographySectionViewModel]

    // MARK: - Initialization

    init() {
        let iconographies = CurrentTheme.part.iconography
        self.sectionViewModels = [
            .init(name: "account",
                  itemViewModels: [
                    [
                        .init(name: "bank - fill", iconographyImage: iconographies.account.bank.fill),
                        .init(name: "bank - outlined", iconographyImage: iconographies.account.bank.outlined)
                    ],

                    [
                        .init(name: "holiday - fill", iconographyImage: iconographies.account.holiday.fill),
                        .init(name: "holiday - outlined", iconographyImage: iconographies.account.holiday.outlined)
                    ],

                    [
                        .init(name: "country - fill", iconographyImage: iconographies.account.country.fill),
                        .init(name: "country - outlined", iconographyImage: iconographies.account.country.outlined)
                    ],

                    [
                        .init(name: "home - fill", iconographyImage: iconographies.account.home.fill),
                        .init(name: "home - outlined", iconographyImage: iconographies.account.home.outlined)
                    ],

                    [
                        .init(name: "key - fill", iconographyImage: iconographies.account.key.fill),
                        .init(name: "key - outlined", iconographyImage: iconographies.account.key.outlined)
                    ],

                    [
                        .init(name: "favorite - fill", iconographyImage: iconographies.account.favorite.fill),
                        .init(name: "favorite - outlined", iconographyImage: iconographies.account.favorite.outlined)
                    ],

                    [
                        .init(name: "shoppingCart - fill", iconographyImage: iconographies.account.shoppingCart.fill),
                        .init(name: "shoppingCart - outlined", iconographyImage: iconographies.account.shoppingCart.outlined)
                    ],

                    [
                        .init(name: "store - fill", iconographyImage: iconographies.account.store.fill),
                        .init(name: "store - outlined", iconographyImage: iconographies.account.store.outlined)
                    ],

                    [
                        .init(name: "cv - fill", iconographyImage: iconographies.account.cv.fill),
                        .init(name: "cv - outlined", iconographyImage: iconographies.account.cv.outlined)
                    ],

                    [
                        .init(name: "fileOff - fill", iconographyImage: iconographies.account.fileOff.fill),
                        .init(name: "fileOff - outlined", iconographyImage: iconographies.account.fileOff.outlined)
                    ],

                    [
                        .init(name: "work - fill", iconographyImage: iconographies.account.work.fill),
                        .init(name: "work - outlined", iconographyImage: iconographies.account.work.outlined)
                    ],

                    [
                        .init(name: "card - fill", iconographyImage: iconographies.account.card.fill),
                        .init(name: "card - outlined", iconographyImage: iconographies.account.card.outlined)
                    ],

                    [
                        .init(name: "offer - fill", iconographyImage: iconographies.account.offer.fill),
                        .init(name: "offer - outlined", iconographyImage: iconographies.account.offer.outlined)
                    ],

                    [
                        .init(name: "burgerMenu", iconographyImage: iconographies.account.burgerMenu),
                        .init(name: "activity", iconographyImage: iconographies.account.activity),
                        .init(name: "listing", iconographyImage: iconographies.account.listing),
                        .init(name: "mobileCheck", iconographyImage: iconographies.account.mobileCheck)
                    ]
                  ]),

                .init(name: "actions",
                      itemViewModels: [
                        [
                            .init(name: "calculate - fill", iconographyImage: iconographies.actions.calculate.fill),
                            .init(name: "calculate - outlined", iconographyImage: iconographies.actions.calculate.outlined)
                        ],

                        [
                            .init(name: "copy - fill", iconographyImage: iconographies.actions.copy.fill),
                            .init(name: "copy - outlined", iconographyImage: iconographies.actions.copy.outlined)
                        ],

                        [
                            .init(name: "eye - fill", iconographyImage: iconographies.actions.eye.fill),
                            .init(name: "eye - outlined", iconographyImage: iconographies.actions.eye.outlined)
                        ],

                        [
                            .init(name: "eyeOff - fill", iconographyImage: iconographies.actions.eyeOff.fill),
                            .init(name: "eyeOff - outlined", iconographyImage: iconographies.actions.eyeOff.outlined)
                        ],

                        [
                            .init(name: "like - fill", iconographyImage: iconographies.actions.like.fill),
                            .init(name: "like - outlined", iconographyImage: iconographies.actions.like.outlined)
                        ],

                        [
                            .init(name: "moreMenu - horizontal", iconographyImage: iconographies.actions.moreMenu.horizontal),
                            .init(name: "moreMenu - vertical", iconographyImage: iconographies.actions.moreMenu.vertical)
                        ],

                        [
                            .init(name: "pen - fill", iconographyImage: iconographies.actions.pen.fill),
                            .init(name: "pen - outlined", iconographyImage: iconographies.actions.pen.outlined)
                        ],

                        [
                            .init(name: "print - fill", iconographyImage: iconographies.actions.print.fill),
                            .init(name: "print - outlined", iconographyImage: iconographies.actions.print.outlined)
                        ],

                        [
                            .init(name: "trash - fill", iconographyImage: iconographies.actions.trash.fill),
                            .init(name: "trash - outlined", iconographyImage: iconographies.actions.trash.outlined)
                        ],

                        [
                            .init(name: "trashClose - fill", iconographyImage: iconographies.actions.trashClose.fill),
                            .init(name: "trashClose - outlined", iconographyImage: iconographies.actions.trashClose.outlined)
                        ],

                        [
                            .init(name: "wheel - fill", iconographyImage: iconographies.actions.wheel.fill),
                            .init(name: "wheel - outlined", iconographyImage: iconographies.actions.wheel.outlined)
                        ],

                        [
                            .init(name: "flashlight - fill", iconographyImage: iconographies.actions.flashlight.fill),
                            .init(name: "flashlight - outlined", iconographyImage: iconographies.actions.flashlight.outlined)
                        ],

                        [
                            .init(name: "pause - fill", iconographyImage: iconographies.actions.pause.fill),
                            .init(name: "pause - outlined", iconographyImage: iconographies.actions.pause.outlined)
                        ],

                        [
                            .init(name: "play - fill", iconographyImage: iconographies.actions.play.fill),
                            .init(name: "play - outlined", iconographyImage: iconographies.actions.play.outlined)
                        ],

                        [
                            .init(name: "refresh", iconographyImage: iconographies.actions.refresh),
                            .init(name: "search", iconographyImage: iconographies.actions.search),
                            .init(name: "scan", iconographyImage: iconographies.actions.scan),
                            .init(name: "filter", iconographyImage: iconographies.actions.filter)
                        ]
                      ]),

                .init(name: "arrows",
                      itemViewModels: [
                        [
                            .init(name: "arrow - left", iconographyImage: iconographies.arrows.arrow.left),
                            .init(name: "arrow - right", iconographyImage: iconographies.arrows.arrow.right)
                        ],

                        [
                            .init(name: "arrowDouble - left", iconographyImage: iconographies.arrows.arrowDouble.left),
                            .init(name: "arrowDouble - right", iconographyImage: iconographies.arrows.arrowDouble.right)
                        ],

                        [
                            .init(name: "arrowVertical - left", iconographyImage: iconographies.arrows.arrowVertical.left),
                            .init(name: "arrowVertical - right", iconographyImage: iconographies.arrows.arrowVertical.right)
                        ],

                        [
                            .init(name: "arrowHorizontal - up", iconographyImage: iconographies.arrows.arrowHorizontal.up),
                            .init(name: "arrowHorizontal - down", iconographyImage: iconographies.arrows.arrowHorizontal.down)
                        ],

                        [
                            .init(name: "delete - fill", iconographyImage: iconographies.arrows.delete.fill),
                            .init(name: "delete - outlined", iconographyImage: iconographies.arrows.delete.outlined)
                        ],

                        [
                            .init(name: "graphArrow - up", iconographyImage: iconographies.arrows.graphArrow.up),
                            .init(name: "graphArrow - down", iconographyImage: iconographies.arrows.graphArrow.down)
                        ],

                        [
                            .init(name: "close", iconographyImage: iconographies.arrows.close),
                            .init(name: "plus", iconographyImage: iconographies.arrows.plus)
                        ]
                      ]),

                .init(name: "calendar",
                      itemViewModels: [
                        [
                            .init(name: "calendar - fill", iconographyImage: iconographies.calendar.calendar.fill),
                            .init(name: "calendar - outlined", iconographyImage: iconographies.calendar.calendar.outlined)
                        ],

                        [
                            .init(name: "calendar2 - fill", iconographyImage: iconographies.calendar.calendar2.fill),
                            .init(name: "calendar2 - outlined", iconographyImage: iconographies.calendar.calendar2.outlined)
                        ],

                        [
                            .init(name: "calendarValid - fill", iconographyImage: iconographies.calendar.calendarValid.fill),
                            .init(name: "calendarValid - outlined", iconographyImage: iconographies.calendar.calendarValid.outlined)
                        ]
                      ]),

                .init(name: "contact",
                      itemViewModels: [
                        [
                            .init(name: "voice - fill", iconographyImage: iconographies.contact.voice.fill),
                            .init(name: "voice - outlined", iconographyImage: iconographies.contact.voice.outlined)
                        ],

                        [
                            .init(name: "voiceOff - fill", iconographyImage: iconographies.contact.voiceOff.fill),
                            .init(name: "voiceOff - outlined", iconographyImage: iconographies.contact.voiceOff.outlined)
                        ],

                        [
                            .init(name: "mail - fill", iconographyImage: iconographies.contact.mail.fill),
                            .init(name: "mail - outlined", iconographyImage: iconographies.contact.mail.outlined)
                        ],

                        [
                            .init(name: "mailActif - fill", iconographyImage: iconographies.contact.mailActif.fill),
                            .init(name: "mailActif - outlined", iconographyImage: iconographies.contact.mailActif.outlined)
                        ],

                        [
                            .init(name: "typing - fill", iconographyImage: iconographies.contact.typing.fill),
                            .init(name: "typing - outlined", iconographyImage: iconographies.contact.typing.outlined)
                        ],

                        [
                            .init(name: "message - fill", iconographyImage: iconographies.contact.message.fill),
                            .init(name: "message - outlined", iconographyImage: iconographies.contact.message.outlined)
                        ],

                        [
                            .init(name: "conversation - fill", iconographyImage: iconographies.contact.conversation.fill),
                            .init(name: "conversation - outlined", iconographyImage: iconographies.contact.conversation.outlined)
                        ],

                        [
                            .init(name: "phone", iconographyImage: iconographies.contact.phone),
                            .init(name: "call", iconographyImage: iconographies.contact.call),
                            .init(name: "support", iconographyImage: iconographies.contact.support),
                            .init(name: "support2", iconographyImage: iconographies.contact.support2)
                        ]
                      ]),

                .init(name: "categories",
                      itemViewModels: [
                        [
                            .init(name: "apartment", iconographyImage: iconographies.categories.apartment),
                            .init(name: "vehicles", iconographyImage: iconographies.categories.vehicles),
                            .init(name: "couch", iconographyImage: iconographies.categories.couch),
                            .init(name: "equipment", iconographyImage: iconographies.categories.equipment),
                            .init(name: "hobby", iconographyImage: iconographies.categories.hobby),
                            .init(name: "ground", iconographyImage: iconographies.categories.ground),
                            .init(name: "holidays", iconographyImage: iconographies.categories.holidays),
                            .init(name: "land", iconographyImage: iconographies.categories.land),
                            .init(name: "clothes", iconographyImage: iconographies.categories.clothes),
                            .init(name: "dress", iconographyImage: iconographies.categories.dress),
                            .init(name: "baby", iconographyImage: iconographies.categories.baby),
                            .init(name: "multimedia", iconographyImage: iconographies.categories.multimedia),
                            .init(name: "parking", iconographyImage: iconographies.categories.parking),
                            .init(name: "house", iconographyImage: iconographies.categories.house),
                            .init(name: "service", iconographyImage: iconographies.categories.service),
                            .init(name: "job", iconographyImage: iconographies.categories.job),
                            .init(name: "pets", iconographyImage: iconographies.categories.pets),
                            .init(name: "computer", iconographyImage: iconographies.categories.computer)
                        ]
                      ]),

                .init(name: "flags",
                      itemViewModels: [
                        [
                            .init(name: "at", iconographyImage: iconographies.flags.at),
                            .init(name: "be", iconographyImage: iconographies.flags.be),
                            .init(name: "br", iconographyImage: iconographies.flags.br),
                            .init(name: "by", iconographyImage: iconographies.flags.by),
                            .init(name: "ch", iconographyImage: iconographies.flags.ch),
                            .init(name: "cl", iconographyImage: iconographies.flags.cl),
                            .init(name: "co", iconographyImage: iconographies.flags.co),
                            .init(name: "do", iconographyImage: iconographies.flags.do),
                            .init(name: "es", iconographyImage: iconographies.flags.es),
                            .init(name: "fi", iconographyImage: iconographies.flags.fi),
                            .init(name: "fr", iconographyImage: iconographies.flags.fr),
                            .init(name: "hu", iconographyImage: iconographies.flags.hu),
                            .init(name: "id", iconographyImage: iconographies.flags.id),
                            .init(name: "ie", iconographyImage: iconographies.flags.ie),
                            .init(name: "it", iconographyImage: iconographies.flags.it)
                        ]
                      ]),

                .init(name: "images",
                      itemViewModels: [
                        [
                            .init(name: "camera - fill", iconographyImage: iconographies.images.camera.fill),
                            .init(name: "camera - outlined", iconographyImage: iconographies.images.camera.outlined)
                        ],

                        [
                            .init(name: "addImage - fill", iconographyImage: iconographies.images.addImage.fill),
                            .init(name: "addImage - outlined", iconographyImage: iconographies.images.addImage.outlined)
                        ],

                        [
                            .init(name: "gallery - fill", iconographyImage: iconographies.images.gallery.fill),
                            .init(name: "gallery - outlined", iconographyImage: iconographies.images.gallery.outlined)
                        ],

                        [
                            .init(name: "add - fill", iconographyImage: iconographies.images.add.fill),
                            .init(name: "add - outlined", iconographyImage: iconographies.images.add.outlined)
                        ],

                        [
                            .init(name: "image - fill", iconographyImage: iconographies.images.image.fill),
                            .init(name: "image - outlined", iconographyImage: iconographies.images.image.outlined)
                        ],

                        [
                            .init(name: "noPhoto", iconographyImage: iconographies.images.noPhoto),
                            .init(name: "rotateImage", iconographyImage: iconographies.images.rotateImage)
                        ]
                      ]),

                .init(name: "alert",
                      itemViewModels: [
                        [
                            .init(name: "alert - fill", iconographyImage: iconographies.alert.alert.fill),
                            .init(name: "alert - outlined", iconographyImage: iconographies.alert.alert.outlined)
                        ],

                        [
                            .init(name: "question - fill", iconographyImage: iconographies.alert.question.fill),
                            .init(name: "question - outlined", iconographyImage: iconographies.alert.question.outlined)
                        ],

                        [
                            .init(name: "info - fill", iconographyImage: iconographies.alert.info.fill),
                            .init(name: "info - outlined", iconographyImage: iconographies.alert.info.outlined)
                        ],

                        [
                            .init(name: "warning - fill", iconographyImage: iconographies.alert.warning.fill),
                            .init(name: "warning - outlined", iconographyImage: iconographies.alert.warning.outlined)
                        ],

                        [
                            .init(name: "block", iconographyImage: iconographies.alert.block)
                        ]
                      ]),

                .init(name: "security",
                      itemViewModels: [
                        [
                            .init(name: "idea - fill", iconographyImage: iconographies.security.idea.fill),
                            .init(name: "idea - outlined", iconographyImage: iconographies.security.idea.outlined)
                        ],

                        [
                            .init(name: "lock - fill", iconographyImage: iconographies.security.lock.fill),
                            .init(name: "lock - outlined", iconographyImage: iconographies.security.lock.outlined)
                        ],

                        [
                            .init(name: "unlock - fill", iconographyImage: iconographies.security.unlock.fill),
                            .init(name: "unlock - outlined", iconographyImage: iconographies.security.unlock.outlined)
                        ]
                      ]),

                .init(name: "delivery",
                      itemViewModels: [
                        [
                            .init(name: "deliveryFast - fill", iconographyImage: iconographies.delivery.deliveryFast.fill),
                            .init(name: "deliveryFast - outlined", iconographyImage: iconographies.delivery.deliveryFast.outlined)
                        ],

                        [
                            .init(name: "deliveryHands - fill", iconographyImage: iconographies.delivery.deliveryHands.fill),
                            .init(name: "deliveryHands - outlined", iconographyImage: iconographies.delivery.deliveryHands.outlined)
                        ],

                        [
                            .init(name: "box - fill", iconographyImage: iconographies.delivery.box.fill),
                            .init(name: "box - outlined", iconographyImage: iconographies.delivery.box.outlined)
                        ],

                        [
                            .init(name: "deliveryTruck - fill", iconographyImage: iconographies.delivery.deliveryTruck.fill),
                            .init(name: "deliveryTruck - outlined", iconographyImage: iconographies.delivery.deliveryTruck.outlined)
                        ],

                        [
                            .init(name: "mailClose - fill", iconographyImage: iconographies.delivery.mailClose.fill),
                            .init(name: "mailClose - outlined", iconographyImage: iconographies.delivery.mailClose.outlined)
                        ],

                        [
                            .init(name: "mailOpen - fill", iconographyImage: iconographies.delivery.mailOpen.fill),
                            .init(name: "mailOpen - outlined", iconographyImage: iconographies.delivery.mailOpen.outlined)
                        ],

                        [
                            .init(name: "delivery - fill", iconographyImage: iconographies.delivery.delivery.fill),
                            .init(name: "delivery - outlined", iconographyImage: iconographies.delivery.delivery.outlined)
                        ],

                        [
                            .init(name: "mondialRelay", iconographyImage: iconographies.delivery.mondialRelay),
                            .init(name: "colissimo", iconographyImage: iconographies.delivery.colissimo),
                            .init(name: "shop2Shop", iconographyImage: iconographies.delivery.shop2Shop),
                            .init(name: "laposte", iconographyImage: iconographies.delivery.laposte)
                        ]
                      ]),

                .init(name: "map",
                      itemViewModels: [
                        [
                            .init(name: "threeSixty", iconographyImage: iconographies.map.threeSixty),
                            .init(name: "bike", iconographyImage: iconographies.map.bike),
                            .init(name: "allDirections", iconographyImage: iconographies.map.allDirections),
                            .init(name: "expand", iconographyImage: iconographies.map.expand)
                        ],

                        [
                            .init(name: "target - fill", iconographyImage: iconographies.map.target.fill),
                            .init(name: "target - outlined", iconographyImage: iconographies.map.target.outlined)
                        ],

                        [
                            .init(name: "pin - fill", iconographyImage: iconographies.map.pin.fill),
                            .init(name: "pin - outlined", iconographyImage: iconographies.map.pin.outlined)
                        ],

                        [
                            .init(name: "cursor - fill", iconographyImage: iconographies.map.cursor.fill),
                            .init(name: "cursor - outlined", iconographyImage: iconographies.map.cursor.outlined)
                        ],

                        [
                            .init(name: "train - fill", iconographyImage: iconographies.map.train.fill),
                            .init(name: "train - outlined", iconographyImage: iconographies.map.train.outlined)
                        ],

                        [
                            .init(name: "hotel - fill", iconographyImage: iconographies.map.hotel.fill),
                            .init(name: "hotel - outlined", iconographyImage: iconographies.map.hotel.outlined)
                        ],

                        [
                            .init(name: "walker - fill", iconographyImage: iconographies.map.walker.fill),
                            .init(name: "walker - outlined", iconographyImage: iconographies.map.walker.outlined)
                        ],

                        [
                            .init(name: "car - fill", iconographyImage: iconographies.map.car.fill),
                            .init(name: "car - outlined", iconographyImage: iconographies.map.car.outlined)
                        ]
                      ]),

                .init(name: "others",
                      itemViewModels: [
                        [
                            .init(name: "megaphone - fill", iconographyImage: iconographies.others.megaphone.fill),
                            .init(name: "megaphone - outlined", iconographyImage: iconographies.others.megaphone.outlined)
                        ],

                        [
                            .init(name: "speedmeter - fill", iconographyImage: iconographies.others.speedmeter.fill),
                            .init(name: "speedmeter - outlined", iconographyImage: iconographies.others.speedmeter.outlined)
                        ],

                        [
                            .init(name: "dissatisfied - fill", iconographyImage: iconographies.others.dissatisfied.fill),
                            .init(name: "dissatisfied - outlined", iconographyImage: iconographies.others.dissatisfied.outlined)
                        ],

                        [
                            .init(name: "flag - fill", iconographyImage: iconographies.others.flag.fill),
                            .init(name: "flag - outlined", iconographyImage: iconographies.others.flag.outlined)
                        ],

                        [
                            .init(name: "satisfied - fill", iconographyImage: iconographies.others.satisfied.fill),
                            .init(name: "satisfied - outlined", iconographyImage: iconographies.others.satisfied.outlined)
                        ],

                        [
                            .init(name: "neutral - fill", iconographyImage: iconographies.others.neutral.fill),
                            .init(name: "neutral - outlined", iconographyImage: iconographies.others.neutral.outlined)
                        ],

                        [
                            .init(name: "sad - fill", iconographyImage: iconographies.others.sad.fill),
                            .init(name: "sad - outlined", iconographyImage: iconographies.others.sad.outlined)
                        ],

                        [
                            .init(name: "fire - fill", iconographyImage: iconographies.others.fire.fill),
                            .init(name: "fire - outlined", iconographyImage: iconographies.others.fire.outlined)
                        ],

                        [
                            .init(name: "euro", iconographyImage: iconographies.others.euro),
                            .init(name: "refund", iconographyImage: iconographies.others.refund),
                            .init(name: "sun", iconographyImage: iconographies.others.sun)
                        ]
                      ]),

                .init(name: "notifications",
                      itemViewModels: [
                        [
                            .init(name: "alarmOn - fill", iconographyImage: iconographies.notifications.alarmOn.fill),
                            .init(name: "alarmOn - outlined", iconographyImage: iconographies.notifications.alarmOn.outlined)
                        ],

                        [
                            .init(name: "alarmOff - fill", iconographyImage: iconographies.notifications.alarmOff.fill),
                            .init(name: "alarmOff - outlined", iconographyImage: iconographies.notifications.alarmOff.outlined)
                        ],

                        [
                            .init(name: "alarm - fill", iconographyImage: iconographies.notifications.alarm.fill),
                            .init(name: "alarm - outlined", iconographyImage: iconographies.notifications.alarm.outlined)
                        ],

                        [
                            .init(name: "notification - fill", iconographyImage: iconographies.notifications.notification.fill),
                            .init(name: "notification - outlined", iconographyImage: iconographies.notifications.notification.outlined)
                        ],
                      ]),

                .init(name: "options",
                      itemViewModels: [
                        [
                            .init(name: "clock - fill", iconographyImage: iconographies.options.clock.fill),
                            .init(name: "clock - outlined", iconographyImage: iconographies.options.clock.outlined)
                        ],

                        [
                            .init(name: "flash - fill", iconographyImage: iconographies.options.flash.fill),
                            .init(name: "flash - outlined", iconographyImage: iconographies.options.flash.outlined)
                        ],

                        [
                            .init(name: "bookmark - fill", iconographyImage: iconographies.options.bookmark.fill),
                            .init(name: "bookmark - outlined", iconographyImage: iconographies.options.bookmark.outlined)
                        ],

                        [
                            .init(name: "star - fill", iconographyImage: iconographies.options.star.fill),
                            .init(name: "star - outlined", iconographyImage: iconographies.options.star.outlined)
                        ],

                        [
                            .init(name: "clockArrow - up", iconographyImage: iconographies.options.clockArrow.up),
                            .init(name: "clockArrow - down", iconographyImage: iconographies.options.clockArrow.down)
                        ],

                        [
                            .init(name: "moveUp", iconographyImage: iconographies.options.moveUp)
                        ]
                      ]),

                .init(name: "transaction",
                      itemViewModels: [
                        [
                            .init(name: "carWarranty - fill", iconographyImage: iconographies.transaction.carWarranty.fill),
                            .init(name: "carWarranty - outlined", iconographyImage: iconographies.transaction.carWarranty.outlined)
                        ],

                        [
                            .init(name: "piggyBank - fill", iconographyImage: iconographies.transaction.piggyBank.fill),
                            .init(name: "piggyBank - outlined", iconographyImage: iconographies.transaction.piggyBank.outlined)
                        ],

                        [
                            .init(name: "money - fill", iconographyImage: iconographies.transaction.money.fill),
                            .init(name: "money - outlined", iconographyImage: iconographies.transaction.money.outlined)
                        ]
                      ]),

                .init(name: "crm",
                      itemViewModels: [
                        [
                            .init(name: "wallet", iconographyImage: iconographies.crm.wallet),
                            .init(name: "card", iconographyImage: iconographies.crm.card)
                        ]
                      ]),

                .init(name: "pro",
                      itemViewModels: [
                        [
                            .init(name: "cursor - fill", iconographyImage: iconographies.pro.cursor.fill),
                            .init(name: "cursor - outlined", iconographyImage: iconographies.pro.cursor.outlined)
                        ],

                        [
                            .init(name: "download - fill", iconographyImage: iconographies.pro.download.fill),
                            .init(name: "download - outlined", iconographyImage: iconographies.pro.download.outlined)
                        ],

                        [
                            .init(name: "graph - fill", iconographyImage: iconographies.pro.graph.fill),
                            .init(name: "graph - outlined", iconographyImage: iconographies.pro.graph.outlined)
                        ],

                        [
                            .init(name: "rocket - fill", iconographyImage: iconographies.pro.rocket.fill),
                            .init(name: "rocket - outlined", iconographyImage: iconographies.pro.rocket.outlined)
                        ]
                      ]),

                .init(name: "share",
                      itemViewModels: [
                        [
                            .init(name: "import", iconographyImage: iconographies.share.import),
                            .init(name: "export", iconographyImage: iconographies.share.export)
                        ],

                        [
                            .init(name: "facebook - fill", iconographyImage: iconographies.share.facebook.fill),
                            .init(name: "facebook - outlined", iconographyImage: iconographies.share.facebook.outlined)
                        ],

                        [
                            .init(name: "twitter - fill", iconographyImage: iconographies.share.twitter.fill),
                            .init(name: "twitter - outlined", iconographyImage: iconographies.share.twitter.outlined)
                        ],

                        [
                            .init(name: "share - fill", iconographyImage: iconographies.share.share.fill),
                            .init(name: "share - outlined", iconographyImage: iconographies.share.share.outlined)
                        ],

                        [
                            .init(name: "attachFile", iconographyImage: iconographies.share.attachFile),
                            .init(name: "link", iconographyImage: iconographies.share.link)
                        ],

                        [
                            .init(name: "forward - fill", iconographyImage: iconographies.share.forward.fill),
                            .init(name: "forward - outlined", iconographyImage: iconographies.share.forward.outlined)
                        ],

                        [
                            .init(name: "instagram - fill", iconographyImage: iconographies.share.instagram.fill),
                            .init(name: "instagram - outlined", iconographyImage: iconographies.share.instagram.outlined)
                        ],

                        [
                            .init(name: "messenger", iconographyImage: iconographies.share.messenger),
                            .init(name: "pinterest", iconographyImage: iconographies.share.pinterest),
                            .init(name: "whastapp", iconographyImage: iconographies.share.whastapp),
                            .init(name: "expand", iconographyImage: iconographies.share.expand),
                            .init(name: "shareIOS", iconographyImage: iconographies.share.shareIOS)
                        ]
                      ]),

                .init(name: "toggle",
                      itemViewModels: [
                        [
                            .init(name: "valid - fill", iconographyImage: iconographies.toggle.valid.fill),
                            .init(name: "valid - outlined", iconographyImage: iconographies.toggle.valid.outlined)
                        ],

                        [
                            .init(name: "add - fill", iconographyImage: iconographies.toggle.add.fill),
                            .init(name: "add - outlined", iconographyImage: iconographies.toggle.add.outlined)
                        ],

                        [
                            .init(name: "remove - fill", iconographyImage: iconographies.toggle.remove.fill),
                            .init(name: "remove - outlined", iconographyImage: iconographies.toggle.remove.outlined)
                        ],

                        [
                            .init(name: "check", iconographyImage: iconographies.toggle.check),
                            .init(name: "doubleCheck", iconographyImage: iconographies.toggle.doubleCheck)
                        ]
                      ]),

                .init(name: "user",
                      itemViewModels: [
                        [
                            .init(name: "verified - fill", iconographyImage: iconographies.user.verified.fill),
                            .init(name: "verified - outlined", iconographyImage: iconographies.user.verified.outlined)
                        ],

                        [
                            .init(name: "warningSecurity - fill", iconographyImage: iconographies.user.warningSecurity.fill),
                            .init(name: "warningSecurity - outlined", iconographyImage: iconographies.user.warningSecurity.outlined)
                        ],

                        [
                            .init(name: "security - fill", iconographyImage: iconographies.user.security.fill),
                            .init(name: "security - outlined", iconographyImage: iconographies.user.security.outlined)
                        ],

                        [
                            .init(name: "profile - fill", iconographyImage: iconographies.user.profile.fill),
                            .init(name: "profile - outlined", iconographyImage: iconographies.user.profile.outlined)
                        ],

                        [
                            .init(name: "securityProfile - fill", iconographyImage: iconographies.user.securityProfile.fill),
                            .init(name: "securityProfile - outlined", iconographyImage: iconographies.user.securityProfile.outlined)
                        ],

                        [
                            .init(name: "userCheck - fill", iconographyImage: iconographies.user.userCheck.fill),
                            .init(name: "userCheck - outlined", iconographyImage: iconographies.user.userCheck.outlined)
                        ],

                        [
                            .init(name: "securityProfile2 - fill", iconographyImage: iconographies.user.securityProfile2.fill),
                            .init(name: "securityProfile2 - outlined", iconographyImage: iconographies.user.securityProfile2.outlined)
                        ],

                        [
                            .init(name: "account - fill", iconographyImage: iconographies.user.account.fill),
                            .init(name: "account - outlined", iconographyImage: iconographies.user.account.outlined)
                        ],
                        
                        [
                            .init(name: "pro - fill", iconographyImage: iconographies.user.pro.fill),
                            .init(name: "pro - outlined", iconographyImage: iconographies.user.pro.outlined)
                        ],

                        [
                            .init(name: "group - fill", iconographyImage: iconographies.user.group.fill),
                            .init(name: "group - outlined", iconographyImage: iconographies.user.group.outlined)
                        ]
                      ]),
        ]
    }
}
