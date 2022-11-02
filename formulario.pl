:- dynamic formulario/3.

setFormulario :- carrega('./formulario.bd'),
    format('~n*** Formulario de Triagem ***~n~n'),
    repeat,
    setNome(Paciente),
    setTemperatura(Paciente),
    setFreqCardiaca(Paciente),
    setFreqResp(Paciente),
    setPreSisto(Paciente),
    setSatur(Paciente),
    setDispineia(Paciente),
    idade(Paciente),
    setComorbidade(Paciente),
    responde(Paciente),
    salva(setFormulario,'./formulario.bd').

carrega(Arquivo) :-
    exists_file(Arquivo),
    consult(Arquivo)
    ;
    true.

setNome(Paciente) :-
    format('~nInforme o nome do paciente: '),
    gets(Paciente).

setTemperatura(Paciente) :-
    format('~nInforme a temperatura: '),
    gets(Temp),
    asserta(setFormulario(Paciente,setTemperatura,Temp)).

setFreqCardiaca(Paciente) :-
    format('~nInforme a frequencia cardiaca: '),
    gets(FreCard),
    asserta(setFormulario(Paciente,setFreqCardiaca,FreCard)).

setFreqResp(Paciente) :-
    format('~nInforme a frequencia respiratoria: '),
    gets(FreResp),
    asserta(setFormulario(Paciente,setFreqResp,FreResp)).

setPreSisto(Paciente) :-
    format('~nInforme a pressao arterial sistolica: '),
    gets(PreSis),
    asserta(setFormulario(Paciente,setPreSisto,PreSis)).

setSatur(Paciente) :-
    format('~nInforme a saturacao do oxigenio(Sa02): '),
    gets(SaO2),
    asserta(setFormulario(Paciente,setSatur,SaO2)).

setDispineia(Paciente) :-
    format('~nTem dispneia? (sim ou nao) : '),
    gets(Dispn),
    asserta(setFormulario(Paciente,setDispineia,Dispn)).

idade(Paciente) :-
    format('~nQual a Idade? '),
    gets(Idade),
    asserta(setFormulario(Paciente,idade,Idade)).

setComorbidade(Paciente) :-
    format('~nPossui comorbidades? '),
    format('~nSe sim digite a quantidade, se nao digite 0 : '),
    gets(Como),
    asserta(setFormulario(Paciente,setComorbidade,Como)).

salva(P,A) :-
    tell(A),
    listing(P),
    told.

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

responde(Paciente) :-
    condicao(Paciente, Char),
    !,
    format('A condicao de ~w e ~w.~n',[Paciente,Char]).

condicao(Pct, leve) :-
    setFormulario(Pct,setTemperatura,Valor), Valor >= 35, Valor =< 37;
    setFormulario(Pct,setFreqCardiaca,Valor), Valor < 100;
    setFormulario(Pct,setFreqResp,Valor), Valor =< 18;
    setFormulario(Pct,setPreSisto,Valor), Valor > 100;
    setFormulario(Pct,setSatur,Valor), Valor >= 95;
    setFormulario(Pct,setDispineia,Valor), Valor = "nao";
    setFormulario(Pct,idade,Valor), Valor < 60;
    setFormulario(Pct,setComorbidade,Valor), Valor = 0.

condicao(Pct, medio) :-
    setFormulario(Pct,setTemperatura,Valor), (Valor < 35; (Valor > 37, Valor =< 39));
    setFormulario(Pct,setFreqCardiaca,Valor), Valor >= 100;
    setFormulario(Pct,setFreqResp,Valor), Valor >= 19, Valor =< 30;
    setFormulario(Pct,idade,Valor), Valor >= 60, Valor =< 79;
    setFormulario(Pct,setComorbidade,Valor), Valor = 1.

condicao(Pct, grave) :-
    setFormulario(Pct,setTemperatura,Valor), Valor > 39;
    setFormulario(Pct,setPreSisto,Valor), Valor >= 90, Valor =< 100;
    setFormulario(Pct,idade,Valor), Valor >= 80;
    setFormulario(Pct,setComorbidade,Valor), Valor >= 2.


condicao(Pct, gravissimo) :-
    setFormulario(Pct,setFreqResp,Valor), Valor > 30;
    setFormulario(Pct,setPreSisto,Valor), Valor < 90;
    setFormulario(Pct,setSatur,Valor), Valor < 95;
    setFormulario(Pct,setDispineia,Valor), Valor = "sim".