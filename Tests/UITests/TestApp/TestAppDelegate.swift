//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
@preconcurrency import FHIR
import HealthKitDataSource
@preconcurrency import HealthKit
import CardinalKitHealthKitToFHIRAdapter
import SwiftUI


class TestAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            if HKHealthStore.isHealthDataAvailable() {
                HealthKit {
                    CollectSample(HKQuantityType(.stepCount))
                    CollectSample(HKQuantityType.electrocardiogramType())
                    CollectSamples(Set(HKElectrocardiogram.correlatedSymptomTypes))
                } adapter: {
                    HealthKitToFHIRAdapter()
                }
            }
        }
    }
}