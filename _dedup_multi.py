import re, os, subprocess

ROOT = r'D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse'
TYPES_PKG = 'dataverse/extcore/types'

PSVM_SUFFIXES = [
    'make_point', 'make_labeled_point', 'point_x', 'point_y', 'point_label',
    'point_dist', 'point_add', 'point_sub', 'point_scale', 'point_dot', 'point_norm',
    'point_to_string', 'make_series', 'series_len', 'series_sum', 'series_mean',
    'series_min', 'series_max', 'series_var', 'series_std', 'series_scale',
    'series_add', 'series_to_string', 'make_matrix', 'matrix_identity',
    'matrix_get', 'matrix_set', 'matrix_transpose', 'matrix_add', 'matrix_scale',
    'matrix_multiply', 'matrix_trace', 'matrix_norm', 'matrix_to_string',
    'make_vector', 'vector_zero', 'vector_add', 'vector_sub', 'vector_scale',
    'vector_dot', 'vector_norm', 'vector_normalize', 'vector_dist', 'vector_to_string',
]

DV_FUNCS = {
    'make_point': 'dv_make_point', 'make_labeled_point': 'dv_make_labeled_point',
    'point_x': 'dv_point_x', 'point_y': 'dv_point_y', 'point_label': 'dv_point_label',
    'point_dist': 'dv_point_dist', 'point_add': 'dv_point_add', 'point_sub': 'dv_point_sub',
    'point_scale': 'dv_point_scale', 'point_dot': 'dv_point_dot', 'point_norm': 'dv_point_norm',
    'point_to_string': 'dv_point_to_string',
    'make_series': 'dv_make_series', 'series_len': 'dv_series_len', 'series_sum': 'dv_series_sum',
    'series_mean': 'dv_series_mean', 'series_min': 'dv_series_min', 'series_max': 'dv_series_max',
    'series_var': 'dv_series_var', 'series_std': 'dv_series_std', 'series_scale': 'dv_series_scale',
    'series_add': 'dv_series_add', 'series_to_string': 'dv_series_to_string',
    'make_matrix': 'dv_make_matrix', 'matrix_identity': 'dv_matrix_identity',
    'matrix_get': 'dv_matrix_get', 'matrix_set': 'dv_matrix_set',
    'matrix_transpose': 'dv_matrix_transpose', 'matrix_add': 'dv_matrix_add',
    'matrix_scale': 'dv_matrix_scale', 'matrix_multiply': 'dv_matrix_multiply',
    'matrix_trace': 'dv_matrix_trace', 'matrix_norm': 'dv_matrix_norm',
    'matrix_to_string': 'dv_matrix_to_string',
    'make_vector': 'dv_make_vector', 'vector_zero': 'dv_vector_zero',
    'vector_add': 'dv_vector_add', 'vector_sub': 'dv_vector_sub',
    'vector_scale': 'dv_vector_scale', 'vector_dot': 'dv_vector_dot',
    'vector_norm': 'dv_vector_norm', 'vector_normalize': 'dv_vector_normalize',
    'vector_dist': 'dv_vector_dist', 'vector_to_string': 'dv_vector_to_string',
}

TYPE_MAP = {'Point': 'DvPoint', 'Series': 'DvSeries', 'Matrix': 'DvMatrix', 'Vector': 'DvVector'}

