#!/usr/bin/env python3
"""
Dedup Point/Series/Matrix/Vector types — single-file packages only.
"""
import re, os, sys

ROOT = r"D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse\src"
EXCLUDE = ["extcore" + os.sep + "types"]

POINT_FUNCS = ["make_point","make_labeled_point","point_x","point_y","point_label",
               "point_dist","point_add","point_sub","point_scale","point_dot",
               "point_norm","point_to_string"]
SERIES_FUNCS = ["make_series","series_len","series_sum","series_mean","series_min",
                "series_max","series_var","series_std","series_scale","series_add",
                "series_to_string"]
MATRIX_FUNCS = ["make_matrix","matrix_identity","matrix_get","matrix_transpose",
                "matrix_add","matrix_scale","matrix_multiply","matrix_trace",
                "matrix_norm","matrix_to_string"]
VECTOR_FUNCS = ["make_vector","vector_zero","vector_add","vector_sub","vector_scale",
                "vector_dot","vector_norm","vector_normalize","vector_dist",
                "vector_to_string"]
ALL_FUNCS = POINT_FUNCS + SERIES_FUNCS + MATRIX_FUNCS + VECTOR_FUNCS
TYPES = ["Point","Series","Matrix","Vector"]

def is_excluded(dp):
    return any(ex in dp for ex in EXCLUDE)

def find_brace_end(lines, start):
    depth = 0; found = False
    for i in range(start, len(lines)):
        for ch in lines[i]:
            if ch == '{': depth += 1; found = True
            elif ch == '}':
                depth -= 1
                if found and depth == 0: return i
    return -1

def remove_block(lines, start, end):
    cs = start
    while cs > 0 and lines[cs-1].strip().startswith("///"): cs -= 1
    if cs > 0 and lines[cs-1].strip() == "": cs -= 1
    del lines[cs:end+1]
    if cs < len(lines) and lines[cs].strip() == "": del lines[cs]

def collect_prefixes():
    prefixes = {}
    for dp, dn, fns in os.walk(ROOT):
        if is_excluded(dp): continue
        src = [f for f in fns if f.endswith('.mbt') and '_test' not in f and '_smoke' not in f]
        if len(src) != 1: continue
        with open(os.path.join(dp, src[0]), encoding='utf-8') as f:
            for line in f:
                m = re.match(r'pub struct (\w+)(Point|Series|Matrix|Vector)\s*\{', line)
                if m:
                    P = m.group(1)
                    prefixes[P] = P.lower()
    return prefixes

def process_source_file(filepath, prefixes):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    if 'Point' not in content and 'Series' not in content and 'Matrix' not in content and 'Vector' not in content:
        return False
    lines = content.split('\n')
    used = set()
    for P, p in prefixes.items():
        # Fast check with substring, then confirm with regex
        found = False
        for k in TYPES:
            if f"{P}{k}" in content and re.search(rf'(?<!\w){re.escape(P)}{k}\b', content):
                found = True; break
        if not found:
            for fn in ALL_FUNCS:
                if f"{p}_{fn}" in content and re.search(rf'(?<!\w){re.escape(p)}_{re.escape(fn)}\b', content):
                    found = True; break
        if found:
            used.add((P, p))
    if not used: return False

    to_rm = []
    for i, line in enumerate(lines):
        for P, p in used:
            for k in TYPES:
                if re.match(rf'pub struct {P}{k}\s*\{{', line):
                    e = find_brace_end(lines, i)
                    if e > 0: to_rm.append((i, e))
                    break
    for s, e in sorted(to_rm, reverse=True): remove_block(lines, s, e)

    to_rm = []
    for P, p in used:
        for fn in ALL_FUNCS:
            name = f"{p}_{fn}"
            for i, line in enumerate(lines):
                if re.match(rf'\s*pub fn {re.escape(name)}\b', line):
                    e = find_brace_end(lines, i)
                    if e > 0: to_rm.append((i, e))
    for s, e in sorted(to_rm, reverse=True): remove_block(lines, s, e)

    content_after = '\n'.join(lines)
    for P, p in used:
        for h in [f"{p}_dbl", f"{p}_int", f"{p}_push"]:
            if len(re.findall(rf'\b{h}\b', content_after)) <= 1:
                for i, line in enumerate(lines):
                    if re.match(rf'\s*(pub )?fn {h}\b', line):
                        e = find_brace_end(lines, i)
                        if e > 0: remove_block(lines, i, e)
                        break

    content = '\n'.join(lines)
    for P, p in used:
        for k in TYPES:
            content = re.sub(rf'(?<!\w){re.escape(P)}{k}\b', f"@types.Dv{k}", content)
        for fn in ALL_FUNCS:
            content = re.sub(rf'(?<!\w){re.escape(p)}_{re.escape(fn)}\b', f"@types.dv_{fn}", content)
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    return True

def process_test_file(filepath, prefixes):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    changed = False
    for P, p in prefixes.items():
        for k in TYPES:
            new = re.sub(rf'@\w+\.{P}{k}\b', f'@types.Dv{k}', content)
            if new != content: content = new; changed = True
        for fn in ALL_FUNCS:
            old = f"{p}_{fn}"
            if old in content:
                content = re.sub(rf'@\w+\.{re.escape(old)}\b', f'@types.dv_{fn}', content)
                changed = True
    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
    return changed

def update_moon_pkg(d):
    pf = os.path.join(d, "moon.pkg")
    if not os.path.exists(pf): return False
    with open(pf, 'r', encoding='utf-8') as f: c = f.read()
    if "dataverse/extcore/types" in c: return False
    if 'import {' in c:
        idx = c.index('}')
        c = c[:idx] + '  "dataverse/extcore/types",\n' + c[idx:]
    else:
        c += '\nimport {\n  "dataverse/extcore/types",\n}\n'
    with open(pf, 'w', encoding='utf-8') as f: f.write(c)
    return True

def main():
    print("Phase 1: Collecting prefixes (single-file packages)...")
    prefixes = collect_prefixes()
    print(f"  Found {len(prefixes)} prefixes")

    print("Phase 2: Processing source files...")
    src_count = 0; affected = set()
    for dp, dn, fns in os.walk(ROOT):
        if is_excluded(dp): continue
        for fn in fns:
            if not fn.endswith('.mbt') or '_test' in fn or '_smoke' in fn: continue
            fp = os.path.join(dp, fn)
            if process_source_file(fp, prefixes):
                src_count += 1; affected.add(dp)
    print(f"  Processed {src_count} source files")

    print("Phase 3: Processing test files (all directories)...")
    tst_count = 0
    for dp, dn, fns in os.walk(ROOT):
        for fn in fns:
            if not fn.endswith('.mbt') or ('_test' not in fn and '_smoke' not in fn): continue
            fp = os.path.join(dp, fn)
            if process_test_file(fp, prefixes):
                tst_count += 1; affected.add(os.path.dirname(fp))
    print(f"  Processed {tst_count} test files")

    print("Phase 4: Updating moon.pkg...")
    pkg_count = sum(1 for d in affected if update_moon_pkg(d))
    print(f"  Updated {pkg_count} moon.pkg files")
    print(f"\nDone: {src_count} src + {tst_count} test + {pkg_count} pkg")

if __name__ == "__main__":
    main()