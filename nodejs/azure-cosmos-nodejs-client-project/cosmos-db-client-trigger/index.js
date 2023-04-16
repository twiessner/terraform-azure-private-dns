const { CosmosClient } = require("@azure/cosmos");

module.exports = async function (context, req) {
    context.log("Trigger function azure-cosmos-db-http-trigger...");

    const hostName = process.env["COSMOS_DB_HOST_NAME"];
    const endpoint = "https://" + hostName + ":443/"
    context.log("Using Cosmos endpoint '" + endpoint + "'...");

    const masterKey = process.env["COSMOS_DB_KEY"];
    const client = new CosmosClient({ endpoint, key: masterKey });
    context.log("Cosmos Client created...");

    const databaseName = process.env["COSMOS_DB_NAME"];
    const { database } = await client.databases.createIfNotExists({ id: databaseName });

    context.res = {
        body: "Database connected..."
    };

    context.done();
}