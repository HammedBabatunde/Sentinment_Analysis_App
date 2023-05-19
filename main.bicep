@description('Name of the sentinment analaysis Container App')
param ContainerAppName string = 'sentimentanalysis001'

@description('Name of the sentinment analaysis Container App Plan')
param containerAppPlanName string = 'sentimentanalysis001-plan'

@description('Location of the resource group')
param location string = resourceGroup().location

@description('Docker Registry Url')
param dockerRegistryUrl string = 'sentinmentanalysis001.azurecr.io'

@description('Docker Registry Username')
param dockerRegistryUsername string = 'sentinmentanalysis001'

@description('Docker Registry Password')
param dockerRegistryPassword string = 'evQw6xgMi7nbev5k6O7kwc3i7QwzVct35k6lGrNfbU+ACRB27HfS'

resource servicePlan 'Microsoft.Web/serverfarms@2016-09-01' = {
  kind: 'linux'
  name: containerAppPlanName
  location: location
  properties: {
    name: containerAppPlanName
    reserved: true
  }
  sku: {
    name: 'P1v3'
  }
  dependsOn: []
}

resource siteName_resource 'Microsoft.Web/sites@2016-08-01' = {
  name: ContainerAppName
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryPassword
        }
      ]
      linuxFxVersion: 'DOCKER'
    }
    serverFarmId: servicePlan.id
  }
}
