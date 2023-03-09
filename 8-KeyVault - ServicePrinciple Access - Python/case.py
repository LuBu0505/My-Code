
import os
import cmd
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

# print('AZURE_TENANT_ID:' +os.environ["AZURE_TENANT_ID"])
# print('AZURE_CLIENT_ID:' +os.environ["AZURE_CLIENT_ID"])
# print('AZURE_CLIENT_SECRET:' +os.environ["AZURE_CLIENT_SECRET"])

keyVaultName = 'lbsfkeyvalue01'
secretName = 'mysitecertfile'
KVUri = f"https://{keyVaultName}.vault.azure.cn"

print(KVUri)
credential = DefaultAzureCredential()
token = credential.get_token("https://vault.azure.cn/.default")
print(token)
client = SecretClient(vault_url=KVUri, credential=credential)

retrieved_secret = client.get_secret(secretName)

print(f"Your secret is '{retrieved_secret.value}'.")
print(f"Your secret properties not_before(nbf) is '{retrieved_secret.properties.not_before}'.")
print(f"Your secret properties expires_on is '{retrieved_secret.properties.expires_on}'.")
