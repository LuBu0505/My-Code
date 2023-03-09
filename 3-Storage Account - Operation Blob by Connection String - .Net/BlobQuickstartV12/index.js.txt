// index.js
const { BlobServiceClient } = require("@azure/storage-blob");
// Now do something interesting with BlobServiceClient

const createContainerButton = document.getElementById("create-container-button");
const deleteContainerButton = document.getElementById("delete-container-button");
const selectButton = document.getElementById("select-button");
const fileInput = document.getElementById("file-input");
const listButton = document.getElementById("list-button");
const deleteButton = document.getElementById("delete-button");
const status = document.getElementById("status");
const fileList = document.getElementById("file-list");

const reportStatus = message => {
    status.innerHTML += `${message}<br/>`;
    status.scrollTop = status.scrollHeight;
}

// Update <placeholder> with your Blob service SAS URL string
//const blobSasUrl = "https://storageaccountapprg9ac8.blob.core.chinacloudapi.cn/?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-11-20T15:49:08Z&st=2020-11-20T07:49:08Z&spr=https,http&sig=C0K9%2BmrnYSBTsCQUaRahx7fOwfmGTYhdQry9AxBYl%2FQ%3D";
const blobSasUrl = "http://139.217.240.7/?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-11-20T15:49:08Z&st=2020-11-20T07:49:08Z&spr=https,http&sig=C0K9%2BmrnYSBTsCQUaRahx7fOwfmGTYhdQry9AxBYl%2FQ%3D";

// Create a new BlobServiceClient
const blobServiceClient = new BlobServiceClient(blobSasUrl);

// Create a unique name for the container by 
// appending the current time to the file name
const containerName ="container1605863491240";// "container" + new Date().getTime();

// Get a container client from the BlobServiceClient
const containerClient = blobServiceClient.getContainerClient(containerName);

const createContainer = async () => {
    try {
        reportStatus(`Creating container "${containerName}"...`);
        await containerClient.create();
        reportStatus(`Done.`);
    } catch (error) {
        reportStatus(error.message);
    }
};

const deleteContainer = async () => {
    try {
        reportStatus(`Deleting container "${containerName}"...`);
        await containerClient.delete();
        reportStatus(`Done.`);
    } catch (error) {
        reportStatus(error.message);
    }
};

createContainerButton.addEventListener("click", createContainer);
deleteContainerButton.addEventListener("click", deleteContainer);

const listFiles = async () => {
    fileList.size = 0;
    fileList.innerHTML = "";
    try {
        reportStatus("Retrieving file list...");
        let iter = containerClient.listBlobsFlat();
        let blobItem = await iter.next();
        while (!blobItem.done) {
            fileList.size += 1;
            fileList.innerHTML += `<option>${blobItem.value.name}</option>`;
            blobItem = await iter.next();
        }
        if (fileList.size > 0) {
            reportStatus("Done.");
        } else {
            reportStatus("The container does not contain any files.");
        }
    } catch (error) {
        reportStatus(error.message);
    }
};

listButton.addEventListener("click", listFiles);



const uploadFiles = async () => {
    try {
        reportStatus("Uploading files...");
        const promises = [];
        for (const file of fileInput.files) {
            const blockBlobClient = containerClient.getBlockBlobClient(file.name);
            promises.push(blockBlobClient.uploadBrowserData(file));
        }
        await Promise.all(promises);
        reportStatus("Done.");
        listFiles();
    }
    catch (error) {
            reportStatus(error.message);
    }
}

selectButton.addEventListener("click", () => fileInput.click());
fileInput.addEventListener("change", uploadFiles);

const deleteFiles = async () => {
    try {
        if (fileList.selectedOptions.length > 0) {
            reportStatus("Deleting files...");
            for (const option of fileList.selectedOptions) {
                await containerClient.deleteBlob(option.text);
            }
            reportStatus("Done.");
            listFiles();
        } else {
            reportStatus("No files selected.");
        }
    } catch (error) {
        reportStatus(error.message);
    }
};

deleteButton.addEventListener("click", deleteFiles);

