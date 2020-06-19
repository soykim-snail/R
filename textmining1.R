# 제시된 memo.txt 파일을 행 단위로 읽어서 벡터를 리턴한다.
# 벡터를 구성하고 있는 각 원소들의 내용을 확인한 후에 
# 아래에 제시된 결과로 변경되도록 문자 또는 문자열 변경을 시도한다. (gsub() 사용)
# 원소마다 변경해야 하는 룰이 다르므로 원소마다 처리한다.
# 처리된 결과를 memo_new.txt 파일에 저장한다. (write() 함수 사용)
# 구현소스는 textmining1.R 로 저장하여 생성된 memo_new.txt 파일로 함께 제출한다.
# 
# 
# 당신의 믿음은 곧 당신의 생각이 되고, 당신의 생각은 곧 당신이 내뱉는 말이 되고, 당신이 내뱉는 말은 곧 당신의 행동이 되고, 당신의 행동은 곧 당신의 습관이 되고, 당신의 습관은 곧 당신의 가치관이 되고, 당신의 가치관은 곧 당신의 운명이 된다.
# 중요한 일을 절대 E메일로 보내지 마라!
#   가장 훌륭한 일은 모험과 도전정신으로 이루어진다.
# 남들이 나와 같지 않다는 점을 인정하라.
# 매일 아침 삶의 목표를 생각하며 일어나라.
# 위대한일을하는유일한방법은바로당신이하는일을사랑하는것입니다.
# you 타협(정착)하지 마세요. 왜냐하면, 당신의 마음이 하는 모든 것이 그렇듯이, 그 일을 찾게 되면 당신은 마음으로 알게 될 겁니다. ok?


 
data <- readLines("data/memo.txt", encoding = 'UTF-8')
cleaned_data <- NULL
(cleaned_data[1] <- gsub("[[:punct:]]", "", data[1]))
(cleaned_data[2] <- gsubfn("e", "E", data[2]))
(cleaned_data[3] <- gsub("[[:digit:]]", "", data[3]))
(cleaned_data[4] <- gsub("([a-z]|[A-Z])", "", data[4]))
(cleaned_data[4] <- gsub("( )+", " ", cleaned_data[4]))
(cleaned_data[5] <- gsub("[[:digit:][:punct:]]", "", data[5]))
(cleaned_data[6] <- gsub("[[:space:]]", "", data[6]))
(cleaned_data[7] <- tolower(data[7]))

if(file.exists("data/memo_new.txt")){
  file.remove("data/memo_new.txt")
} 
for(i in 1:length(cleaned_data)){
  write(cleaned_data[i], file="data/memo_new.txt", append = T, sep = "\n")
}
