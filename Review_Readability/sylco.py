# encoding:utf-8
import re
import string


def getsentences(the_text):
    sents = re.findall(r"[A-Z].*?[.!?]", the_text, re.M | re.DOTALL)
    # sents_lo = re.findall(r"[a-z].*?[\.!?]", the_text)
    if not sents and the_text != '\n':
        sents = the_text
    return sents


def getwords(sentence):
    x = re.sub('[' + string.punctuation + ']', '', sentence).split()
    return x


def sylco(word):
    word = word.lower()

    # exception_add are words that need extra syllables
    # exception_del are words that need less syllables

    exception_add = ['serious', 'crucial']
    exception_del = ['fortunately', 'unfortunately']

    co_one = ['cool', 'coach', 'coat', 'coal', 'count', 'coin', 'coarse', 'coup', 'coif', 'cook', 'coign', 'coiffe',
              'coof', 'court']
    co_two = ['coapt', 'coed', 'coinci']

    pre_one = ['preach']

    syls = 0  # added syllable number
    disc = 0  # discarded syllable number

    # 1) if letters < 3 : return 1
    if len(word) <= 3:
        syls = 1
        return syls

    # 2) if doesn't end with "ted" or "tes" or "ses" or "ied" or "ies", discard "es" and "ed" at the end.
    # if it has only 1 vowel or 1 set of consecutive vowels, discard. (like "speed", "fled" etc.)

    if word[-2:] == "es" or word[-2:] == "ed":
        doubleAndtripple_1 = len(re.findall(r'[eaoui][eaoui]', word))
        if doubleAndtripple_1 > 1 or len(re.findall(r'[eaoui][^eaoui]', word)) > 1:
            if word[-3:] == "ted" or word[-3:] == "tes" or word[-3:] == "ses" or word[-3:] == "ied" or word[
                                                                                                       -3:] == "ies":
                pass
            else:
                disc += 1

    # 3) discard trailing "e", except where ending is "le"

    le_except = ['whole', 'mobile', 'pole', 'male', 'female', 'hale', 'pale', 'tale', 'sale', 'aisle', 'whale', 'while']

    if word[-1:] == "e":
        if word[-2:] == "le" and word not in le_except:
            pass

        else:
            disc += 1

    # 4) check if consecutive vowels exists, triplets or pairs, count them as one.

    doubleAndtripple = len(re.findall(r'[eaoui][eaoui]', word))
    tripple = len(re.findall(r'[eaoui][eaoui][eaoui]', word))
    disc += doubleAndtripple + tripple

    # 5) count remaining vowels in word.
    numVowels = len(re.findall(r'[eaoui]', word))

    # 6) add one if starts with "mc"
    if word[:2] == "mc":
        syls += 1

    # 7) add one if ends with "y" but is not surrouned by vowel
    if word[-1:] == "y" and word[-2] not in "aeoui":
        syls += 1

    # 8) add one if "y" is surrounded by non-vowels and is not in the last word.

    for i, j in enumerate(word):
        if j == "y":
            if (i != 0) and (i != len(word) - 1):
                if word[i - 1] not in "aeoui" and word[i + 1] not in "aeoui":
                    syls += 1

    # 9) if starts with "tri-" or "bi-" and is followed by a vowel, add one.

    if word[:3] == "tri" and word[3] in "aeoui":
        syls += 1

    if word[:2] == "bi" and word[2] in "aeoui":
        syls += 1

    # 10) if ends with "-ian", should be counted as two syllables, except for "-tian" and "-cian"

    if word[-3:] == "ian":
        # and (word[-4:] != "cian" or word[-4:] != "tian") :
        if word[-4:] == "cian" or word[-4:] == "tian":
            pass
        else:
            syls += 1

    # 11) if starts with "co-" and is followed by a vowel, check if exists in the double syllable dictionary, if not,
    # check if in single dictionary and act accordingly.

    if word[:2] == "co" and word[2] in 'eaoui':

        if word[:4] in co_two or word[:5] in co_two or word[:6] in co_two:
            syls += 1
        elif word[:4] in co_one or word[:5] in co_one or word[:6] in co_one:
            pass
        else:
            syls += 1

    # 12) if starts with "pre-" and is followed by a vowel, check if exists in the double syllable dictionary,
    # if not, check if in single dictionary and act accordingly.

    if word[:3] == "pre" and word[3] in 'eaoui':
        if word[:6] in pre_one:
            pass
        else:
            syls += 1

    # 13) check for "-n't" and cross match with dictionary to add syllable.

    negative = ["doesn't", "isn't", "shouldn't", "couldn't", "wouldn't"]

    if word[-3:] == "n't":
        if word in negative:
            syls += 1
        else:
            pass

            # 14) Handling the exceptional words.

    if word in exception_del:
        disc += 1

    if word in exception_add:
        syls += 1

        # calculate the output
    return numVowels - disc + syls


def getFlesch(article):
    sentencelist = getsentences(article)

    sentencesN = len(sentencelist)
    if sentencesN == 0:
        return -1

    syllablesN = 0
    wordsN = 0

    for sentence in sentencelist:
        wordslist = getwords(sentence)
        wordsN += len(wordslist)
        for word in wordslist:
            word = word.replace('\n', '')
            x = sylco(word)
            syllablesN += x
    """
    print("Sentences : %i" % sentencesN)
    print("Words : %i" % wordsN)
    print("Syllables : %i" % syllablesN)
    """
    if wordsN == 0:
        return -1
    
    asl = wordsN / sentencesN
    asw = syllablesN / wordsN

    # flesh = (0.39 * (wordsN / sentencesN)) + (11.8 * (syllablesN / wordsN)) - 15.59
    flesch = 206.835 - (1.015 * asl) - (84.6 * asw)
    # http://office.microsoft.com/en-us/word-help/test-your-document-s-readability-HP010148506.aspx

    return flesch


def getsyls(article):
    wordslist = getwords(article)

    syllables = 0

    for i in wordslist:
        x = sylco(i)
        syllables += x
        # print(i, x)

    # print("TOTAL : %i" % syllables)


def text_save(filename, data):
    file = open(filename, 'a')
    for i in range(len(data)):
        s = str(data[i]).replace('[', '').replace(']', '')
        s = s.replace("'", '').replace(',', '') + '\n'
        file.write(s)
    file.close()


file_path_h_in = 'D:\Documents\Sophomore\MCM_ICM_2020\hreview.txt'
with open(file_path_h_in, errors='ignore') as file_object:
    lines = file_object.readlines()

readability1 = []
for line in lines:
    line = line.strip('"')
    readability1.append(getFlesch(line))

text_save('Hair_Dryer_Review_Readability.txt', readability1)
file_path_m_in = 'D:\Documents\Sophomore\MCM_ICM_2020\mreview.txt'
with open(file_path_m_in, errors='ignore') as file_object:
    lines = file_object.readlines()

readability2 = []
for line in lines:
    line = line.strip('"')
    readability2.append(getFlesch(line))

text_save('Microwave_Review_Readability.txt', readability2)
file_path_p_in = 'D:\Documents\Sophomore\MCM_ICM_2020\preview.txt'
with open(file_path_p_in, errors='ignore') as file_object:
    lines = file_object.readlines()

readability3 = []
for line in lines:
    line = line.strip('"')
    readability3.append(getFlesch(line))

text_save('Pacifier_Review_Readability.txt', readability3)
