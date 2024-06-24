package com.example.demo

import com.example.demo.config.AzureConfig
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.EnableConfigurationProperties
import com.microsoft.azure.spring.cloud.feature.manager.FeatureManager
import org.springframework.boot.runApplication

@SpringBootApplication
@EnableConfigurationProperties(AzureConfig::class)
class DemoApplication

fun main(args: Array<String>) {
	runApplication<DemoApplication>(*args)
}
