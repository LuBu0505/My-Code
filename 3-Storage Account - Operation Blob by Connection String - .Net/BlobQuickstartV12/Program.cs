using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System;
using System.IO;
using System.Threading.Tasks;

namespace BlobQuickstartV12
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            Console.WriteLine("Azure Blob storage v12 - .NET quickstart sample\n");

            // Retrieve the connection string for use with the application. The storage
            // connection string is stored in an environment variable on the machine
            // running the application called AZURE_STORAGE_CONNECTION_STRING. If the
            // environment variable is created after the application is launched in a
            // console or with Visual Studio, the shell or application needs to be closed
            // and reloaded to take the environment variable into account.
            //string connectionString = "DefaultEndpointsProtocol=https;AccountName=<AccountKey>;AccountKey=<AccountKey>;EndpointSuffix=core.chinacloudapi.cn";
            string accountsas = "http://139.217.240.7/?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-11-20T15:49:08Z&st=2020-11-20T07:49:08Z&spr=https,http&sig=C0K9%2BmrnYSBTsCQUaRahx7fOwfmGTYhdQry9AxBYl%2FQ%3D";

            //string accountsas = "https://storageaccountapprg9ac8.blob.core.chinacloudapi.cn/?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-11-20T15:49:08Z&st=2020-11-20T07:49:08Z&spr=https,http&sig=C0K9%2BmrnYSBTsCQUaRahx7fOwfmGTYhdQry9AxBYl%2FQ%3D";
            Uri sasuri = new Uri(accountsas);
            // Create a BlobServiceClient object which will be used to create a container client
            BlobServiceClient blobServiceClient = new BlobServiceClient(sasuri, null);

            //Create a unique name for the container
            string containerName = "sdk";// "quickstartblobs" + Guid.NewGuid().ToString();

            // Create the container and return a container client object
            BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(containerName);
            containerClient.AccountName = "storageaccountapprg9ac8";
            var prp= containerClient.GetProperties();

            // Create a local file in the ./data/ directory for uploading and downloading
            string localPath = @"C:\LBWorkSpace\Stroage\blob-quickstart-v12\BlobQuickstartV12\data\";
            string fileName = "quickstart" + Guid.NewGuid().ToString() + ".txt";
            string localFilePath = Path.Combine(localPath, fileName);

            // Write text to the file
            await File.WriteAllTextAsync(localFilePath, "Hello, World! the message from .net");

            // Get a reference to a blob
            BlobClient blobClient = containerClient.GetBlobClient("/test/"+fileName);

            Console.WriteLine("Uploading to Blob storage as blob:\n\t {0}\n", blobClient.Uri);

            // Open the file and upload its data
            using FileStream uploadFileStream = File.OpenRead(localFilePath);
            await blobClient.UploadAsync(uploadFileStream, true);
            uploadFileStream.Close();

            Console.WriteLine("Listing blobs...");

            // List all blobs in the container
            await foreach (BlobItem blobItem in containerClient.GetBlobsAsync())
            {
                Console.WriteLine("\t" + blobItem.Name);
            }
            // Download the blob to a local file
            // Append the string "DOWNLOADED" before the .txt extension 
            // so you can compare the files in the data directory
            string downloadFilePath = localFilePath.Replace(".txt", "DOWNLOADED.txt");

            Console.WriteLine("\nDownloading blob to\n\t{0}\n", downloadFilePath);

            // Download the blob's contents and save it to a file
            BlobDownloadInfo download = await blobClient.DownloadAsync();

            using (FileStream downloadFileStream = File.OpenWrite(downloadFilePath))
            {
                await download.Content.CopyToAsync(downloadFileStream);
                downloadFileStream.Close();
            }
        }
    }
}
