import requests

x = requests.get('https://docs.azure.cn/zh-cn/')

print(x.text)