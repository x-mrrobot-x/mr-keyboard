import json, hashlib, zipfile, io, os, sys, subprocess, copy
import sys
B=sys.argv[1] if len(sys.argv) > 1 else '.'; O=sys.argv[2] if len(sys.argv) > 2 else '/tmp/pt/fx'
os.makedirs(O, exist_ok=True)
# the test expects the real pack to be version 2 (the other fixtures count up from it), so build
# from a copy with that version no matter what dicts/pt-BR/pack.json says today
import tempfile, shutil
D=tempfile.mkdtemp(); shutil.copytree(B+'/dicts', D+'/dicts')
pj=D+'/dicts/pt-BR/pack.json'; meta=json.loads(open(pj,encoding='utf-8').read()); meta['version']=2
open(pj,'w',encoding='utf-8').write(json.dumps(meta,ensure_ascii=False,indent=2))
subprocess.run(['python3','-I',B+'/docs/tools/make_catalog.py','--dicts',D+'/dicts','--out',O+'/ok','--repo','x-mrrobot-x/mr-keyboard','--tag','v1.73.0','--now','2026-10-30T18:00:00+00:00'],check=True)
base=json.loads(open(O+'/ok/data.json',encoding='utf-8').read())
zbytes=open(O+'/ok/pt-BR-%d.zip'%base['packs'][0]['version'],'rb').read()
files={n:z for n,z in [(i.filename,None) for i in zipfile.ZipFile(io.BytesIO(zbytes)).infolist()]}
zf=zipfile.ZipFile(io.BytesIO(zbytes)); contents={i.filename:zf.read(i.filename) for i in zf.infolist()}
def mkzip(entries):
    b=io.BytesIO()
    with zipfile.ZipFile(b,'w') as z:
        for n,d in entries:
            info=zipfile.ZipInfo(n,(1980,1,1,0,0,0)); info.compress_type=zipfile.ZIP_DEFLATED
            z.writestr(info,d)
    return b.getvalue()
def write(name, data, zips):
    d=os.path.join(O,name); os.makedirs(d,exist_ok=True)
    open(d+'/data.json','wb').write(json.dumps(data,ensure_ascii=False,indent=1).encode())
    for zn,zb in zips.items(): open(d+'/'+zn,'wb').write(zb)
def variant(name, serial, version, zipb=None, mut=None):
    d=copy.deepcopy(base); d['serial']=serial; p=d['packs'][0]; p['version']=version
    zb=zipb if zipb is not None else zbytes
    p['url']='pt-BR-%d.zip'%version; p['size']=len(zb); p['sha256']=hashlib.sha256(zb).hexdigest()
    if mut: mut(p)
    write(name,d,{p['url']:zb})
variant('old',0,2)
variant('v3',2,3)
order=['pack.json']+[f['name'] for f in base['packs'][0]['files']]
variant('extra',3,4,mkzip([(n,contents[n]) for n in order]+[('evil.txt',b'x')]))
variant('slip',3,4,mkzip([(n,contents[n]) for n in order]+[('../evil.txt',b'x')]))
def badsha(p):
    for f in p['files']:
        if f['name']=='rules.txt': f['sha256']='0'*64
variant('badfile',4,5,None,badsha)
variant('minapp',5,6,None,lambda p: p.__setitem__('minApp',9999999))
variant('v7',6,7)
print('ok', sorted(os.listdir(O)))
