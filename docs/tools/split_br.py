"""Splits the Leipzig por_news_2024_300K sentences by origin (pt-BR x other variants).
Usage: python3 -I split_br.py <corpus_dir> <out_dir>"""
import sys, re, collections, os
src_dir, out_dir = sys.argv[1], sys.argv[2]
P = os.path.join(src_dir, os.path.basename(os.path.normpath(src_dir)) + '-')
dom = {}
for line in open(P + 'sources.txt', encoding='utf-8'):
    sid, url = line.rstrip('\n').split('\t')[:2]
    d = re.sub(r'^https?://', '', url).split('/')[0].lower()
    if d.startswith('www.'): d = d[4:]
    dom[sid] = d
sent_src = {}
for line in open(P + 'inv_so.txt', encoding='utf-8'):
    sid, snt = line.rstrip('\n').split('\t')[:2]
    sent_src[snt] = sid
sents = {}
for line in open(P + 'sentences.txt', encoding='utf-8'):
    i, s = line.rstrip('\n').split('\t', 1)
    sents[i] = s
PT = re.compile(r"\b(equipa|equipas|facto|factos|autocarro|telemóvel|telemóveis|ecrã|registo|registos|utilizador|utilizadores|contacto|contactos|casa de banho|comboio|pequeno-almoço|está a|estão a|estava a|estavam a|esteve a|vai a ser|frigorífico|guarda-redes|camião|sítio web|perceber|rapariga|miúdos|equipamento desportivo|desporto|desportivo|desportiva|telemóvel)\b", re.I)
BR = re.compile(r"\b(equipe|equipes|ônibus|celular|celulares|tela|registro|registros|usuário|usuários|contato|contatos|banheiro|trem|café da manhã|geladeira|goleiro|caminhão|site|moça|garotos|esporte|esportes|esportivo|esportiva|time)\b", re.I)
stats = collections.defaultdict(lambda: [0, 0, 0])
for snt, s in sents.items():
    d = dom.get(sent_src.get(snt), '?')
    st = stats[d]
    st[0] += 1
    st[1] += len(PT.findall(s))
    st[2] += len(BR.findall(s))
def tld(d): return d.rsplit('.', 1)[-1]
NON_BR_TLD = {'pt', 'ao', 'cv', 'mo', 'lu', 'mz', 'st', 'gw', 'tl', 'fr', 'ch', 'de', 'eu', 'es', 'us', 'uk'}
bad_domains = set()
for d, (n, pt, br) in stats.items():
    t = tld(d)
    if t in NON_BR_TLD:
        bad_domains.add(d)
    elif t != 'br' and n >= 20 and pt > br:
        bad_domains.add(d)
    elif d.startswith('pt.euronews'):
        bad_domains.add(d)
# sites based in Portugal that pass the marker filter (reviewed by hand)
bad_domains |= {'barcelosnanet.com', 'azoresnews.net'}
kept = [snt for snt in sents if dom.get(sent_src.get(snt), '?') not in bad_domains]
dropped = len(sents) - len(kept)
print('sentences', len(sents), 'kept', len(kept), 'dropped', dropped)
print('.com/.net domains dropped by pt-PT markers:', sorted(d for d in bad_domains if tld(d) not in NON_BR_TLD)[:40])
kept.sort(key=lambda x: int(x))
os.makedirs(out_dir, exist_ok=True)
with open(os.path.join(out_dir, 'train.txt'), 'w', encoding='utf-8') as tr, open(os.path.join(out_dir, 'test.txt'), 'w', encoding='utf-8') as te:
    for k, snt in enumerate(kept):
        (te if k % 50 == 0 else tr).write(sents[snt] + '\n')
