import pymongo


#client = pymongo.MongoClient("mongodb+srv://ineuron:ineuron1@cluster0.goi2j.mongodb.net/?retryWrites=true&w=majority")
#db = client.test

client = pymongo.MongoClient("mongodb+srv://cssumit1:admin@<password>.raxmhn5.mongodb.net/?retryWrites=true&w=majority")
db = client.test

data = {
    "name" : "Sumit",
    "mail_id" : "sumit@ineuron.ai",
    "subject" : ["data science", "big data " , "data analytics "]
}

database =  client['myinfo']
collections = database["Sumit"]
#collections.insert_one(data)

list_of_records = [
    {'companyName': 'iNeuron',
     'product': 'Affordable AI',
     'courseOffered': 'Machine Learning with Deployment'},

    {'companyName': 'iNeuron',
     'product': 'Affordable AI',
     'courseOffered': 'Deep Learning for NLP and Computer vision'},

    {'companyName': 'iNeuron',
     'product': 'Master Program',
     'courseOffered': 'Data Science Masters Program'}
]


database =  client['myinfo']
collections = database["Sumit"]
collections.insert_many(list_of_records)