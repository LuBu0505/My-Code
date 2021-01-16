package com.example.demo.resource

import com.example.demo.config.FeatureToggle
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import com.microsoft.azure.spring.cloud.feature.manager.FeatureManager

@RestController
@RequestMapping("/api")
class SampleResource {

    @Autowired
    private lateinit var featureManager: FeatureManager

    //FeatureFilter

    @GetMapping("/hello")
    fun hello():String{
        return "hello page."
    }

    @GetMapping("/boolTest")
    fun boolTest(): String {
        // use eg. insomnia to query localhost:8080/api/boolTest -> this will work
        if (featureManager.isEnabledAsync(FeatureToggle.BOOL_TOGGLE.key).block() == true) {
            return "feature enabled"
        }
        return "feature disabled"
    }

    @GetMapping("/abTest")
    fun abTest(): String {
        // use eg. insomnia to query localhost:8080/api/abTest -> this will fail
        /* {
              "timestamp": "2020-12-28T12:00:24.533+0000",
              "status": 500,
              "error": "Internal Server Error",
              "message": "Fail fast is set and a Filter was unable to be found: Microsoft.Targeting",
              "path": "/api/abTest"
            }

            failing at:
            package: com.microsoft.azure.spring.cloud.feature.manager.FeatureManager
            line 91: FeatureFilter featureFilter = (FeatureFilter) context.getBean(filter.getName());
        */
        if (featureManager.isEnabledAsync(FeatureToggle.AB_TOGGLE.key).block() == true) {
            return "feature A!"
        } else {
            return "feature B!"
        }
    }
}
