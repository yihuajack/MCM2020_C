# encoding:utf-8
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import font_manager
from wordcloud import WordCloud
import numpy as np

file_path = 'hair_dryer_cleaned.txt'
hair_dryer = pd.read_table(file_path, sep='\t', header='infer', encoding='ISO-8859-1')

title_sub = hair_dryer[['product_title', 'star_rating', 'review_headline', 'review_body', 'review_date']]
hair_dryer = title_sub.dropna(axis=0, how='any',
                              subset=['product_title', 'star_rating', 'review_headline', 'review_body', 'review_date'])
cleanData = hair_dryer.drop_duplicates()
cleanData['review_date'] = pd.to_datetime(cleanData[cleanData.review_date.notnull()]['review_date'])
cleanData['star_rating'] = cleanData['star_rating'].astype('float')
cleanData = cleanData.iloc[::-1]
my_font = font_manager.FontProperties(fname='C:\WINDOWS\Fonts\simhei.ttf', size=10)
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
label_list = ["top5", "top5-top10", "others"]
top10_reviews = cleanData['product_title'].value_counts().head(10).sum()
top5_reviews = cleanData['product_title'].value_counts().head(5).sum()
all_reviews = cleanData['product_title'].value_counts().sum()
size = [top5_reviews, top10_reviews - top5_reviews, all_reviews - top10_reviews]
color = ['blue', 'green', 'red']
explode = [0.05, 0, 0]
patches, l_text, p_text = plt.pie(size,
                                  explode=explode,
                                  colors=color,
                                  labels=label_list,
                                  labeldistance=1.1,
                                  autopct="%1.1f%%",
                                  shadow=False,
                                  startangle=90,
                                  pctdistance=0.4)
for t in l_text:
    t.set_fontproperties(my_font)

plt.legend(prop=my_font)
plt.legend()
fig1 = plt.gcf()
plt.show()
fig1.savefig('Hair_Dryer_Review_Count_Distribution.png')
cleanData['product_title'].value_counts().head(10).sort_values().plot(kind='barh', figsize=(12, 6), grid=False)
plt.xlabel('review_count', fontproperties=my_font)
plt.ylabel('product_title', fontproperties=my_font)
plt.title('review_count_rank', fontproperties=my_font)
fig2 = plt.gcf()
plt.show()
fig2.savefig('Hair_Dryer_Review_Count_Ranking.png')
total = cleanData['review_date'].shape[0]
date_start = cleanData[cleanData.review_date.notnull()].iat[0, 1]
date_end = cleanData.iat[total - 1, 1]
review_day = date_end - date_start
review_month = review_day / 30
review_mean_month = cleanData['review_date'].value_counts().sum() / review_month
date = cleanData[cleanData.review_date.notnull()].set_index(['review_date'])
date['product_title'].resample('M', kind='period').count().plot(kind='line')
plt.ylabel('review_count', fontproperties=my_font)
plt.title('review_count_by_month', fontproperties=my_font)
fig3 = plt.gcf()
plt.show()
fig3.savefig('Hair_Dryer_Review_Count_by_Month.png')
reviews_great = str(cleanData['review_body'][cleanData['star_rating'] == 5])
greatcloud = WordCloud(width=1200, height=800).generate(reviews_great)
plt.imshow(greatcloud, interpolation='bilinear')
plt.axis('off')
fig4 = plt.gcf()
plt.show()
fig4.savefig('Hair_Dryer_Positive_WordCloud.png')
reviews_bad = str(cleanData['review_body'][cleanData['star_rating'] < 3])
badcloud = WordCloud(width=1200, height=800).generate(reviews_bad)
plt.imshow(badcloud, interpolation='bilinear')
plt.axis('off')
fig5 = plt.gcf()
plt.show()
fig5.savefig('Hair_Dryer_Negative_WordCloud.png')
mean_rating = cleanData.groupby('product_title')['star_rating'].mean()
rev_count = cleanData.groupby('product_title')['star_rating'].count()
low_rating = cleanData[cleanData['star_rating'] <= 2]['product_title'].value_counts()
high_rating = cleanData[cleanData['star_rating'] >= 4]['product_title'].value_counts()

rev_count_info = pd.DataFrame(
    {'rev_counts': rev_count, 'low_rating_counts': low_rating, 'high_rating_counts': high_rating},
    index=mean_rating.index)

rev_count_info.replace(np.nan, 0, inplace=True)
rev_count_info['count_per(%)'] = np.round(rev_count_info['rev_counts'] / np.sum(rev_count_info['rev_counts']) * 100, 2)
rev_count_info['high_rating(%)'] = np.round(rev_count_info['high_rating_counts'] / rev_count_info['rev_counts'] * 100, 2)
rev_count_info['low_rating(%)'] = np.round(rev_count_info['low_rating_counts'] / rev_count_info['rev_counts'] * 100, 2)
rev_count_info.sort_values(by='high_rating(%)', ascending=False)
rev_count_info[rev_count_info.rev_counts > 100].sort_values(by='high_rating(%)', ascending=False)
rev_count_info.to_excel('Hair_Dryer_Review_Analysis.xlsx')
