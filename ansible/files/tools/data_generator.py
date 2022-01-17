import random
import string
import requests
from time import sleep

while True:
    try:
        url = 'http://localhost'
        delay = float(random.randrange(1,10)/20)

        length = random.randint(0,20)
        result = ''.join(random.choice(string.ascii_letters + string.digits + string.punctuation) for i in range(length))
        print(result)

        rg = requests.get('{}/{}'.format(url,result))
        if rg.status_code == 200:
            print(rg.text)

        print("Request sent successfully")
        print(delay)
        sleep(delay)
    except:
        print("Failed")
        sleep(1)
