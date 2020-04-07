# 정규표현식 사용
word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"

# 단순표현
gsub(" ", "@", word)
sub(" ", "@", word) # sub는 한번만 수행
gsub("A", "", word) 
gsub("a", "", word) 
gsub("Aa", "", word)


#정규표현

# quantifiers
gsub("(Aa)", "", word) # 여기선 의미없는 괄호
gsub("(Aa){2}", "", word) # {n} : matches exactly n times
gsub("(Aa){2,4}", "", word) # {n,m} : matches between n and m times
gsub("Aa{2}", "", word) # 괄호 있어야 그루핑
# * : matches at least 0 times
# + : matches at least 1 times
# ? : matchest at most 1 times

# or
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) # ^ : not
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) # punctuation characters (특수기호)
gsub("[[:alnum:]]", "", word) # alpha numeric (영문, 한글, 숫자)
gsub("[1234567890]", "", word) 
gsub("[0-9]", "", word) 
gsub("\\d", "", word) # digit (숫자)
gsub("\\D", "", word) # non-digit (숫자가 아닌)
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word) # 스페이스, 탭, 뉴라인, 첫째열로....
