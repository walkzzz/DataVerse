import re, os, subprocess

def get_unused_funcs():
    result = subprocess.run(['moon', 'check'], capture_output=True, cwd=r'D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse')
    output = result.stdout.decode('utf-8', errors='replace') + result.stderr.decode('utf-8', errors='replace')
    funcs = []
    current_file = None
    current_line = None
    for line in output.split('\n'):
        m = re.search(r'DataVerse.(src.*?\.mbt):(\d+):', line)
        if m:
            path = m.group(1).replace('\\', '/')
            current_file = path
            current_line = int(m.group(2))
        m2 = re.search(r"Unused function '(\w+)'", line)
        if m2 and current_file and current_line:
            funcs.append((current_file, current_line, m2.group(1)))
    return funcs

def delete_func(filepath, start_line, func_name):
    with open(filepath, 'r') as f:
        lines = f.readlines()
    idx = start_line - 1
    if idx >= len(lines) or func_name not in lines[idx]:
        print(f"SKIP: {filepath}:{start_line} - func {func_name} not found")
        return False
    depth = 0
    end_idx = idx
    found_open = False
    for i in range(idx, len(lines)):
        for ch in lines[i]:
            if ch == '{':
                depth += 1
                found_open = True
            elif ch == '}':
                depth -= 1
        if found_open and depth == 0:
            end_idx = i
            break
    if idx > 0 and lines[idx-1].strip() == '///|':
        start_del = idx - 1
    else:
        start_del = idx
    del lines[start_del:end_idx+1]
    if start_del < len(lines) and lines[start_del].strip() == '':
        del lines[start_del]
    with open(filepath, 'w') as f:
        f.writelines(lines)
    return True

funcs = get_unused_funcs()
print(f"Found {len(funcs)} unused functions")
count = 0
for filepath, line, name in funcs:
    full_path = os.path.join(r'D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse', filepath)
    if delete_func(full_path, line, name):
        count += 1
print(f"Deleted {count} functions")