"""Separa as frases pt-BR do Tatoeba (por_sentences_detailed.tsv) por autor e por frase.
Uso: python3 -I split_tatoeba.py por_sentences_detailed.tsv saida_dir"""
import sys, re, os, collections
src, out = sys.argv[1], sys.argv[2]
PT = re.compile(r"\b(equipa|equipas|facto|factos|autocarro|telemóvel|telemóveis|ecrã|registo|utilizador|contacto|contactos|casa de banho|comboio|pequeno-almoço|frigorífico|guarda-redes|camião|rapariga|raparigas|miúdo|miúdos|desporto|desportivo|sumo|propina|bicha|estás|és|tens|vens|queres|podes|sabes|fazes|vais|dizes|tu|contigo|teu|tua|teus|tuas|vós|vosso|vossa|connosco|óptimo|acção|direcção|objectivo|actual|actualmente|exacto|projecto|baptismo|adoptar|percebes|estou a|está a|estás a|estamos a|estão a|estava a|estive a)\b", re.I)
BR = re.compile(r"\b(equipe|ônibus|celular|tela|registro|usuário|contato|banheiro|trem|café da manhã|geladeira|goleiro|caminhão|moça|garoto|garota|esporte|suco|você|vocês|a gente|gostaria|legal|cara|bacana|ótimo|ação|direção|objetivo|atual|atualmente|exato|projeto|estou fazendo|está fazendo|estava fazendo)\b", re.I)
rows = []
users = collections.defaultdict(lambda: [0, 0, 0])
for line in open(src, encoding="utf-8"):
    p = line.rstrip("\n").split("\t")
    if len(p) < 4 or p[1] != "por":
        continue
    text, user = p[2].strip(), p[3]
    pt, br = len(PT.findall(text)), len(BR.findall(text))
    u = users[user]; u[0] += 1; u[1] += pt; u[2] += br
    rows.append((text, user, pt, br))
bad_users = {u for u, (n, pt, br) in users.items() if n >= 20 and pt > br}
kept = [t for t, u, pt, br in rows if u not in bad_users and pt == 0 and len(t) >= 2]
seen = set(); uniq = []
for t in kept:
    if t not in seen:
        seen.add(t); uniq.append(t)
os.makedirs(out, exist_ok=True)
with open(os.path.join(out, "train.txt"), "w", encoding="utf-8") as tr, open(os.path.join(out, "test.txt"), "w", encoding="utf-8") as te:
    for i, t in enumerate(uniq):
        (te if i % 20 == 0 else tr).write(t + "\n")
print("frases", len(rows), "autores", len(users), "autores pt-PT", len(bad_users),
      "frases com marca pt-PT", sum(1 for r in rows if r[2] > 0), "mantidas (sem repetição)", len(uniq))
print("autores pt-PT (maiores):", sorted(bad_users, key=lambda u: -users[u][0])[:15])
