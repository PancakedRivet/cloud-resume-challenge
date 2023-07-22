@description('Specifies the location for resources.')
param location string = 'australiaeast'

@description('Definition for Azure Function API')
resource cloudresumeapiazfunc 'Microsoft.Web/sites@2022-09-01' = {
  name: 'cloud-resume-api-pdevene'
  kind: 'functionapp,linux'
  location: location
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/a4f8dfe4-7ffe-41ff-bd46-83ad60ab7f98/resourceGroups/cloudresumeapipdevene/providers/microsoft.insights/components/cloudresumeapipdevene'
    'hidden-link: /app-insights-instrumentation-key': '48fdc668-c750-49a8-af1d-adad7b781312'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=48fdc668-c750-49a8-af1d-adad7b781312;IngestionEndpoint=https://australiaeast-1.in.applicationinsights.azure.com/;LiveEndpoint=https://australiaeast.livediagnostics.monitor.azure.com/'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'cloud-resume-api-pdevene.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'cloud-resume-api-pdevene.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    reserved: true
    isXenon: false
    hyperV: false
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'PYTHON|3.10'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: '93293078A9F2690D0138E1EEB02AC03029D65D3BD0D95C44D6CB09F086A13856'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

@description('Definition for cloudResumeApiStorage')
resource cloudresumeapipdevene 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  name: 'cloudresumeapipdevene'
  location: location
  tags: {}
  properties: {
    defaultToOAuthAuthentication: true
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}


@description('Definition for Azure Fucntion App Service Plan')
resource ASPcloudresumeapipdevenee 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'ASP-cloud-resume-api-pdevene-4e77'
  kind: 'functionapp'
  location: location
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
}

@description('Definition for Cloud Resume Cosmos DB')
resource cloudresumepdevane 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: 'cloud-resume-pdevane'
  location: location
  kind: 'GlobalDocumentDB'
  tags: {
    defaultExperience: 'Azure Table'
    'hidden-cosmos-mmspecial': ''
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableAnalyticalStorage: false
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    enablePartitionMerge: false
    minimalTlsVersion: 'Tls12'
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 86400
      maxStalenessPrefix: 1000000
    }
    locations: [
      {
        locationName: 'Australia East'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: [
      {
        name: 'EnableTable'
      }
      {
        name: 'EnableServerless'
      }
    ]
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 8
        backupStorageRedundancy: 'Geo'
      }
    }
    networkAclBypassResourceIds: []
    capacity: {
      totalThroughputLimit: 4000
    }
  }
  identity: {
    type: 'None'
  }
}

@description('Definition for Application Insights Smart Detection')
resource ApplicationInsightsSmartDetection 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: 'Application Insights Smart Detection'
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

@description('Definition for Alert Detector Smart Rule')
resource FailureAnomaliescloudresumeapipdevene 'microsoft.alertsManagement/smartDetectorAlertRules@2021-04-01' = {
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      '/subscriptions/a4f8dfe4-7ffe-41ff-bd46-83ad60ab7f98/resourcegroups/cloud-resume/providers/microsoft.insights/components/cloudresumeapipdevene'
    ]
    actionGroups: {
      groupIds: [
        '/subscriptions/a4f8dfe4-7ffe-41ff-bd46-83ad60ab7f98/resourcegroups/cloudresumeapipdevene/providers/microsoft.insights/actiongroups/application insights smart detection'
      ]
    }
  }
  name: 'Failure Anomalies - cloudresumeapipdevene'
  location: 'global'
  tags: {}
}
