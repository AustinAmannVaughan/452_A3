import numpy as np
import math as sqrt
from collections import Counter
import csv
data = {'k':[[1,1],[2,3],[3,4]],'r':[[5,5],[6,7],[8,9]]}
new_features = [5,7]
obps=[]
obp_preds=[]
with open('Player_Data2016knn.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    obps = []
    for row in readCSV:
        if row ==1:
            print(row[2])
        else:
            obp = float(row[2])
            obps.append(obp)
with open('Yearly_obpKNN.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    obp_preds = []
    for row in readCSV:
        if row == 1:
            print(row[2])
        else:
            obp = float(row[2])
            obp_preds.append(obp)
def knn (data, prediction, k):
    distances = []
    for group in obps:
        for features in obps[group]:
            euclid = np.linalg.norm(np.array(features)-np.array(prediction))
            distances.append([euclid,group])
    votes = [i[1] for i in sorted(distances)[:k]]
    print(Counter(votes).most_common(1))
    vote_result = Counter(votes).most_common(1)[0][0]

    return vote_result

result = knn(obp,obps, k=3)
print(result)
