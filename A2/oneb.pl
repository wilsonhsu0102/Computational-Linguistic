% Wilson Wei-Sheng Hsu, hsuwils1, 1004146970

% Grammar 2
% Declare types
bot sub [s, cat, num].
    num sub [sg, pl].
    cat sub [det, p, pp, has_num].
        % Features for terms that can be singular or plural
        has_num sub [n, v, np, vp] intro [number:num].

% Rules
s_np_vp rule
    s ===>
    cat> (np, number:Num),
    cat> (vp, number:Num).

vp_v_np rule
    (vp, number:Num) ===>
    cat> (v, number:Num),
    cat> np.

vp_v_np_pp rule
    (vp, number:Num) ===>
    cat> (v, number:Num),
    cat> np,
    cat> pp.

pp_p_np rule
    pp ===>
    cat> p,
    cat> np.

% Only plural noun can use this rule
np_n rule
    (np, number:Num) ===>
    cat> (n, number:(Num, pl)).

np_det_n rule
    (np, number:Num) ===>
    cat> det,
    cat> (n, number:Num).

% Lexicons
biscuits ---> (n, number:pl).

dog ---> (n, number:sg).

fred ---> (np, number:sg).

feed ---> (v, number:pl).

feeds ---> (v, number:sg).

puppies ---> (n, number:pl).

the ---> det.

with ---> p.