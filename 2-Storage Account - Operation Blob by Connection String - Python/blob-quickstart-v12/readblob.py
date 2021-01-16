import os, uuid
from azure.storage.blob import BlobServiceClient, BlobClient,  ContainerClient, __version__

try:
    print("Azure Blob storage v" + __version__ + " - Python quickstart sample")

    #connect_str = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
    local_path = "./data"
    local_file_name = "download" + str(uuid.uuid4()) + ".txt"

    connect_str ="DefaultEndpointsProtocol=https;AccountName=lbmltest011472179626;AccountKey=mYUg8y5Vq7AxefVqG0B8rxcJZEcxqYoM5ReQtqZU9sx9EoARu+QHS7qfFEFn+NGo4RWY2pXKi+3igyZClPzAsQ==;EndpointSuffix=core.chinacloudapi.cn"

    # Create the BlobServiceClient object which will be used to create a container client
    blob_service_client = BlobServiceClient.from_connection_string(connect_str)
    # Create a unique name for the container
    container_name = "test"
    # Create the container
    container_client = blob_service_client.get_container_client(container_name)
 
    print("\nListing blobs...")

    # List the blobs in the container
    blob_list = container_client.list_blobs()
    for blob in blob_list:
        print("\t " + blob.name + "\t"+ str(blob.last_modified))
        # output the blobl content 
        blob_client = container_client.get_blob_client(blob)
        print(blob_client.download_blob().readall())

        # # Download the blob to a local file
        download_file_path = os.path.join(local_path, str.replace(local_file_name ,'.txt', 'test.txt'))
        print("\nDownloading blob to \n\t" + download_file_path)
        with open(download_file_path, "wb") as download_file:
            download_file.write(blob_client.download_blob().readall())

except Exception as ex:
    print('Exception:')
    print(ex)