#!/usr/bin/env python3
"""Checks the safety rules of the workflows in .github/workflows (run at the project root; stdlib only).

For every workflow:
  - each action is pinned by the 40-character commit SHA, with the version in a comment (uses: owner/repo@<sha> # v1.2.3);
    a tag like @v4 can be moved by whoever owns the action, a SHA cannot. The same action uses the same SHA everywhere.
  - there is a top-level "permissions:" and it grants no write permission (each job asks for what it needs);
  - no pull_request_target (it would run the code of a pull request with the repository's secrets).
mr-apk.yml (the one that publishes):
  - it has the jobs apk, checks and publish; "checks" calls ./.github/workflows/mr-checks.yml, which has workflow_call;
  - publish needs apk AND checks (a release is only made after the checks passed);
  - only publish has write permission, and exactly: contents, id-token, attestations;
  - only publish runs publish_release.sh and it attests (actions/attest) what it published.

Usage: python3 docs/tools/check_workflows.py [workflows-dir]
"""
import glob, os, re, sys

D = sys.argv[1] if len(sys.argv) > 1 else '.github/workflows'
problems = []
SHA_USES = re.compile(r'^([\w.-]+/[\w./-]+)@([0-9a-f]{40})\s+#\s*v\d+(\.\d+)*\s*$')


def indent_of(line):
    return len(line) - len(line.lstrip(' '))


def significant(lines):
    """(number, indent, text) of the lines that are not blank, not comment and not the inside of a | or > block."""
    out, skip_over = [], None
    for n, raw in enumerate(lines, 1):
        text = raw.rstrip('\n')
        if not text.strip():
            continue
        ind = indent_of(text)
        if skip_over is not None:
            if ind > skip_over:
                continue
            skip_over = None
        if text.strip().startswith('#'):
            continue
        out.append((n, ind, text.strip()))
        if re.search(r':\s*[|>][+-]?\s*(#.*)?$', text):
            skip_over = ind
    return out


def top_block(sig, key):
    """The (indent, text) lines inside the top-level key (indent 0), without the key line; None if it does not exist."""
    for i, (n, ind, text) in enumerate(sig):
        if ind == 0 and re.match(re.escape(key) + r':', text):
            body = []
            for n2, ind2, text2 in sig[i + 1:]:
                if ind2 == 0:
                    break
                body.append((n2, ind2, text2))
            return text[len(key) + 1:].strip(), body
    return None


def perms(body):
    """{permission: level} from the lines of a permissions: block (all at the same indent)."""
    out = {}
    for n, ind, text in body:
        m = re.match(r'([\w-]+):\s*(\S+)\s*(#.*)?$', text)
        if m:
            out[m.group(1)] = m.group(2)
    return out


def jobs_of(sig):
    """{job: [(number, indent, text) of its lines]} (jobs sit at indent 2 inside jobs:)."""
    tb = top_block(sig, 'jobs')
    jobs, cur = {}, None
    if tb is None:
        return jobs
    for n, ind, text in tb[1]:
        m = re.match(r'([\w-]+):\s*$', text)
        if ind == 2 and m:
            cur = m.group(1)
            jobs[cur] = []
        elif cur is not None:
            jobs[cur].append((n, ind, text))
    return jobs


def job_key(lines, key):
    """Value of a key written at the job's own level (indent 4); for a block key, the lines inside it."""
    for i, (n, ind, text) in enumerate(lines):
        if ind == 4 and re.match(re.escape(key) + r':', text):
            val = text[len(key) + 1:].strip()
            body = []
            for n2, ind2, text2 in lines[i + 1:]:
                if ind2 <= 4:
                    break
                body.append((n2, ind2, text2))
            return val, body
    return None


def has_write(p):
    return sorted(k for k, v in p.items() if v in ('write', 'write-all'))


files = sorted(glob.glob(os.path.join(D, '*.yml')) + glob.glob(os.path.join(D, '*.yaml')))
if not files:
    problems.append('no workflow in %s' % D)
