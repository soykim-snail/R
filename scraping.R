text <- read_html("http://unico2013.dothome.co.kr/crawling/exercise_bs.html")
# View(text)

# <h1> 태그의 컨텐츠
dom.h1 <- html_nodes(text, "h1")
html_text(dom.h1)

# 텍스트 형식으로 내용을 가지고 있는 <a> 태그의 컨텐츠와 href 속성값
dom.a <- html_nodes(text, "a")
paste(html_text(dom.a), html_attr(dom.a, "href"), sep = " : ")

# <img> 태그의 src 속성값
dom.img <- html_nodes(text, "img")
html_attr(dom.img, "src")

# 첫 번째 <h2> 태그의 컨텐츠
dom.h2_1 <- html_nodes(text, "h2:nth-of-type(1)")
html_text(dom.h2_1)

# <ul> 태그의 자식 태그들 중 
# style 속성의 값이 green으로 끝나는 태그의 컨텐츠
dom.ul <- html_nodes(text, "ul > *")
list.color <- html_attr(dom.ul, "style")
dom.green <- dom.ul[substr(list.color, start=7, stop = 10000) == "green"]
html_text(dom.green)

# 두 번째 <h2> 태그의 컨텐츠
html_text(html_nodes(text, "h2:nth-of-type(2)"))

# <ol> 태그의 모든 자식 태그들의 컨텐츠 
html_text(html_nodes(text, "ol > *"))

# <table> 태그의 모든 자손 태그들의 컨텐츠 
html_text(html_nodes(text, "table  *"))

# name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
html_text(html_nodes(text, "tr.name"))

# target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
html_text(html_nodes(text, "#target"))
