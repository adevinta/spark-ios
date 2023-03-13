//
//  SparkIconography.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore
import Foundation

struct SparkIconography: Iconography {

    // MARK: - Properties

    let account: IconographyAccount = IconographyAccountDefault(bank: FilledAndOutlined(),
                                                                holiday: FilledAndOutlined(),
                                                                country: FilledAndOutlined(),
                                                                home: FilledAndOutlined(),
                                                                identity: FilledAndOutlined(),
                                                                key: FilledAndOutlined(),
                                                                favorite: FilledAndOutlined(),
                                                                shoppingCart: FilledAndOutlined(),
                                                                store: FilledAndOutlined(),
                                                                cv: FilledAndOutlined(),
                                                                fileOff: FilledAndOutlined(),
                                                                work: FilledAndOutlined(),
                                                                card: FilledAndOutlined(),
                                                                offer: FilledAndOutlined(),
                                                                burgerMenu: IconographySparkImage.image1,
                                                                activity: IconographySparkImage.image1,
                                                                listing: IconographySparkImage.image1,
                                                                mobileCheck: IconographySparkImage.image1)
    let actions: IconographyActions = IconographyActionsDefault(calculate: FilledAndOutlined(),
                                                                copy: FilledAndOutlined(),
                                                                eye: FilledAndOutlined(),
                                                                eyeOff: FilledAndOutlined(),
                                                                like: FilledAndOutlined(),
                                                                moreMenu: VerticalAndHorizontal(),
                                                                pen: FilledAndOutlined(),
                                                                print: FilledAndOutlined(),
                                                                trash: FilledAndOutlined(),
                                                                trashClose: FilledAndOutlined(),
                                                                wheel: FilledAndOutlined(),
                                                                flashlight: FilledAndOutlined(),
                                                                pause: FilledAndOutlined(),
                                                                play: FilledAndOutlined(),
                                                                refresh: IconographySparkImage.image1,
                                                                search: IconographySparkImage.image1,
                                                                scan: IconographySparkImage.image1,
                                                                filter: IconographySparkImage.image1)
    let arrows: IconographyArrows = IconographyArrowsDefault(arrow: LeftAndRight(),
                                                             arrowDouble: LeftAndRight(),
                                                             arrowVertical: LeftAndRight(),
                                                             arrowHorizontal: UpAndDown(),
                                                             delete: FilledAndOutlined(),
                                                             graphArrow: UpAndDown(),
                                                             close: IconographySparkImage.image1,
                                                             plus: IconographySparkImage.image1)
    let calendar: IconographyCalendar = IconographyCalendarDefault(calendar: FilledAndOutlined(),
                                                                   calendar2: FilledAndOutlined(),
                                                                   calendarValid: FilledAndOutlined())
    let contact: IconographyContact = IconographyContactDefault(voice: FilledAndOutlined(),
                                                                voiceOff: FilledAndOutlined(),
                                                                mail: FilledAndOutlined(),
                                                                mailActif: FilledAndOutlined(),
                                                                typing: FilledAndOutlined(),
                                                                message: FilledAndOutlined(),
                                                                conversation: FilledAndOutlined(),
                                                                phone: IconographySparkImage.image1,
                                                                call: IconographySparkImage.image1,
                                                                support: IconographySparkImage.image1,
                                                                support2: IconographySparkImage.image1)
    let categories: IconographyCategories = IconographyCategoriesDefault(apartment: IconographySparkImage.image1,
                                                                         vehicles: IconographySparkImage.image1,
                                                                         couch: IconographySparkImage.image1,
                                                                         equipment: IconographySparkImage.image1,
                                                                         hobby: IconographySparkImage.image1,
                                                                         ground: IconographySparkImage.image1,
                                                                         holidays: IconographySparkImage.image1,
                                                                         land: IconographySparkImage.image1,
                                                                         clothes: IconographySparkImage.image1,
                                                                         dress: IconographySparkImage.image1,
                                                                         baby: IconographySparkImage.image1,
                                                                         multimedia: IconographySparkImage.image1,
                                                                         parking: IconographySparkImage.image1,
                                                                         house: IconographySparkImage.image1,
                                                                         service: IconographySparkImage.image1,
                                                                         job: IconographySparkImage.image1,
                                                                         pets: IconographySparkImage.image1,
                                                                         computer: IconographySparkImage.image1)
    let flags: IconographyFlags = IconographyFlagsDefault(at: IconographySparkImage.image1,
                                                          be: IconographySparkImage.image1,
                                                          br: IconographySparkImage.image1,
                                                          by: IconographySparkImage.image1,
                                                          ch: IconographySparkImage.image1,
                                                          cl: IconographySparkImage.image1,
                                                          co: IconographySparkImage.image1,
                                                          do: IconographySparkImage.image1,
                                                          es: IconographySparkImage.image1,
                                                          fi: IconographySparkImage.image1,
                                                          fr: IconographySparkImage.image1,
                                                          hu: IconographySparkImage.image1,
                                                          id: IconographySparkImage.image1,
                                                          ie: IconographySparkImage.image1,
                                                          it: IconographySparkImage.image1)
    let images: IconographyImages = IconographyImagesDefault(camera: FilledAndOutlined(),
                                                             addImage: FilledAndOutlined(),
                                                             gallery: FilledAndOutlined(),
                                                             add: FilledAndOutlined(),
                                                             image: FilledAndOutlined(),
                                                             noPhoto: IconographySparkImage.image1,
                                                             rotateImage: IconographySparkImage.image1)
    let alert: IconographyAlert = IconographyAlertDefault(alert: FilledAndOutlined(),
                                                          question: FilledAndOutlined(),
                                                          info: FilledAndOutlined(),
                                                          warning: FilledAndOutlined(),
                                                          block: IconographySparkImage.image1)
    let security: IconographySecurity = IconographySecurityDefault(idea: FilledAndOutlined(),
                                                                   lock: FilledAndOutlined(),
                                                                   unlock: FilledAndOutlined())
    let delivery: IconographyDelivery = IconographyDeliveryDefault(deliveryFast: FilledAndOutlined(),
                                                                   deliveryHands: FilledAndOutlined(),
                                                                   box: FilledAndOutlined(),
                                                                   deliveryTruck: FilledAndOutlined(),
                                                                   mailClose: FilledAndOutlined(),
                                                                   mailOpen: FilledAndOutlined(),
                                                                   delivery: FilledAndOutlined(),
                                                                   mondialRelay: IconographySparkImage.image1,
                                                                   colissimo: IconographySparkImage.image1,
                                                                   shop2Shop: IconographySparkImage.image1,
                                                                   laposte: IconographySparkImage.image1)
    let map: IconographyMap = IconographyMapDefault(threeSixty: IconographySparkImage.image1,
                                                    bike: IconographySparkImage.image1,
                                                    allDirections: IconographySparkImage.image1,
                                                    expand: IconographySparkImage.image1,
                                                    target: FilledAndOutlined(),
                                                    pin: FilledAndOutlined(),
                                                    cursor: FilledAndOutlined(),
                                                    train: FilledAndOutlined(),
                                                    hotel: FilledAndOutlined(),
                                                    walker: FilledAndOutlined(),
                                                    car: FilledAndOutlined())
    let others: IconographyOthers = IconographyOthersDefault(megaphone: FilledAndOutlined(),
                                                             speedmeter: FilledAndOutlined(),
                                                             dissatisfied: FilledAndOutlined(),
                                                             flag: FilledAndOutlined(),
                                                             satisfied: FilledAndOutlined(),
                                                             neutral: FilledAndOutlined(),
                                                             sad: FilledAndOutlined(),
                                                             fire: FilledAndOutlined(),
                                                             euro: IconographySparkImage.image1,
                                                             refund: IconographySparkImage.image1,
                                                             sun: IconographySparkImage.image1)
    let notifications: IconographyNotifications = IconographyNotificationsDefault(alarmOn: FilledAndOutlined(),
                                                                                  alarmOff: FilledAndOutlined(),
                                                                                  alarm: FilledAndOutlined(),
                                                                                  notification: FilledAndOutlined())
    let options: IconographyOptions = IconographyOptionsDefault(clock: FilledAndOutlined(),
                                                                flash: FilledAndOutlined(),
                                                                bookmark: FilledAndOutlined(),
                                                                star: FilledAndOutlined(),
                                                                clockArrow: UpAndDown(),
                                                                moveUp: IconographySparkImage.image1)
    let transaction: IconographyTransaction = IconographyTransactionDefault(carWarranty: FilledAndOutlined(),
                                                                            piggyBank: FilledAndOutlined(),
                                                                            money: FilledAndOutlined())
    let crm: IconographyCRM = IconographyCRMDefault(wallet: IconographySparkImage.image1,
                                                    card: IconographySparkImage.image1)
    let pro: IconographyPro = IconographyProDefault(cursor: FilledAndOutlined(),
                                                    download: FilledAndOutlined(),
                                                    graph: FilledAndOutlined(),
                                                    rocket: FilledAndOutlined())
    let share: IconographyShare = IconographyShareDefault(import: IconographySparkImage.image1,
                                                          export: IconographySparkImage.image1,
                                                          facebook: FilledAndOutlined(),
                                                          twitter: FilledAndOutlined(),
                                                          share: FilledAndOutlined(),
                                                          attachFile: IconographySparkImage.image1,
                                                          link: IconographySparkImage.image1,
                                                          forward: FilledAndOutlined(),
                                                          instagram: FilledAndOutlined(),
                                                          messenger: IconographySparkImage.image1,
                                                          pinterest: IconographySparkImage.image1,
                                                          whastapp: IconographySparkImage.image1,
                                                          expand: IconographySparkImage.image1,
                                                          shareIOS: IconographySparkImage.image1)
    let toggle: IconographyToggle = IconographyToggleDefault(valid: FilledAndOutlined(),
                                                             add: FilledAndOutlined(),
                                                             remove: FilledAndOutlined(),
                                                             check: IconographySparkImage.image1,
                                                             doubleCheck: IconographySparkImage.image1)
    let user: IconographyUser = IconographyUserDefault(verified: FilledAndOutlined(),
                                                       warningSecurity: FilledAndOutlined(),
                                                       security: FilledAndOutlined(),
                                                       profile: FilledAndOutlined(),
                                                       securityProfile: FilledAndOutlined(),
                                                       userCheck: FilledAndOutlined(),
                                                       securityProfile2: FilledAndOutlined(),
                                                       account: FilledAndOutlined(),
                                                       pro: FilledAndOutlined(),
                                                       group: FilledAndOutlined())
}

