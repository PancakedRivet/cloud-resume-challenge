@description('Specifies the location for resources.')
param location string = 'australiaeast'

@description('Specifies the name for the storage account.')
param storageName string = 'staticwebsitepdevane'

@description('Specifies the URL for the endpoint.')
// param endpointUrl string = 'staticwebsitepdevane.z8.web.core.windows.net'
param endpointUrl string = '${storageName}.z8.web.${environment().suffixes.storage}'

@description('Definition for static website storage')
resource staticwebsitepdevane 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  sku: {
    name: 'Standard_RAGRS'
  }
  kind: 'StorageV2'
  name: storageName
  location: location
  tags: {}
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
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
    accessTier: 'Hot'
  }
}

@description('Definition for the FrontDoor and CDN')
resource cloudResumeCdn 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: 'patrick-devane'
  location: 'Global'
  tags: {}
  sku: {
    name: 'Standard_Microsoft'
  }
  properties: {}
}

@description('Definition for the Endpoint')
resource cloudResumeEndpoint 'Microsoft.Cdn/profiles/endpoints@2023-05-01' = {
  parent: cloudResumeCdn
  name: 'patrickdevane'
  location: 'Global'
  tags: {}
  properties: {
    originHostHeader: endpointUrl
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
    isCompressionEnabled: true
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    origins: [
      {
        name: 'staticwebsitepdevane-z8-web-core-windows-net'
        properties: {
          hostName: endpointUrl
          httpPort: 80
          httpsPort: 443
          originHostHeader: endpointUrl
          priority: 1
          weight: 1000
          enabled: true
        }
      }
    ]
    originGroups: []
    geoFilters: []
    deliveryPolicy: {
      description: ''
      rules: [
        {
          name: 'HTTPSRedirect'
          order: 1
          conditions: [
            {
              name: 'RequestScheme'
              parameters: {
                typeName: 'DeliveryRuleRequestSchemeConditionParameters'
                matchValues: [
                  'HTTP'
                ]
                operator: 'Equal'
                negateCondition: false
                transforms: []
              }
            }
          ]
          actions: [
            {
              name: 'UrlRedirect'
              parameters: {
                typeName: 'DeliveryRuleUrlRedirectActionParameters'
                redirectType: 'Found'
                destinationProtocol: 'Https'
              }
            }
          ]
        }
      ]
    }
  }
}
