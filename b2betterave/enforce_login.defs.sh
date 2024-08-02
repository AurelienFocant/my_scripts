#! /bin/zsh

grep -E '10[0-9]{2,}' /etc/passwd | cut -d: -f1 | xargs -I{} sudo chage --mindays 2 {} ;
grep -E '10[0-9]{2,}' /etc/passwd | cut -d: -f1 | xargs -I{} sudo chage --maxdays 30 {} ;
grep -E '10[0-9]{2,}' /etc/passwd | cut -d: -f1 | xargs -I{} sudo chage --warndays 7 {} ;
