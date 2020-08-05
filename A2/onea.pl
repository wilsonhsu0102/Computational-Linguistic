% Wilson Wei-Sheng Hsu, hsuwils1, 1004146970

% Grammar 1
% Declare types
bot sub [s, non_terminal, terminal].
    terminal sub [nsg, npl, nprp, vsg, vpl, det, p].
    non_terminal sub [np, npsg, nppl, vpsg, vppl, pp].

% Rules
s_npsg_vpsg rule
    s ===>
    cat> npsg,
    cat> vpsg.

s_nppl_vppl rule
    s ===>
    cat> nppl,
    cat> vppl.

vpsg_vsg_np rule
    vpsg ===>
    cat> vsg,
    cat> np.

vppl_vpl_np rule
    vppl ===>
    cat> vpl,
    cat> np.

vpsg_vsg_np_pp rule
    vpsg ===>
    cat> vsg,
    cat> np,
    cat> pp.

vppl_vpl_np_pp rule
    vppl ===>
    cat> vpl,
    cat> np,
    cat> pp.

pp_p_np rule
    pp ===>
    cat> p,
    cat> np.

npsg_nprp rule
    npsg ===>
    cat> nprp.

npsg_det_nsg rule 
    npsg ===>
    cat> det,
    cat> nsg.

nppl_det_npl rule 
    nppl ===>
    cat> det,
    cat> npl.

nppl_npl rule
    nppl ===>
    cat> npl.

np_npsg rule
    np ===>
    cat> npsg.

np_nppl rule
    np ===>
    cat> nppl.

% Lexicons
biscuits ---> npl.

dog ---> nsg.

fred ---> nprp.

feed ---> vpl.

feeds ---> vsg.

puppies ---> npl.

the ---> det.

with ---> p.