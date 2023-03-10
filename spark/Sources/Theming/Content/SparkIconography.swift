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

    let account: IconographyAccount = IconographyAccountDefault(bank: FillAndOutlined(),
                                                                holiday: FillAndOutlined(),
                                                                home: FillAndOutlined(),
                                                                identity: FillAndOutlined(),
                                                                key: FillAndOutlined(),
                                                                favorite: FillAndOutlined(),
                                                                shoppingCart: FillAndOutlined(),
                                                                store: FillAndOutlined(),
                                                                cv: FillAndOutlined(),
                                                                fileOff: FillAndOutlined(),
                                                                work: FillAndOutlined(),
                                                                card: FillAndOutlined(),
                                                                offer: FillAndOutlined(),
                                                                burgerMenu: IconographySparkImage.image1,
                                                                activity: IconographySparkImage.image1,
                                                                listing: IconographySparkImage.image1,
                                                                mobileCheck: IconographySparkImage.image1)
    let actions: IconographyActions = IconographyActionsDefault(calculate: FillAndOutlined(),
                                                                copy: FillAndOutlined(),
                                                                eye: FillAndOutlined(),
                                                                eyeOff: FillAndOutlined(),
                                                                like: FillAndOutlined(),
                                                                moreMenu: VerticalAndHorizontal(),
                                                                pen: FillAndOutlined(),
                                                                print: FillAndOutlined(),
                                                                trash: FillAndOutlined(),
                                                                trashClose: FillAndOutlined(),
                                                                wheel: FillAndOutlined(),
                                                                flashlight: FillAndOutlined(),
                                                                pause: FillAndOutlined(),
                                                                play: FillAndOutlined(),
                                                                refresh: IconographySparkImage.image1,
                                                                search: IconographySparkImage.image1,
                                                                scan: IconographySparkImage.image1,
                                                                filter: IconographySparkImage.image1)
    let arrows: IconographyArrows = IconographyArrowsDefault(arrow: LeftAndRight(),
                                                             arrowDouble: LeftAndRight(),
                                                             arrowVertical: LeftAndRight(),
                                                             arrowHorizontal: UpAndDown(),
                                                             delete: FillAndOutlined(),
                                                             graphArrow: UpAndDown(),
                                                             close: IconographySparkImage.image1,
                                                             plus: IconographySparkImage.image1)
    let calendar: IconographyCalendar = IconographyCalendarDefault(calendar: FillAndOutlined(),
                                                                   calendar2: FillAndOutlined(),
                                                                   calendarValid: FillAndOutlined())
    let contact: IconographyContact = IconographyContactDefault(voice: FillAndOutlined(),
                                                                voiceOff: FillAndOutlined(),
                                                                mail: FillAndOutlined(),
                                                                mailActif: FillAndOutlined(),
                                                                typing: FillAndOutlined(),
                                                                message: FillAndOutlined(),
                                                                conversation: FillAndOutlined(),
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
    let images: IconographyImages = IconographyImagesDefault(camera: FillAndOutlined(),
                                                             addImage: FillAndOutlined(),
                                                             gallery: FillAndOutlined(),
                                                             add: FillAndOutlined(),
                                                             image: FillAndOutlined(),
                                                             noPhoto: IconographySparkImage.image1,
                                                             rotateImage: IconographySparkImage.image1)
    let alert: IconographyAlert = IconographyAlertDefault(alert: FillAndOutlined(),
                                                          question: FillAndOutlined(),
                                                          info: FillAndOutlined(),
                                                          warning: FillAndOutlined(),
                                                          block: IconographySparkImage.image1)
    let security: IconographySecurity = IconographySecurityDefault(idea: FillAndOutlined(),
                                                                   lock: FillAndOutlined(),
                                                                   unlock: FillAndOutlined())
    let delivery: IconographyDelivery = IconographyDeliveryDefault(deliveryFast: FillAndOutlined(),
                                                                   deliveryHands: FillAndOutlined(),
                                                                   box: FillAndOutlined(),
                                                                   deliveryTruck: FillAndOutlined(),
                                                                   mailClose: FillAndOutlined(),
                                                                   mailOpen: FillAndOutlined(),
                                                                   delivery: FillAndOutlined(),
                                                                   mondialRelay: IconographySparkImage.image1,
                                                                   colissimo: IconographySparkImage.image1,
                                                                   shop2Shop: IconographySparkImage.image1,
                                                                   laposte: IconographySparkImage.image1)
    let map: IconographyMap = IconographyMapDefault(threeSixty: IconographySparkImage.image1,
                                                    bike: IconographySparkImage.image1,
                                                    allDirections: IconographySparkImage.image1,
                                                    expand: IconographySparkImage.image1,
                                                    target: FillAndOutlined(),
                                                    pin: FillAndOutlined(),
                                                    cursor: FillAndOutlined(),
                                                    train: FillAndOutlined(),
                                                    hotel: FillAndOutlined(),
                                                    walker: FillAndOutlined(),
                                                    car: FillAndOutlined())
    let others: IconographyOthers = IconographyOthersDefault(megaphone: FillAndOutlined(),
                                                             speedmeter: FillAndOutlined(),
                                                             dissatisfied: FillAndOutlined(),
                                                             flag: FillAndOutlined(),
                                                             satisfied: FillAndOutlined(),
                                                             neutral: FillAndOutlined(),
                                                             sad: FillAndOutlined(),
                                                             fire: FillAndOutlined(),
                                                             euro: IconographySparkImage.image1,
                                                             refund: IconographySparkImage.image1,
                                                             sun: IconographySparkImage.image1)
    let options: IconographyOptions = IconographyOptionsDefault(clock: FillAndOutlined(),
                                                                flash: FillAndOutlined(),
                                                                bookmark: FillAndOutlined(),
                                                                star: FillAndOutlined(),
                                                                clockArrow: UpAndDown(),
                                                                moveUp: IconographySparkImage.image1)
    let transaction: IconographyTransaction = IconographyTransactionDefault(carWarranty: FillAndOutlined(),
                                                                            piggyBank: FillAndOutlined(),
                                                                            money: FillAndOutlined())
    let crm: IconographyCRM = IconographyCRMDefault(wallet: IconographySparkImage.image1,
                                                    card: IconographySparkImage.image1)
    let pro: IconographyPro = IconographyProDefault(cursor: FillAndOutlined(),
                                                    download: FillAndOutlined(),
                                                    graph: FillAndOutlined(),
                                                    rocket: FillAndOutlined())
    let share: IconographyShare = IconographyShareDefault(import: IconographySparkImage.image1,
                                                          export: IconographySparkImage.image1,
                                                          facebook: FillAndOutlined(),
                                                          twitter: FillAndOutlined(),
                                                          share: FillAndOutlined(),
                                                          attachFile: IconographySparkImage.image1,
                                                          link: IconographySparkImage.image1,
                                                          forward: FillAndOutlined(),
                                                          instagram: FillAndOutlined(),
                                                          messenger: IconographySparkImage.image1,
                                                          pinterest: IconographySparkImage.image1,
                                                          whastapp: IconographySparkImage.image1,
                                                          expand: IconographySparkImage.image1,
                                                          shareIOS: IconographySparkImage.image1)
    let toggle: IconographyToggle = IconographyToggleDefault(valid: FillAndOutlined(),
                                                             add: FillAndOutlined(),
                                                             remove: FillAndOutlined(),
                                                             check: IconographySparkImage.image1,
                                                             doubleCheck: IconographySparkImage.image1)
    let user: IconographyUser = IconographyUserDefault(verified: FillAndOutlined(),
                                                       warningSecurity: FillAndOutlined(),
                                                       security: FillAndOutlined(),
                                                       profile: FillAndOutlined(),
                                                       securityProfile: FillAndOutlined(),
                                                       userCheck: FillAndOutlined(),
                                                       account: FillAndOutlined(),
                                                       pro: FillAndOutlined(),
                                                       group: FillAndOutlined())
}

// MARK: - Style

private struct FillAndOutlined: IconographyFill & IconographyOutlined {

    // MARK: - Properties

    let fill: IconographyImage
    let outlined: IconographyImage

    // MARK: - Initialization

    init() {
        self.fill = IconographySparkImage.image1
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
