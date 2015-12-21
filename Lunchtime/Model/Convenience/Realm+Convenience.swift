//
//  Realm+Convenience.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-12-20.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import Realm

extension RLMRealm {
    static func addRestaurantToSavedArray(restaurant: Restaurant) {
        RLMRealm.defaultRealm().beginWriteTransaction()
        User(forPrimaryKey: NSNumber(integer: 1))?.savedRestaurants.addObject(restaurant)

        do { try RLMRealm.defaultRealm().commitWriteTransaction() } catch {
            print("Something went wrong...")
        }
    }

    static func addRestaurantToBlacklistedArray(restaurant: Restaurant) {
        RLMRealm.defaultRealm().beginWriteTransaction()
        User(forPrimaryKey: NSNumber(integer: 1))?.blacklistedRestaurants.addObject(restaurant)

        do { try RLMRealm.defaultRealm().commitWriteTransaction() } catch {
            print("Something went wrong...")
        }
    }

    static func removeRestaurantFromSavedArrayAtIndex(index: UInt) {
        RLMRealm.defaultRealm().beginWriteTransaction()
        User(forPrimaryKey: NSNumber(integer: 1))?.savedRestaurants.removeObjectAtIndex(index)

        do { try RLMRealm.defaultRealm().commitWriteTransaction() } catch {
            print("Something went wrong...")
        }
    }

    static func removeRestaurantFromBlacklistedArrayAtIndex(index: UInt) {
        RLMRealm.defaultRealm().beginWriteTransaction()
        User(forPrimaryKey: NSNumber(integer: 1))?.blacklistedRestaurants.removeObjectAtIndex(index)

        do { try RLMRealm.defaultRealm().commitWriteTransaction() } catch {
            print("Something went wrong...")
        }
    }
}
