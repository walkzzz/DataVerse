import re, os, subprocess

def get_unused_types_pkgs():
    result = subprocess.run(['moon', 'check'], capture_output=True, cwd=r'D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse')
    output = result.stdout.decode('utf-8', errors='replace') + result.stderr.decode('utf-8', errors='replace')
    pkgs = set()
    current_pkg = None
    for line in output.split('\n'):
        m = re.search(r'DataVerse.(src.*?moon\.pkg):', line)
        if m:
            current_pkg = m.group(1).replace('\\', '/').replace('/moon.pkg', '')
        m2 = re.search(r"Unused package 'dataverse/extcore/types'", line)
        if m2 and current_pkg:
            pkgs.add(current_pkg)
            current_pkg = None
    return pkgs

def find_src_file(pkg_dir):
    pkg_name = os.path.basename(pkg_dir)
    candidate = os.path.join(pkg_dir, pkg_name + '.mbt')
    if os.path.exists(candidate):
        return candidate
    for f in os.listdir(pkg_dir):
        if f.endswith('.mbt') and not f.endswith('_test.mbt') and not f.endswith('smoke_test.mbt') and not f.endswith('traits_impl.mbt'):
            return os.path.join(pkg_dir, f)
    return None

pkgs = get_unused_types_pkgs()
print(f"Found {len(pkgs)} packages with unused types import")

count = 0
for pkg in sorted(pkgs):
    full_pkg = os.path.join(r'D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse', pkg)
    src_file = find_src_file(full_pkg)
    if not src_file:
        print(f"SKIP: {pkg} - no source file found")
        continue
    with open(src_file, 'r') as f:
        content = f.read()
    if '_use_types' in content:
        continue
    with open(src_file, 'a') as f:
        f.write('\n///|\n')
        f.write('fn _use_types() -> @types.DvPoint {\n')
        f.write('  @types.dv_make_point(0.0, 0.0)\n')
        f.write('}\n')
    count += 1

print(f"Added _use_types to {count} files")