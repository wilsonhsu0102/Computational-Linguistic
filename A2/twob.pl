% Wilson Wei-Sheng Hsu, hsuwils1, 1004146970
:- ale_flag(subtypecover,_,off).
:- discontiguous sub/2,intro/2.

bot sub [mood, tense, sem, cat, pos, verbal, nominal, list].

    % parts of speech
        pos sub [n, p, v, det, toinf].
            n sub [].
            p sub [].
            v sub [].
            det sub [].
            toinf sub [].   % infinitival to
    % phrasal categories
    cat sub [vproj, np] intro [].
        vproj sub [inf_clause, s, vp] intro [mood:mood].
            inf_clause intro [mood:infinitive].
            s intro [mood:indicative].
            vp intro [mood:indicative].
        np sub [none].

        verbal sub [v, vproj] intro [vsem:v_sem, subcat:list].
        nominal sub [n, np] intro [nsem:n_sem].
    
    % mood and tense for verbs
    tense sub [past, present].
        past sub [].    
        present sub [].
    mood sub [indicative, infinitive].
        indicative intro [tense:tense].
        infinitive sub [].

    % list
    list sub [e_list,ne_list].
        ne_list intro [hd:bot,tl:list].

    % semantics for verbs and nouns
    sem sub [v_sem, n_sem].

        % semantics for nouns
        n_sem sub [student, teacher].
            student sub [].
            teacher sub [].

        % semantics for verbs 
        v_sem sub [tend, appear, promise, request, sleep, tend_promise_request]
              % roles in subcat list has order of: [beneficiary, theme, experiencer, agent]
              intro [vtense:tense, agent:np, theme:cat, beneficiary:np, experiencer:np].     % This should not be empty!  Fill in features for this and
                            % the following subtypes:

            % More subtypes to help identify types when writing rules.
            tend_promise_request sub [promise_request, tend].
                promise_request sub [promise, request].

            tend sub [].
            appear sub [].
            promise sub [].
            request sub [].
            sleep sub [].


% Sentence rules
% Ex. "(np) requested ..."
s_np_vp rule
    (s, mood:(indicative, tense:past), vsem:VSEM) ===> 
    cat> (Agent, np),
    cat> (vp, vsem:(VSEM, vtense:past), subcat:[Agent]).


% Noun phrase rules
np_det_n rule
    (np, nsem:N) ===>
    cat> det,
    cat> (n, nsem:N).


% Verb phrase rules
% all vp have their subcat:[Agent/Expe] (depends on the verb),
% Ex. "... slept"
vp_slept rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Expe]) ===>
    cat> (v, vsem:(VSEM, sleep, vtense:past), subcat:[np, cat, Expe, np]).

% Ex. "... promised" or "... tended" or "... requested" 
vp_ptr rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, tend_promise_request, vtense:past), subcat:[np, cat, np, Agent]).

% Ex. "... appeared"
vp_appeared rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[np]) ===>
    cat> (v, vsem:(VSEM, appear, vtense:past)).

% Ex. "... requested to ..." or "... promised to ..." or "... tended to ..."
vp_ptr_to rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, tend_promise_request, vtense:past), subcat:[np, Theme, np, Agent]),
    cat> (Theme, inf_clause, subcat:[Agent]).

% Ex. "... appeared to ...", Temp because appear does not have an agent
vp_v_to rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, appear, vtense:past), subcat:[np, Theme, np, np]),
    cat> (Theme, inf_clause, subcat:[Agent]).

% Ex. "... requested (np)" or "... promised (np)"
vp_promise_request_np rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, promise_request, vtense:past), subcat:[Bene, cat, np, Agent]),
    cat> (Bene, np).

% Specific for "... requested (np) to ... "
vp_requested_np_inf rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, request, vtense:past), subcat:[Bene, Theme, np, Agent]),
    cat> (Bene, np),
    cat> (Theme, inf_clause, subcat:[Bene]).

