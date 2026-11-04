#!/usr/bin/env python3
"""
Dedup Point/Series/Matrix/Vector types across all packages.
Two-phase: (1) collect prefixes globally, (2) delete defs + replace refs.
"""
import re, os, sys

ROOT = r"D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse\src"

POINT_FUNCS = ["make_point", "make_labeled_point", "point_x", "point_y", "point_label",
               "point_dist", "point_add", "point_sub", "point_scale", "point_dot",
               "point_norm", "point_to_string"]
SERIES_FUNCS = ["make_series", "series_len", "series_sum", "series_mean", "series_min",
                "series_max", "series_var", "series_std", "series_scale", "series_add",
                "series_to_string"]
MATRIX_FUNCS = ["make_matrix", "matrix_identity", "matrix_get", "matrix_transpose",
                "matrix_add", "matrix_scale", "matrix_multiply", "matrix_trace",
                "matrix_norm", "matrix_to_string"]
VECTOR_FUNCS = ["make_vector", "vector_zero", "vector_add", "vector_sub", "vector_scale",
                "vector_dot", "vector_norm", "vector_normalize", "vector_dist",
                "vector_to_string"]
ALL_FUNCS = POINT_FUNCS + SERIES_FUNCS + MATRIX_FUNCS + VECTOR_FUNCS
TYPES = ["Point", "Series", "Matrix", "Vector"]

def find_brace_end(lines, start):
    depth = 0
    found_open = False
    for i in range(start, len(lines)):
        for ch in lines[i]:
            if ch == '{':
                depth += 1
                found_open = True
            elif ch == '}':
                depth -= 1
                if found_open and depth == 0:
                    return i
    return -1

def remove_block(lines, start, end):
    cs = start
    while cs > 0 and lines[cs - 1].strip().startswith("///"):
        cs -= 1
    if cs > 0 and lines[cs - 1].strip() == "":
        cs -= 1
    del lines[cs:end + 1]
    if cs < len(lines) and lines[cs].strip() == "":
        del lines[cs]

def collect_prefixes():
    """Phase 1: Scan all source files for struct prefixes."""
    prefixes = {}  # Prefix -> prefix (e.g. "Bdi_agent" -> "bdi_agent")
    for dp, dn, fns in os.walk(ROOT):
        for fn in fns:
            if not fn.endswith('.mbt') or '_test' in fn or '_smoke' in fn:
                continue
            fp = os.path.join(dp, fn)
            with open(fp, 'r', encoding='utf-8') as f:
                for line in f:
                    m = re.match(r'pub struct (\w+)(Point|Series|Matrix|Vector)\s*\{', line)
                    if m:
                        P = m.group(1)
                        prefixes[P] = P.lower()
    return prefixes

