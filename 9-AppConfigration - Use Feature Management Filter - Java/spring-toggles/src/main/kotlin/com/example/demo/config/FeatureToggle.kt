package com.example.demo.config

enum class FeatureToggle(val key: String) {
    // TODO: setup these keys in azure-application-configuration
    BOOL_TOGGLE("test.boolean"), // this is a standard boolean feature flag without a filter
    AB_TOGGLE("test.ab") // this is a feature flag using a 50% targeting filter
}