pins = {}   # action -> {sha: [file:line]}
parsed = {}
for f in files:
    name = os.path.basename(f)
    lines = open(f, encoding='utf-8').read().split('\n')
    sig = significant(lines)
    parsed[name] = (sig, lines)

    for n, raw in enumerate(lines, 1):
        m = re.match(r'^\s*(?:-\s+)?uses:\s*(\S+)(.*)$', raw)
        if not m:
            continue
        ref = m.group(1) + m.group(2)
        if m.group(1).startswith('./'):
            continue
        mm = SHA_USES.match(ref.strip())
        if not mm:
            problems.append('%s:%d: "%s" must be pinned by commit: owner/repo@<40 hex> # vX.Y.Z' % (name, n, ref.strip()))
        else:
            pins.setdefault(mm.group(1), {}).setdefault(mm.group(2), []).append('%s:%d' % (name, n))

    tp = top_block(sig, 'permissions')
    if tp is None:
        problems.append('%s: no top-level "permissions:" (without it the token gets the repository default)' % name)
    elif tp[0]:
        # one-line form: "permissions: read-all" / "write-all"
        if tp[0] == 'write-all':
            problems.append('%s: top-level permissions: write-all' % name)
    else:
        w = has_write(perms(tp[1]))
        if w:
            problems.append('%s: the top-level permissions grant write (%s); give it to the job that needs it' % (name, ', '.join(w)))

    for n, ind, text in sig:
        if re.match(r'pull_request_target\b', text):
            problems.append('%s:%d: pull_request_target runs the code of a pull request with the secrets' % (name, n))

for action, shas in sorted(pins.items()):
    if len(shas) > 1:
        problems.append('%s is pinned to different commits: %s' % (action, '; '.join('%s (%s)' % (s[:12], ', '.join(w)) for s, w in sorted(shas.items()))))

# ---- mr-checks.yml: callable by the release workflow
if 'mr-checks.yml' not in parsed:
    problems.append('mr-checks.yml is missing')
else:
    on = top_block(parsed['mr-checks.yml'][0], 'on')
    if on is None or not any(ind == 2 and re.match(r'workflow_call:', t) for n, ind, t in on[1]):
        problems.append('mr-checks.yml must have "workflow_call:" in on: (mr-apk.yml calls it before publishing)')

# ---- mr-apk.yml: the gate and the minimal permissions of the publication
if 'mr-apk.yml' not in parsed:
    problems.append('mr-apk.yml is missing')
else:
    sig, lines = parsed['mr-apk.yml']
    jobs = jobs_of(sig)
    for j in ('apk', 'checks', 'publish'):
        if j not in jobs:
            problems.append('mr-apk.yml: missing the job "%s"' % j)
    if 'checks' in jobs:
        u = job_key(jobs['checks'], 'uses')
        if not u or u[0] != './.github/workflows/mr-checks.yml':
            problems.append('mr-apk.yml: the job "checks" must be "uses: ./.github/workflows/mr-checks.yml"')
    if 'publish' in jobs:
        nd = job_key(jobs['publish'], 'needs')
        needs = set(re.findall(r'[\w-]+', nd[0])) if nd and nd[0] else {t[2:].strip() for _, _, t in (nd[1] if nd else []) if t.startswith('- ')}
        for j in ('apk', 'checks'):
            if j not in needs:
                problems.append('mr-apk.yml: the job "publish" must have "%s" in needs (publish only after the checks)' % j)
        pb = job_key(jobs['publish'], 'permissions')
        want = {'contents': 'write', 'id-token': 'write', 'attestations': 'write'}
        if not pb or perms(pb[1]) != want:
            problems.append('mr-apk.yml: the job "publish" must have exactly these permissions: %s (it has %s)' %
                            (want, perms(pb[1]) if pb else 'none'))
        text = '\n'.join(lines[jobs['publish'][0][0] - 1:jobs['publish'][-1][0]])
        if 'publish_release.sh' not in text:
            problems.append('mr-apk.yml: the job "publish" does not run publish_release.sh')
        if not re.search(r'uses:\s*actions/attest@', text):
            problems.append('mr-apk.yml: the job "publish" does not attest (actions/attest) the APK and the source zip')
        if not re.search(r'uses:\s*actions/download-artifact@', text):
            problems.append('mr-apk.yml: the job "publish" must publish the APK built by the job "apk" (download-artifact)')
    for j, jl in jobs.items():
        if j != 'publish':
            pb = job_key(jl, 'permissions')
            if pb and has_write(perms(pb[1])):
                problems.append('mr-apk.yml: the job "%s" has write permission; only "publish" may' % j)
            if pb and pb[0] == 'write-all':
                problems.append('mr-apk.yml: the job "%s" has write-all' % j)
            body = '\n'.join(t for _, _, t in jl)
            if 'publish_release.sh' in body:
                problems.append('mr-apk.yml: only the job "publish" may run publish_release.sh (it is in "%s")' % j)

if problems:
    print('check_workflows: %d problem(s)' % len(problems))
    for p in problems:
        print('  - ' + p)
    sys.exit(1)
print('check_workflows: OK (%d workflows, %d actions pinned by commit)' % (len(files), len(pins)))
