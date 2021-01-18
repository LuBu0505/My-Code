import os, uuid
from azure.storage.blob import BlobServiceClient, BlobClient,  ContainerClient, __version__

try:
    print("Azure Blob storage v" + __version__ + " - Python quickstart sample")
    # Quick start code goes here
    # Retrieve the connection string for use with the application. The storage
    # connection string is stored in an environment variable on the machine
    # running the application called AZURE_STORAGE_CONNECTION_STRING. If the environment variable is
    # created after the application is launched in a console or with Visual Studio,
    # the shell or application needs to be closed and reloaded to take the
    # environment variable into account.
    #connect_str = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
    connect_str ="DefaultEndpointsProtocol=https;AccountName=xxxxx;AccountKey=xxxxxxxxx;EndpointSuffix=core.chinacloudapi.cn"
    print(connect_str)
    # Create the BlobServiceClient object which will be used to create a container client
    blob_service_client = BlobServiceClient.from_connection_string(connect_str)

    # Create a unique name for the container
    container_name = "quickstart" + str(uuid.uuid4())

    # Create the container
    container_client = blob_service_client.create_container(container_name)

    # Create a file in local data directory to upload and download
    local_path = "./data"
    local_file_name = "quickstart" + str(uuid.uuid4()) + ".txt"
    upload_file_path = os.path.join(local_path, local_file_name)

    for files in os.listdir(local_path):
        with open(os.path.join(local_path,files), "rb") as data:   
            print(files) 
            container_client.upload_blob("\\"+files,data)



    # # Write text to the file
    # file = open(upload_file_path, 'w')
    # file.write("Hello, World!")
    # file.close()
    # for i in range(1000):
    #     # Create a blob client using the local file name as the name for the blob
    #     blob_client = blob_service_client.get_blob_client(container=container_name, blob=local_file_name + str(i))
    #     #blob_client = blob_service_client.get_blob_client(container=container_name)

    #     print("\nUploading to Azure Storage as blob:\n\t" + local_file_name)

    #     # Upload the created file
    #     with open(upload_file_path, "rb") as data:
    #         blob_client.upload_blob(data)

    print("\nListing blobs...")

    # List the blobs in the container
    blob_list = container_client.list_blobs()
    for blob in blob_list:
        print("\t Delete " + blob.name + "\t"+ str(blob.last_modified))
        container_client.delete_blob(blob)

    # Download the blob to a local file
    # Add 'DOWNLOAD' before the .txt extension so you can see both files in the data directory
    download_file_path = os.path.join(local_path, str.replace(local_file_name ,'.txt', 'DOWNLOAD.txt'))
    print("\nDownloading blob to \n\t" + download_file_path)

    with open(download_file_path, "wb") as download_file:
        download_file.write(blob_client.download_blob().readall())

except Exception as ex:
    print('Exception:')
    print(ex)
