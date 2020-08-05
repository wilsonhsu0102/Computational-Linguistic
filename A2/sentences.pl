% Wilson Wei-Sheng Hsu, hsuwils1, 1004146970

Q1. 
test_sent([fred,feeds,the,dog,with,the,biscuits]).
test_sent([the,dog,feeds,fred,with,puppies]).
test_sent([biscuits,feed,the,puppies]).
test_sent([fred,feed,the,dog],fails).
test_sent([dog,feeds,the,puppies],fails).
test_sent([the,puppies,feed,dog,with,biscuits],fails).


Q2. 
test_sent([to,request]).
test_sent([the,teacher,slept]).
test_sent([the,teacher,tended]).
test_sent([the,student,promised,to,promise]).
test_sent([the,teacher,requested,to,promise]).
test_sent([the,student,requested,the,teacher]).
test_sent([the,student,requested,the,teacher,to,promise]).
test_sent([the,student,promised,the,teacher,to,promise]).
test_sent([the,teacher,appeared,to,tend,to,promise,to,sleep]).
test_sent([the,student,requested,the,teacher,to,promise,the,student,to,appear,to,tend,to,sleep]).
test_sent([the,student,appeared,to,tend,to,promise,the,teacher,to,request,the,student,to,sleep]).
test_sent([to,slept],fails).
test_sent([to,tended],fails).
test_sent([to,promised],fails).
test_sent([to,teacher],fails).
test_sent([the,promise],fails).
test_sent([the,promised],fails).
test_sent([the,teacher,sleep],fails).
test_sent([the,teacher,promise],fails).
test_sent([the,student,slept,to,appear],fails).
test_sent([the,teacher,requested,to,tend],fails).
test_sent([the,teacher,appeared,to,slept],fails).
test_sent([the,student,promised,to,requested],fails).
test_sent([the,teacher,requested,to,the,student],fails).
test_sent([the,student,promised,to,sleep,to,appear],fails).
test_sent([the,teacher,tended,to,promise,the,to,sleep],fails).






