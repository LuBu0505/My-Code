package com.example.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration

@Configuration
@ConfigurationProperties(prefix = "config")
class AzureConfig
