
# Introduction
Follow this Microsoft

- [Functions Core Development](https://learn.microsoft.com/en-us/azure/azure-functions/functions-develop-local)
- [NodeJS Developer](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-node?tabs=windows-setting-the-node-version&pivots=nodejs-model-v3)
- [NodeJS Developer local](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v3%2Cmacos%2Ccsharp%2Cportal%2Cbash)

guides for local function app development.

## Configuration

```bash
# Create project
func init azure-cosmos-nodejs-client-project --worker-runtime node --language javascript

# Create function
cd azure-cosmos-nodejs-client-project
func new --name "cosmos-db-client-trigger" --template "HTTP Trigger"
# choose option: 3. node
# choose option: 1. javascript

# Install dependencies
npm install
# Verify runtime
func start

# Configure Azure runtime
func azure functionapp fetch-app-settings func-private-dns-westeu
func azure storage fetch-connection-string <StorageAccountName>

# Publish function
func azure functionapp publish func-private-dns-westeu
```