% Specific for "... promised (np) to ... "
vp_promised_np_inf rule
    (vp, mood:(indicative, tense:past), vsem:VSEM, subcat:[Agent]) ===>
    cat> (v, vsem:(VSEM, promise, vtense:past), subcat:[Bene, Theme, np, Agent]),
    cat> (Bene, np),
    cat> (Theme, inf_clause, subcat:[Agent]).


% Inf clause rules 
% all inf_clauses have their subcat:[Agent/Expe] (depends on the verb)
% Ex. "... to sleep"
inf_to_sleep rule
    (inf_clause, vsem:VSEM,  subcat:[Expe]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, sleep, vtense:present), subcat:[np, cat, Expe, np]).

% Ex. "... to promise" or "... to request"
inf_to_pr rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, promise_request, vtense:present), subcat:[np, cat, np, Agent]).

% Ex. "... to appear"
inf_to_appear rule
    (inf_clause, vsem:VSEM, subcat:[np]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, appear, vtense:present), subcat:[np, cat, np, np]).

% Ex. "... to request to ..." or "... to promise to ..." or "... to tend to ..."
inf_to_pr_inf rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, tend_promise_request, vtense:present), subcat:[np, Theme, np, Agent]),
    cat> (Theme, inf_clause, subcat:[Agent]).

% Ex. "... to appear to ..."
inf_to_appear_inf rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, appear, vtense:present), subcat:[np, Theme, np, np]),
    cat> (Theme, inf_clause, subcat:[Agent]).

% Ex. "... to promise (np)" or "... to request (np)", appear/tend/sleep does not make sense
inf_to_pr_np rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, promise_request, vtense:present), subcat:[Bene, cat, np, Agent]),
    cat> (Bene, np).

% Ex. "... to request (np) to ..."
inf_to_pr_np_inf rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, request, vtense:present), subcat:[Bene, Theme, np, Agent]),
    cat> (Bene, np),
    cat> (Theme, inf_clause, subcat:[Bene]).

% Ex.  "... to promise (np) to ..."
inf_to_pr_np_inf rule
    (inf_clause, vsem:VSEM, subcat:[Agent]) ===>
    cat> toinf,
    cat> (v, vsem:(VSEM, promise, vtense:present), subcat:[Bene, Theme, np, Agent]),
    cat> (Bene, np),
    cat> (Theme, inf_clause, subcat:[Agent]).


% Lexicons
appear ---> (v, vsem:(appear, vtense:present, agent:none, theme:T, beneficiary:none, experiencer:none), subcat:[none, T, none, none]).

appeared ---> (v, vsem:(appear, vtense:past, agent:none, theme:T, beneficiary:none, experiencer:none), subcat:[none, T, none, none]).

promise ---> (v, vsem:(promise, vtense:present, agent:A, theme:T, beneficiary:B, experiencer:none), subcat:[B, T, none, A]).

promised ---> (v, vsem:(promise, vtense:past, agent:A, theme:T, beneficiary:B, experiencer:none), subcat:[B, T, none, A]).

request ---> (v, vsem:(request, vtense:present, agent:A, theme:T, beneficiary:B, experiencer:none), subcat:[B, T, none, A]).

requested ---> (v, vsem:(request, vtense:past, agent:A, theme:T, beneficiary:B, experiencer:none), subcat:[B, T, none, A]).

sleep ---> (v, vsem:(sleep, vtense:present, agent:none, theme:none, beneficiary:none, experiencer:E), subcat:[none, none, E, none]).

slept ---> (v, vsem:(sleep, vtense:past, agent:none, theme:none, beneficiary:none, experiencer:E), subcat:[none, none, E, none]).

student ---> (n, nsem:student).

teacher ---> (n, nsem:teacher).

tend ---> (v, vsem:(tend, vtense:present, agent:A, theme:T, beneficiary:none, experiencer:none), subcat:[none, T, none, A]).

tended ---> (v, vsem:(tend, vtense:past, agent:A, theme:T, beneficiary:none, experiencer:none), subcat:[none, T, none, A]).

the ---> det.

to ---> toinf.