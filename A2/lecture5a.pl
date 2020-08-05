:- discontiguous sub/2,intro/2.
:- ale_flag(subtypecover,_,off).

bot sub [cat,list,agr,vform,gap_struc].
  cat sub [s,agreeable].
    agreeable sub [aux,verbal,gappable] 
              intro [agr:agr].
      verbal sub [v,vp] intro [subcat:list].
        v intro [agent:agr,experiencer:agr].
      gappable sub [vp,np] intro [gap:gap_struc].
        vp intro [vform:vform].

  list sub [e_list,ne_list].
    ne_list intro [hd:bot,tl:list].

  vform sub [active,passive,participle].
  agr sub ['3p','3s','2sp','1s','1p'].

  gap_struc sub [np,none].

sgap rule
s ===> 
cat> (NP,np,agr:A),
cat> (vp,agr:A,subcat:[_],gap:NP,vform:passive).

snpvp rule
s ===> 
cat> (NP,np,agr:A),
cat> (vp,agr:A,subcat:[NP],vform:active,gap:none).

auxvp rule
(vp,agr:A,gap:G,vform:passive,subcat:SCs) ===>
cat> (aux,agr:A),
cat> (vp,gap:G,vform:participle,subcat:SCs).

vpvnp rule
(vp,agr:A,subcat:SCs,gap:G) ===>
cat> (v,agr:A,subcat:[NP|SCs]),
cat> (NP,np,gap:G).

kicked ---> (v,agr:A,
             subcat:[(np,agr:B),
                     (np,agr:A)],
             agent:A,
             experiencer:B).
fred ---> (np,agr:'3s',
              gap:none).
cans ---> (np,agr:'3p',gap:none).
were ---> (aux,agr:('1p';'2sp';'3p')).

empty (np,gap:(np,agr:A),agr:A).