// MARK: - Style

private struct FilledAndOutlined: IconographyFilled & IconographyOutlined {

    // MARK: - Properties

    let filled: IconographyImage
    let outlined: IconographyImage

    // MARK: - Initialization

    init() {
        self.filled = IconographySparkImage.image1
        self.outlined = IconographySparkImage.image2
    }
}

private struct VerticalAndHorizontal: IconographyVertical & IconographyHorizontal {

    // MARK: - Properties

    let vertical: IconographyImage
    let horizontal: IconographyImage

    // MARK: - Initialization

    init() {
        self.vertical = IconographySparkImage.image1
        self.horizontal = IconographySparkImage.image2
    }
}

private struct LeftAndRight: IconographyLeft & IconographyRight {

    // MARK: - Properties

    let left: IconographyImage
    let right: IconographyImage

    // MARK: - Initialization

    init() {
        self.left = IconographySparkImage.image1
        self.right = IconographySparkImage.image2
    }
}

private struct UpAndDown: IconographyUp & IconographyDown {

    // MARK: - Properties

    let up: IconographyImage
    let down: IconographyImage

    // MARK: - Initialization

    init() {
        self.up = IconographySparkImage.image1
        self.down = IconographySparkImage.image2
    }
}

private enum IconographySparkImage {

    // MARK: - Subclass

    private class Class {}

    // MARK: - Properties

    private static let bundle = Bundle(for: Class.self)

    static let image1 = IconographyImageDefault(named: "1", in: Self.bundle)
    static let image2 = IconographyImageDefault(named: "2", in: Self.bundle)
}
