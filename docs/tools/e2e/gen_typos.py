import random, re, sys, collections
# Gera a lista de palavras digitadas (com erros de propósito) do teste de paridade (Parity.java).
# Uso: python3 -I gen_typos.py noticias_teste.txt conversa_teste.txt dicts/pt-BR/rules.txt saida.txt
random.seed(163)
rows=["qwertyuiop","asdfghjklç","zxcvbnm"]
pos={c:(r,k) for r,row in enumerate(rows) for k,c in enumerate(row)}
def near(c):
    if c not in pos: return []
    r,k=pos[c]; out=[]
    for dr,dk in [(0,-1),(0,1),(-1,0),(-1,1),(1,-1),(1,0)]:
        rr,kk=r+dr,k+dk
        if 0<=rr<3 and 0<=kk<len(rows[rr]): out.append(rows[rr][kk])
    return out
phon=[("s","z"),("s","c"),("ss","ç"),("ch","x"),("x","ch"),("g","j"),("u","l"),("e","i"),("o","u"),("qu","q"),("lh","l"),("nh","n"),("h","")]
cnt=collections.Counter()
for f in sys.argv[1:3]:
    for line in open(f,encoding='utf-8'):
        for w in re.findall(r"[^\W\d_]+",line): cnt[w]+=1
words=[w for w,_ in cnt.most_common(4000) if len(w)>=2]
sample=words[:1500]+random.sample(words[1500:],1000)
out=set()
for w in sample:
    out.add(w); out.add(w[:max(1,len(w)//2)])
    lw=w.lower()
    if len(lw)>=3:
        i=random.randrange(len(lw)); n=near(lw[i])
        if n: out.add(lw[:i]+random.choice(n)+lw[i+1:])
        i=random.randrange(len(lw)-1); out.add(lw[:i]+lw[i+1]+lw[i]+lw[i+2:])
        i=random.randrange(len(lw)); out.add(lw[:i]+lw[i+1:])
        i=random.randrange(len(lw)); out.add(lw[:i]+lw[i]+lw[i:])
        a,b=random.choice(phon)
        if a in lw: out.add(lw.replace(a,b,1))
        if b and b in lw: out.add(lw.replace(b,a,1))
    if lw.startswith("c"): out.add("x"+lw[1:])
    if lw.startswith("ch"): out.add("x"+lw[2:])
for line in open(sys.argv[3],encoding='utf-8'):
    if '\t' in line and not line.startswith('#'):
        out.add(line.split('\t')[0].strip())
out=[w for w in out if 1<=len(w)<=24 and w.strip()]
out.sort()
open(sys.argv[4],'w',encoding='utf-8').write('\n'.join(out)+'\n')
print(len(out))