def find_psvm_pkgs():
    pkgs = []
    for dirpath, dirnames, filenames in os.walk(os.path.join(ROOT, 'src')):
        if 'moon.pkg' not in filenames or 'types' in dirpath:
            continue
        src_files = [f for f in filenames if f.endswith('.mbt')
                      and not f.endswith('_test.mbt')
                      and not f.endswith('smoke_test.mbt')
                      and not f.endswith('traits_impl.mbt')]
        if len(src_files) <= 1:
            continue
        if os.path.exists(os.path.join(dirpath, 'traits_impl.mbt')):
            continue
        for f in src_files:
            try:
                with open(os.path.join(dirpath, f), 'r', encoding='utf-8') as fh:
                    if 'pub struct' in fh.read() and 'make_point' in fh.read() if False else False:
                        pass
            except:
                pass
        # Check if any src file has PSVM
        has_psvm = False
        for f in src_files:
            try:
                with open(os.path.join(dirpath, f), 'r', encoding='utf-8') as fh:
                    content = fh.read()
                    if re.search(r'pub struct \w+Point\b', content):
                        has_psvm = True
                        break
            except:
                pass
        if has_psvm:
            pkgs.append(dirpath)
    return pkgs

def extract_fn_prefixes(filepath):
    """Extract PSVM function prefixes from a file by scanning function definitions."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    prefixes = set()
    for m in re.finditer(r'pub fn (\w+)', content):
        fn_name = m.group(1)
        for suffix in PSVM_SUFFIXES:
            if fn_name.endswith('_' + suffix):
                prefix = fn_name[:-(len(suffix) + 1)]
                prefixes.add(prefix)
                break
    return prefixes

def extract_struct_prefixes(filepath):
    """Extract struct name prefixes from a file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    prefixes = set()
    for typename in TYPE_MAP:
        for m in re.finditer(r'pub struct (\w+' + typename + r')\b', content):
            full = m.group(1)
            prefixes.add(full[:-len(typename)])
    return prefixes

def check_fields(filepath, struct_prefix):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    return (f'pub struct {struct_prefix}Point {{\n  x : Double\n  y : Double\n  label : Int32\n}}' in content
            and f'pub struct {struct_prefix}Series {{\n  vals : Array[Double]\n  name : String\n}}' in content
            and f'pub struct {struct_prefix}Matrix {{\n  data : Array[Array[Double]]\n  rows : Int32\n  cols : Int32\n}}' in content
            and f'pub struct {struct_prefix}Vector {{\n  comps : Array[Double]\n  dim : Int32\n}}' in content)

def skip_block(lines, i):
    depth = 0
    found_open = False
    while i < len(lines):
        for ch in lines[i]:
            if ch == '{':
                depth += 1
                found_open = True
            elif ch == '}':
                depth -= 1
        i += 1
        if found_open and depth == 0:
            break
    while i < len(lines) and lines[i].strip() == '':
        i += 1
    return i

def strip_doc_comments(result_lines):
    while result_lines and (result_lines[-1].strip().startswith('///') or result_lines[-1].strip() == ''):
        result_lines.pop()

