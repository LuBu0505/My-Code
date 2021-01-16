import os, uuid
import json

try:
    local_path = "."
    local_file_name = "All My Case.json"
    upload_file_path = os.path.join(local_path, local_file_name)

    with open(upload_file_path, "r") as data:   
        #print(data.read()) 
        y = json.loads(data.read())
        print(len(y))
        for c in y:
            print(c[0]+","+c[8]+","+c[36]+","+c[42])
        #container_client.upload_blob("\\"+files,data)

except Exception as ex:
    print('Exception:')
    print(ex)