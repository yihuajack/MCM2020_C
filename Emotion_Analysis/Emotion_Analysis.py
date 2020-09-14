# encoding:utf-8
from textblob import TextBlob


def text_save(filename, data):
    file = open(filename, 'a')
    for i in range(len(data)):
        s = str(data[i]).replace('[', '').replace(']', '')
        s = s.replace("'", '').replace(',', '') + '\n'
        file.write(s)
    file.close()


file_path_h = 'D:\Documents\Sophomore\MCM_ICM_2020\hreview.txt'
with open(file_path_h, errors='ignore') as file_object:
    lines = file_object.readlines()

blob1 = []
sent1 = []
i = 0
for line in lines:
    line = line.strip('"')
    blob1 = TextBlob(line)
    sent1.append([])
    sent1[i].append(blob1.sentiment.polarity)
    sent1[i].append(blob1.sentiment.subjectivity)
    i += 1

text_save('Hair_Dryer_Emotion_Analysis.txt', sent1)
file_path_m = 'D:\Documents\Sophomore\MCM_ICM_2020\mreview.txt'
with open(file_path_m, errors='ignore') as file_object:
    lines = file_object.readlines()

blob2 = []
sent2 = []
i = 0
for line in lines:
    line = line.strip('"')
    blob2 = TextBlob(line)
    sent2.append([])
    sent2[i].append(blob2.sentiment.polarity)
    sent2[i].append(blob2.sentiment.subjectivity)
    i += 1

text_save('Microwave_Emotion_Analysis.txt', sent2)
file_path_p = 'D:\Documents\Sophomore\MCM_ICM_2020\preview.txt'
with open(file_path_p, errors='ignore') as file_object:
    lines = file_object.readlines()

blob3 = []
sent3 = []
i = 0
for line in lines:
    line = line.strip('"')
    blob3 = TextBlob(line)
    sent3.append([])
    sent3[i].append(blob3.sentiment.polarity)
    sent3[i].append(blob3.sentiment.subjectivity)
    i += 1

text_save('Pacifier_Emotion_Analysis.txt', sent3)
