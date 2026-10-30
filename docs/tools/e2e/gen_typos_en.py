import random, re, sys, collections
# Gera erros de digitação sintéticos em inglês (tecla vizinha, troca, letra que falta ou dobra) para TypoEval.java.
# Uso: python3 -I gen_typos_en.py news_test.txt chat_test.txt saida.tsv
random.seed(164)
rows=["qwertyuiop","asdfghjkl","zxcvbnm"]
pos={c:(r,k) for r,row in enumerate(rows) for k,c in enumerate(row)}
def near(c):
    if c not in pos: return []
    r,k=pos[c]; out=[]
    for dr,dk in [(0,-1),(0,1),(-1,0),(-1,1),(1,-1),(1,0)]:
        rr,kk=r+dr,k+dk
        if 0<=rr<3 and 0<=kk<len(rows[rr]): out.append(rows[rr][kk])
    return out
cnt=collections.Counter()
for f in sys.argv[1:3]:
    for line in open(f,encoding='utf-8'):
        for w in re.findall(r"[A-Za-z]+(?:'[a-z]+)?",line): cnt[w]+=1
words=[w for w,_ in cnt.most_common(3000) if len(w)>=4 and w.islower() and "'" not in w]
out=[]
for w in words[:1500]:
    kind=random.choice(['near','swap','del','dup'])
    i=random.randrange(len(w)-1)
    if kind=='near':
        n=near(w[i]); t=w[:i]+random.choice(n)+w[i+1:] if n else w
    elif kind=='swap': t=w[:i]+w[i+1]+w[i]+w[i+2:]
    elif kind=='del': t=w[:i]+w[i+1:]
    else: t=w[:i]+w[i]+w[i:]
    if t!=w: out.append((t,w,kind))
open(sys.argv[3],'w').write(''.join('%s\t%s\t%s\n'%x for x in out))
print(len(out))