def process_source_file(filepath, prefixes):
    """Phase 2: Delete struct/fn defs and replace refs in a source file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Quick check: does file contain any type keywords?
    if 'Point' not in content and 'Series' not in content and 'Matrix' not in content and 'Vector' not in content:
        return False

    lines = content.split('\n')
    changed = False

    # Find which prefixes are used in this file (fast check)
    used_prefixes = set()
    for P, p in prefixes.items():
        if f"{P}Point" in content or f"{P}Series" in content or f"{P}Matrix" in content or f"{P}Vector" in content:
            used_prefixes.add((P, p))
            continue
        # Check function references
        for func in ALL_FUNCS:
            if f"{p}_{func}" in content:
                used_prefixes.add((P, p))
                break

    if not used_prefixes:
        return False

    # Delete struct definitions
    to_remove = []
    for i, line in enumerate(lines):
        for P, p in used_prefixes:
            for kind in TYPES:
                if re.match(rf'pub struct {P}{kind}\s*\{{', line):
                    end = find_brace_end(lines, i)
                    if end > 0:
                        to_remove.append((i, end))
                    break
    for s, e in sorted(to_remove, reverse=True):
        remove_block(lines, s, e)
        changed = True

    # Delete function definitions
    to_remove = []
    for P, p in used_prefixes:
        for func in ALL_FUNCS:
            fn = f"{p}_{func}"
            for i, line in enumerate(lines):
                if re.match(rf'\s*pub fn {re.escape(fn)}\b', line):
                    end = find_brace_end(lines, i)
                    if end > 0:
                        to_remove.append((i, end))
    for s, e in sorted(to_remove, reverse=True):
        remove_block(lines, s, e)
        changed = True

    # Delete unused helper functions
    content_after = '\n'.join(lines)
    for P, p in used_prefixes:
        for helper in [f"{p}_dbl", f"{p}_int", f"{p}_push"]:
            uses = len(re.findall(rf'\b{helper}\b', content_after))
            if uses <= 1:
                for i, line in enumerate(lines):
                    if re.match(rf'\s*(pub )?fn {helper}\b', line):
                        end = find_brace_end(lines, i)
                        if end > 0:
                            remove_block(lines, i, e := end)
                        break

    # Replace references
    content = '\n'.join(lines)
    for P, p in used_prefixes:
        for kind in TYPES:
            content = content.replace(f"{P}{kind}", f"@types.Dv{kind}")
        for func in ALL_FUNCS:
            content = content.replace(f"{p}_{func}", f"@types.dv_{func}")


    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    return changed or True

def process_test_file(filepath, prefixes):
    """Phase 3: Replace refs in test files."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    changed = False
    for P, p in prefixes.items():
        for kind in TYPES:
            new = re.sub(rf'@\w+\.{P}{kind}\b', f'@types.Dv{kind}', content)
            if new != content:
                content = new
                changed = True
        for func in ALL_FUNCS:
            old = f"{p}_{func}"
            if old in content:
                content = re.sub(rf'@\w+\.{re.escape(old)}\b', f'@types.dv_{func}', content)
                changed = True
    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
    return changed

def update_moon_pkg(pkg_dir):
    pf = os.path.join(pkg_dir, "moon.pkg")
    if not os.path.exists(pf):
        return False
    with open(pf, 'r', encoding='utf-8') as f:
        c = f.read()
    if "dataverse/extcore/types" in c:
        return False
    if 'import {' in c:
        idx = c.index('}')
        c = c[:idx] + '  "dataverse/extcore/types",\n' + c[idx:]
    else:
        c += '\nimport {\n  "dataverse/extcore/types",\n}\n'
    with open(pf, 'w', encoding='utf-8') as f:
        f.write(c)
    return True

def main():
    target_dir = sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith("--") else None

    print("Phase 1: Collecting prefixes...")
    prefixes = collect_prefixes()
    print(f"  Found {len(prefixes)} prefixes")

    print("Phase 2: Processing source files...")
    src_count = 0
    affected_dirs = set()
    for dp, dn, fns in os.walk(ROOT):
        if target_dir and target_dir.replace("/", os.sep) not in dp:
            continue
        for fn in fns:
            if not fn.endswith('.mbt') or '_test' in fn or '_smoke' in fn:
                continue
            fp = os.path.join(dp, fn)
            if process_source_file(fp, prefixes):
                src_count += 1
                affected_dirs.add(dp)
    print(f"  Processed {src_count} source files")

    print("Phase 3: Processing test files...")
    tst_count = 0
    for dp, dn, fns in os.walk(ROOT):
        if target_dir and target_dir.replace("/", os.sep) not in dp:
            continue
        for fn in fns:
            if not fn.endswith('.mbt') or ('_test' not in fn and '_smoke' not in fn):
                continue
            fp = os.path.join(dp, fn)
            if process_test_file(fp, prefixes):
                tst_count += 1
                affected_dirs.add(os.path.dirname(fp))
    print(f"  Processed {tst_count} test files")

    print("Phase 4: Updating moon.pkg...")
    pkg_count = 0
    for d in affected_dirs:
        if update_moon_pkg(d):
            pkg_count += 1
    print(f"  Updated {pkg_count} moon.pkg files")

    print(f"\nDone: {src_count} src + {tst_count} test + {pkg_count} pkg")

if __name__ == "__main__":
    main()