---
layout: post
title:  "搭建jekyll博客"
category: sample
date:   2015-04-03 02:15:48
categories: jekyll update
---
jekyll是啥東東？？
===
* 免費的BLog生成工具
* 純靜態，無數據庫支持
* 支持markdown語法 提高逼格（[開始學習markdown語法][studymarkdown]）
* 開通`GitPages`，把你的`jekyll`（根目錄下所有文件））網站放上去託管，

GitHub Pages + Jekyll = Your blog!(快速搭建)
===

1. 先搞一個 [GitHub Pages][githubpages]，根據官網步驟來，請先登錄你的GitHub
	* 1.1 [創建一個倉庫][create a repository]
	* 1.2 clone 你創建好的倉庫 你可以使用命令行，或者GitHub終端
		*  在你的磁盤上創建一個文件夾(*mkdir myblog*)，放置你的項目,在這個目錄下執行下面操作
		* `~ $ git clone https://github.com/yanshinian/yanshinian.github.io`
		*  clone完，在myblog下有個*yanshinian.github.io*文件夾
	* 1.3 創建一個index.html文件，作為測試文件
		*  `~ $ cd yanshinian.github.io`
		*  `~ $ echo "Hello Word" > index.html` 
	* 1.4 上傳至遠程倉庫
		*  `~ $ git add --all`
		*  `~ $ git commit -m "隨便寫，想寫什麼些什麼"`
		*  `~ $ git push -u origin master`
	* 1.5 驗證你的成果，打開你的瀏覽器，打開的的GitPages地址*http://yanshinian.github.io*


2. 再搞個[Jekyll][jekyllrb]當Blog，英文不好看[Jekyll中文站][jekyllcn]
	
	```
	~ $ gem install jekyll
	~ $ jekyll new myblog
	~ $ cd myblog
	~/myblog $ jekyll serve
	# => Now browse to http://localhost:4000
	```


[studymarkdown]: http://sspai.com/25137
[githubpages]:https://pages.github.com/
[create a repository]:https://github.com/new
[jekyllrb]: http://jekyllrb.com
[jekyllcn]: http://jekyllcn.com/
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help






