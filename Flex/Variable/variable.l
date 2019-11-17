
PALABRA [a-z]|[A-Z]
NUM [0-9]
SIMBOLO _

%%

({PALABRA}+{NUM}*|{SIMBOLO}+{NUM}*{PALABRA}*)+ printf("Variable valida");

%%