def migrate_src_file(filepath, struct_prefixes, fn_prefixes):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    psvm_fn_names = set()
    for fp in fn_prefixes:
        for suffix in PSVM_SUFFIXES:
            psvm_fn_names.add(f'{fp}_{suffix}')
    
    struct_names = set()
    for sp in struct_prefixes:
        for typename in TYPE_MAP:
            struct_names.add(f'{sp}{typename}')
    
    result = []
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        
        is_struct = False
        if stripped.startswith('pub struct '):
            for sn in struct_names:
                if sn in stripped:
                    is_struct = True
                    break
        
        is_fn = False
        if stripped.startswith('pub fn ') or stripped.startswith('fn '):
            for fn in psvm_fn_names:
                pattern = r'(?<!\w)' + re.escape(fn) + r'(?!\w)'
                if re.search(pattern, stripped):
                    is_fn = True
                    break
        
        if is_struct or is_fn:
            strip_doc_comments(result)
            i = skip_block(lines, i)
            continue
        
        result.append(line)
        i += 1
    
    content = ''.join(result)
    
    # Replace type references
    for sp in struct_prefixes:
        for typename, dv_name in TYPE_MAP.items():
            full = f'{sp}{typename}'
            content = re.sub(r'(?<!\w)' + re.escape(full) + r'(?!\w)', f'@types.{dv_name}', content)
    
    # Replace function calls
    for fp in fn_prefixes:
        for suffix in PSVM_SUFFIXES:
            full = f'{fp}_{suffix}'
            dv_fn = DV_FUNCS[suffix]
            content = re.sub(r'(?<!\w)' + re.escape(full) + r'(?!\w)', f'@types.{dv_fn}', content)
    
    content = re.sub(r'\n{4,}', '\n\n\n', content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

def migrate_ref_file(filepath, struct_prefixes, fn_prefixes, pkg_name):
    """Replace references in test/smoke files without deleting definitions."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for fp in fn_prefixes:
        for suffix in PSVM_SUFFIXES:
            full = f'{fp}_{suffix}'
            dv_fn = DV_FUNCS[suffix]
            content = re.sub(r'@' + re.escape(pkg_name) + r'\.' + re.escape(full) + r'(?!\w)', f'@types.{dv_fn}', content)
            content = re.sub(r'(?<![@\w.])' + re.escape(full) + r'(?!\w)', f'@types.{dv_fn}', content)
    
    for sp in struct_prefixes:
        for typename, dv_name in TYPE_MAP.items():
            full = f'{sp}{typename}'
            content = re.sub(r'@' + re.escape(pkg_name) + r'\.' + re.escape(full) + r'(?!\w)', f'@types.{dv_name}', content)
            content = re.sub(r'(?<![@\w.])' + re.escape(full) + r'(?!\w)', f'@types.{dv_name}', content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

def update_moon_pkg(pkg_dir):
    pkg_path = os.path.join(pkg_dir, 'moon.pkg')
    with open(pkg_path, 'r', encoding='utf-8') as f:
        content = f.read()
    if TYPES_PKG in content:
        return
    content = content.replace('import {', f'import {{\n  "{TYPES_PKG}",', 1)
    with open(pkg_path, 'w', encoding='utf-8') as f:
        f.write(content)

def process_pkg(pkg_dir):
    all_files = sorted(os.listdir(pkg_dir))
    src_files = [f for f in all_files if f.endswith('.mbt')
                  and not f.endswith('_test.mbt')
                  and not f.endswith('smoke_test.mbt')
                  and not f.endswith('traits_impl.mbt')]
    
    # Collect all prefixes BEFORE modifying
    struct_prefixes = set()
    fn_prefixes = set()
    for f in src_files:
        filepath = os.path.join(pkg_dir, f)
        sps = extract_struct_prefixes(filepath)
        for sp in sps:
            if check_fields(filepath, sp):
                struct_prefixes.add(sp)
        fn_prefixes.update(extract_fn_prefixes(filepath))
    
    if not struct_prefixes:
        return 0
    
    migrated = 0
    for f in src_files:
        filepath = os.path.join(pkg_dir, f)
        old_size = os.path.getsize(filepath)
        migrate_src_file(filepath, struct_prefixes, fn_prefixes)
        new_size = os.path.getsize(filepath)
        if new_size < old_size:
            migrated += 1
    
    test_files = [f for f in all_files if f.endswith('.mbt')
                   and (f.endswith('_test.mbt') or f.endswith('smoke_test.mbt'))]
    pkg_name = os.path.basename(pkg_dir)
    for f in test_files:
        filepath = os.path.join(pkg_dir, f)
        migrate_ref_file(filepath, struct_prefixes, fn_prefixes, pkg_name)
    
    update_moon_pkg(pkg_dir)
    return migrated

def main():
    pkgs = find_psvm_pkgs()
    print(f"Found {len(pkgs)} multi-file packages with PSVM")
    
    total = 0
    for pkg in sorted(pkgs):
        rel = os.path.relpath(pkg, ROOT)
        count = process_pkg(pkg)
        if count > 0:
            print(f"  {rel}: {count} files")
            total += count
    
    print(f"Total: {total} files")

if __name__ == '__main__':
    main()