targetScope = 'resourceGroup'

var baseName = 'st${uniqueString(resourceGroup().id)}'
var storageAccountName = toLower(baseName)

resource demoStorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
