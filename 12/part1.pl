% IO Utilities from the swi-prolog docu
file_lines(File, Lines) :-
    setup_call_cleanup(open(File, read, In),
       stream_lines(In, Lines),
       close(In)).

stream_lines(In, Lines) :-
    read_string(In, _, Str),
    split_string(Str, "\n", "", Lines).

% Parsing input
split_row(Line, Out) :-
    split_string(Line, " ", "", SplitLine),
    nth0(0, SplitLine, DataString),
    nth0(1, SplitLine, GroupsString),
    atom_chars(DataString, Data),
    split_string(GroupsString, ",", "", UnparsedGroups),
    maplist(number_string, Groups, UnparsedGroups),
    append([Data], [Groups], Out).

split_input(Out) :- 
    file_lines("input.txt", Lines),
    maplist(split_row, Lines, Out).

% unknown_indicies(Source, Out) :- nth0(Out, Source, '?').
is_unknown(Char) :- append([Char], [], ['?']).

% reduce_line_are(Data, Groups, NewData, NewGroup) :- 

% reduce_line(Row, NewRow) :-
%     nth0(0, Row, Data),
%     nth0(1, Row, Groups),
%     .

% validate_resolved(Row) :-
%     nth0(0, Row, Data),
%     nth0(1, Row, Groups),
%     .

% test(Source, Out) :- maplist(is_unknown, Source, Out).

% resolve_line(RowChars) :-
%     nth.

% Validating row
% is_resolved(Row) :-
%     nth0(0, Row, Springs),
%     nth0(1, Row, Groups),
%     false.

% split_input(Out) :-
%     file_lines("input.txt", Lines),
%     maplist(split_row(), Lines).
