#!/usr/bin/env python3
"""批量生成MoonBit包的脚本"""
import os
import sys

def generate_package(base_dir, category, pkg_name, prefix, desc, sprint):
    """生成一个MoonBit包"""
    dir_path = os.path.join(base_dir, "src", category, pkg_name)
    os.makedirs(dir_path, exist_ok=True)

    # moon.pkg
    with open(os.path.join(dir_path, "moon.pkg"), "w", encoding="utf-8") as f:
        f.write(f"// {category}/{pkg_name} {desc}\n// {sprint} new\n")

    # .mbt file
    code = generate_code(prefix, desc, sprint)
    with open(os.path.join(dir_path, f"{pkg_name}.mbt"), "w", encoding="utf-8") as f:
        f.write(code)

    return len(code.split('\n'))

def generate_code(p, desc, sprint):
    """生成包代码，p是前缀"""
    P = p[0].upper() + p[1:]
    lines = []
    a = lines.append

    a(f"///===")
    a(f"/// {desc}")
    a(f"/// {sprint} new")
    a(f"")

    # Struct 1: Point
    a(f"pub struct {P}Point {{")
    a(f"  x : Double")
    a(f"  y : Double")
    a(f"  label : Int")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_make_point(x : Double, y : Double) -> {P}Point {{")
    a(f"  {{ x, y, label: 0 }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_make_labeled_point(x : Double, y : Double, label : Int) -> {P}Point {{")
    a(f"  {{ x, y, label }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_x(p : {P}Point) -> Double {{ p.x }}")
    a(f"")
    a(f"pub fn {p}_point_y(p : {P}Point) -> Double {{ p.y }}")
    a(f"")
    a(f"pub fn {p}_point_label(p : {P}Point) -> Int {{ p.label }}")
    a(f"")
    a(f"pub fn {p}_point_dist(a : {P}Point, b : {P}Point) -> Double {{")
    a(f"  let dx = a.x - b.x")
    a(f"  let dy = a.y - b.y")
    a(f"  {p}_sqrt(dx * dx + dy * dy)")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_add(a : {P}Point, b : {P}Point) -> {P}Point {{")
    a(f"  {{ x: a.x + b.x, y: a.y + b.y, label: a.label }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_sub(a : {P}Point, b : {P}Point) -> {P}Point {{")
    a(f"  {{ x: a.x - b.x, y: a.y - b.y, label: a.label }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_scale(pt : {P}Point, s : Double) -> {P}Point {{")
    a(f"  {{ x: pt.x * s, y: pt.y * s, label: pt.label }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_dot(a : {P}Point, b : {P}Point) -> Double {{")
    a(f"  a.x * b.x + a.y * b.y")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_norm(pt : {P}Point) -> Double {{")
    a(f"  {p}_sqrt(pt.x * pt.x + pt.y * pt.y)")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_point_to_string(pt : {P}Point) -> String {{")
    a(f"  \"(\" + {p}_dbl(pt.x) + \", \" + {p}_dbl(pt.y) + \")[\" + pt.label.to_string() + \"]\"")
    a(f"}}")
    a(f"")

    # Struct 2: Series
    a(f"pub struct {P}Series {{")
    a(f"  vals : Array[Double]")
    a(f"  name : String")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_make_series(vals : Array[Double], name : String) -> {P}Series {{")
    a(f"  {{ vals, name }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_len(s : {P}Series) -> Int {{ s.vals.length() }}")
    a(f"")
    a(f"pub fn {p}_series_sum(s : {P}Series) -> Double {{")
    a(f"  let mut total = 0.0")
    a(f"  for i in 0..<s.vals.length() {{ total = total + s.vals[i] }}")
    a(f"  total")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_mean(s : {P}Series) -> Double {{")
    a(f"  let n = {p}_series_len(s)")
    a(f"  if n == 0 {{ 0.0 }} else {{ {p}_series_sum(s) / n.to_double() }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_min(s : {P}Series) -> Double {{")
    a(f"  let n = {p}_series_len(s)")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut m = s.vals[0]")
    a(f"    for i in 1..<n {{ if s.vals[i] < m {{ m = s.vals[i] }} }}")
    a(f"    m")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_max(s : {P}Series) -> Double {{")
    a(f"  let n = {p}_series_len(s)")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut m = s.vals[0]")
    a(f"    for i in 1..<n {{ if s.vals[i] > m {{ m = s.vals[i] }} }}")
    a(f"    m")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_var(s : {P}Series) -> Double {{")
    a(f"  let n = {p}_series_len(s)")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let m = {p}_series_mean(s)")
    a(f"    let mut total = 0.0")
    a(f"    for i in 0..<n {{ let d = s.vals[i] - m; total = total + d * d }}")
    a(f"    total / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_std(s : {P}Series) -> Double {{ {p}_sqrt({p}_series_var(s)) }}")
    a(f"")
    a(f"pub fn {p}_series_scale(s : {P}Series, f : Double) -> {P}Series {{")
    a(f"  let mut result = []")
    a(f"  for i in 0..<s.vals.length() {{ result = {p}_push(result, s.vals[i] * f) }}")
    a(f"  {{ vals: result, name: s.name }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_add(a : {P}Series, b : {P}Series) -> {P}Series {{")
    a(f"  let n = if a.vals.length() < b.vals.length() {{ a.vals.length() }} else {{ b.vals.length() }}")
    a(f"  let mut result = []")
    a(f"  for i in 0..<n {{ result = {p}_push(result, a.vals[i] + b.vals[i]) }}")
    a(f"  {{ vals: result, name: a.name + \"+\" + b.name }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_series_to_string(s : {P}Series) -> String {{")
    a(f"  let mut result = s.name + \"[\"")
    a(f"  let n = s.vals.length()")
    a(f"  let lim = if n < 10 {{ n }} else {{ 10 }}")
    a(f"  for i in 0..<lim {{ if i > 0 {{ result = result + \", \" }}; result = result + {p}_dbl(s.vals[i]) }}")
    a(f"  if n > 10 {{ result + \"...]\" }} else {{ result + \"]\" }}")
    a(f"}}")
    a(f"")

    # Struct 3: Matrix
    a(f"pub struct {P}Matrix {{")
    a(f"  data : Array[Array[Double]]")
    a(f"  rows : Int")
    a(f"  cols : Int")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_make_matrix(rows : Int, cols : Int, val : Double) -> {P}Matrix {{")
    a(f"  let data = Array::make(rows, Array::make(cols, val))")
    a(f"  for i in 0..<rows {{ data[i] = Array::make(cols, val) }}")
    a(f"  {{ data, rows, cols }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_identity(n : Int) -> {P}Matrix {{")
    a(f"  let m = {p}_make_matrix(n, n, 0.0)")
    a(f"  for i in 0..<n {{ m.data[i][i] = 1.0 }}")
    a(f"  m")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_get(m : {P}Matrix, i : Int, j : Int) -> Double {{")
    a(f"  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {{ 0.0 }} else {{ m.data[i][j] }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_transpose(m : {P}Matrix) -> {P}Matrix {{")
    a(f"  let result = {p}_make_matrix(m.cols, m.rows, 0.0)")
    a(f"  for i in 0..<m.rows {{ for j in 0..<m.cols {{ result.data[j][i] = m.data[i][j] }} }}")
    a(f"  result")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_add(a : {P}Matrix, b : {P}Matrix) -> {P}Matrix {{")
    a(f"  if a.rows != b.rows || a.cols != b.cols {{ return a }}")
    a(f"  let result = {p}_make_matrix(a.rows, a.cols, 0.0)")
    a(f"  for i in 0..<a.rows {{ for j in 0..<a.cols {{ result.data[i][j] = a.data[i][j] + b.data[i][j] }} }}")
    a(f"  result")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_scale(m : {P}Matrix, s : Double) -> {P}Matrix {{")
    a(f"  let result = {p}_make_matrix(m.rows, m.cols, 0.0)")
    a(f"  for i in 0..<m.rows {{ for j in 0..<m.cols {{ result.data[i][j] = m.data[i][j] * s }} }}")
    a(f"  result")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_multiply(a : {P}Matrix, b : {P}Matrix) -> {P}Matrix {{")
    a(f"  if a.cols != b.rows {{ return {p}_make_matrix(a.rows, b.cols, 0.0) }}")
    a(f"  let result = {p}_make_matrix(a.rows, b.cols, 0.0)")
    a(f"  for i in 0..<a.rows {{")
    a(f"    for j in 0..<b.cols {{")
    a(f"      let mut sum = 0.0")
    a(f"      for k in 0..<a.cols {{ sum = sum + a.data[i][k] * b.data[k][j] }}")
    a(f"      result.data[i][j] = sum")
    a(f"    }}")
    a(f"  }}")
    a(f"  result")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_trace(m : {P}Matrix) -> Double {{")
    a(f"  let n = if m.rows < m.cols {{ m.rows }} else {{ m.cols }}")
    a(f"  let mut sum = 0.0")
    a(f"  for i in 0..<n {{ sum = sum + m.data[i][i] }}")
    a(f"  sum")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_norm(m : {P}Matrix) -> Double {{")
    a(f"  let mut sum = 0.0")
    a(f"  for i in 0..<m.rows {{ for j in 0..<m.cols {{ sum = sum + m.data[i][j] * m.data[i][j] }} }}")
    a(f"  {p}_sqrt(sum)")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_matrix_to_string(m : {P}Matrix) -> String {{")
    a(f"  let mut result = \"Mat(\" + m.rows.to_string() + \"x\" + m.cols.to_string() + \")\\n\"")
    a(f"  let rl = if m.rows < 5 {{ m.rows }} else {{ 5 }}")
    a(f"  let cl = if m.cols < 5 {{ m.cols }} else {{ 5 }}")
    a(f"  for i in 0..<rl {{")
    a(f"    result = result + \"  [\"")
    a(f"    for j in 0..<cl {{ if j > 0 {{ result = result + \", \" }}; result = result + {p}_dbl(m.data[i][j]) }}")
    a(f"    result = result + \"]\\n\"")
    a(f"  }}")
    a(f"  result")
    a(f"}}")
    a(f"")

    # Struct 4: Vector
    a(f"pub struct {P}Vector {{")
    a(f"  comps : Array[Double]")
    a(f"  dim : Int")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_make_vector(comps : Array[Double]) -> {P}Vector {{")
    a(f"  {{ comps, dim: comps.length() }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_zero(dim : Int) -> {P}Vector {{")
    a(f"  {{ comps: Array::make(dim, 0.0), dim }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_add(a : {P}Vector, b : {P}Vector) -> {P}Vector {{")
    a(f"  let n = if a.dim < b.dim {{ a.dim }} else {{ b.dim }}")
    a(f"  let mut result = []")
    a(f"  for i in 0..<n {{ result = {p}_push(result, a.comps[i] + b.comps[i]) }}")
    a(f"  {{ comps: result, dim: n }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_sub(a : {P}Vector, b : {P}Vector) -> {P}Vector {{")
    a(f"  let n = if a.dim < b.dim {{ a.dim }} else {{ b.dim }}")
    a(f"  let mut result = []")
    a(f"  for i in 0..<n {{ result = {p}_push(result, a.comps[i] - b.comps[i]) }}")
    a(f"  {{ comps: result, dim: n }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_scale(v : {P}Vector, s : Double) -> {P}Vector {{")
    a(f"  let mut result = []")
    a(f"  for i in 0..<v.dim {{ result = {p}_push(result, v.comps[i] * s) }}")
    a(f"  {{ comps: result, dim: v.dim }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_dot(a : {P}Vector, b : {P}Vector) -> Double {{")
    a(f"  let n = if a.dim < b.dim {{ a.dim }} else {{ b.dim }}")
    a(f"  let mut sum = 0.0")
    a(f"  for i in 0..<n {{ sum = sum + a.comps[i] * b.comps[i] }}")
    a(f"  sum")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_norm(v : {P}Vector) -> Double {{ {p}_sqrt({p}_vector_dot(v, v)) }}")
    a(f"")
    a(f"pub fn {p}_vector_normalize(v : {P}Vector) -> {P}Vector {{")
    a(f"  let n = {p}_vector_norm(v)")
    a(f"  if n < 0.0000001 {{ v }} else {{ {p}_vector_scale(v, 1.0 / n) }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_dist(a : {P}Vector, b : {P}Vector) -> Double {{")
    a(f"  {p}_vector_norm({p}_vector_sub(a, b))")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_vector_to_string(v : {P}Vector) -> String {{")
    a(f"  let mut result = \"[\"")
    a(f"  let lim = if v.dim < 10 {{ v.dim }} else {{ 10 }}")
    a(f"  for i in 0..<lim {{ if i > 0 {{ result = result + \", \" }}; result = result + {p}_dbl(v.comps[i]) }}")
    a(f"  if v.dim > 10 {{ result + \"...]\" }} else {{ result + \"]\" }}")
    a(f"}}")
    a(f"")

    # Stats functions
    a(f"pub fn {p}_mean(data : Array[Double]) -> Double {{")
    a(f"  let n = data.length()")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut sum = 0.0")
    a(f"    for i in 0..<n {{ sum = sum + data[i] }}")
    a(f"    sum / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_var(data : Array[Double]) -> Double {{")
    a(f"  let n = data.length()")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let m = {p}_mean(data)")
    a(f"    let mut sum = 0.0")
    a(f"    for i in 0..<n {{ let d = data[i] - m; sum = sum + d * d }}")
    a(f"    sum / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_std(data : Array[Double]) -> Double {{ {p}_sqrt({p}_var(data)) }}")
    a(f"")
    a(f"pub fn {p}_cov(a : Array[Double], b : Array[Double]) -> Double {{")
    a(f"  let n = if a.length() < b.length() {{ a.length() }} else {{ b.length() }}")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let ma = {p}_mean(a); let mb = {p}_mean(b)")
    a(f"    let mut sum = 0.0")
    a(f"    for i in 0..<n {{ sum = sum + (a[i] - ma) * (b[i] - mb) }}")
    a(f"    sum / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_corr(a : Array[Double], b : Array[Double]) -> Double {{")
    a(f"  let sa = {p}_std(a); let sb = {p}_std(b)")
    a(f"  if sa < 0.0000001 || sb < 0.0000001 {{ 0.0 }} else {{ {p}_cov(a, b) / (sa * sb) }}")
    a(f"}}")
    a(f"")

    # Metrics
    a(f"pub fn {p}_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut correct = 0")
    a(f"    for i in 0..<n {{ if pred[i] == labels[i] {{ correct = correct + 1 }} }}")
    a(f"    correct.to_double() / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_mse(pred : Array[Double], labels : Array[Double]) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut sum = 0.0")
    a(f"    for i in 0..<n {{ let d = pred[i] - labels[i]; sum = sum + d * d }}")
    a(f"    sum / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_mae(pred : Array[Double], labels : Array[Double]) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let mut sum = 0.0")
    a(f"    for i in 0..<n {{ sum = sum + {p}_abs(pred[i] - labels[i]) }}")
    a(f"    sum / n.to_double()")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_r2(pred : Array[Double], labels : Array[Double]) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  if n == 0 {{ 0.0 }} else {{")
    a(f"    let lm = {p}_mean(labels)")
    a(f"    let mut ss_res = 0.0; let mut ss_tot = 0.0")
    a(f"    for i in 0..<n {{ let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }}")
    a(f"    if ss_tot < 0.0000001 {{ 0.0 }} else {{ 1.0 - ss_res / ss_tot }}")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  let mut tp = 0; let mut fp = 0")
    a(f"  for i in 0..<n {{ if pred[i] == pos {{ if labels[i] == pos {{ tp = tp + 1 }} else {{ fp = fp + 1 }} }} }}")
    a(f"  if tp + fp == 0 {{ 0.0 }} else {{ tp.to_double() / (tp + fp).to_double() }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{")
    a(f"  let n = if pred.length() < labels.length() {{ pred.length() }} else {{ labels.length() }}")
    a(f"  let mut tp = 0; let mut fn_ = 0")
    a(f"  for i in 0..<n {{ if labels[i] == pos {{ if pred[i] == pos {{ tp = tp + 1 }} else {{ fn_ = fn_ + 1 }} }} }}")
    a(f"  if tp + fn_ == 0 {{ 0.0 }} else {{ tp.to_double() / (tp + fn_).to_double() }}")
    a(f"}}")
    a(f"")
    a(f"pub fn {p}_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{")
    a(f"  let p_ = {p}_precision(pred, labels, pos); let r = {p}_recall(pred, labels, pos)")
    a(f"  if p_ + r < 0.0000001 {{ 0.0 }} else {{ 2.0 * p_ * r / (p_ + r) }}")
    a(f"}}")
    a(f"")

    # Helper functions
    a(f"fn {p}_sqrt(x : Double) -> Double {{")
    a(f"  if x <= 0.0 {{ 0.0 }} else {{")
    a(f"    let mut g = x / 2.0")
    a(f"    if g < 1.0 {{ g = 1.0 }}")
    a(f"    for _ in 0..<50 {{ g = (g + x / g) / 2.0 }}")
    a(f"    g")
    a(f"  }}")
    a(f"}}")
    a(f"")
    a(f"fn {p}_abs(x : Double) -> Double {{ if x < 0.0 {{ -x }} else {{ x }} }}")
    a(f"")
    a(f"fn {p}_dbl(x : Double) -> String {{")
    a(f"  let i = if x >= 0.0 {{ {p}_int(x) }} else {{ -{p}_int(-x) }}")
    a(f"  let f = x - i.to_double()")
    a(f"  let fi = if f >= 0.0 {{ {p}_int(f * 1000000.0) }} else {{ {p}_int(-f * 1000000.0) }}")
    a(f"  i.to_string() + \".\" + fi.to_string()")
    a(f"}}")
    a(f"")
    a(f"fn {p}_int(x : Double) -> Int {{")
    a(f"  let mut n = 0; let mut d = x")
    a(f"  while d >= 1.0 {{ n = n + 1; d = d - 1.0 }}")
    a(f"  n")
    a(f"}}")
    a(f"")
    a(f"fn {p}_push(arr : Array[Double], v : Double) -> Array[Double] {{")
    a(f"  let n = arr.length()")
    a(f"  let result = Array::make(n + 1, 0.0)")
    a(f"  for i in 0..<n {{ result[i] = arr[i] }}")
    a(f"  result[n] = v")
    a(f"  result")
    a(f"}}")

    return '\n'.join(lines) + '\n'

def main():
    base_dir = r"D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse"

    # 定义要创建的包
    categories = {
        "opcore": ["linalg", "num_analysis", "diff_eq", "integral", "special_func",
                   "approx_theory", "orthogonal_poly", "series_analysis", "fourier_analysis",
                   "laplace_transform", "z_transform", "wavelet_dwt", "wavelet_cwt",
                   "filter_fir", "filter_iir", "filter_adaptive", "spectral_est",
                   "param_model", "stochastic_proc", "markov_chain", "queue_theory",
                   "game_theory", "info_theory", "coding_theory", "crypto_hash",
                   "crypto_sign", "crypto_pkc", "crypto_skc", "crypto_mac",
                   "error_code", "seq_analysis", "autocorr", "cross_corr",
                   "cepstral", "homomorphic", "pitch_detect", "voice_activity",
                   "echo_cancel", "noise_reduce", "beamforming", "source_loc",
                   "doppler", "radar_proc", "sonar_proc", "lidar_proc",
                   "image_restoration", "image_registration", "image_stitch",
                   "panorama", "hdr", "tone_map", "color_space", "color_correct",
                   "white_balance", "demosaic", "deblur", "super_res",
                   "inpaint", "denoise_nl", "denoise_bm", "denoise_wavelet"],
        "learncore": ["elm", "rbf_net", "som", "neural_gas", "art_model",
                      "fuzzy_nn", "genetic_prog", "genetic_alg", "de_ea", "pso_swarm",
                      "aco_colony", "bee_alg", "firefly", "bat_alg", "cuckoo",
                      "wolf_pack", "flower_poll", "harmony_search", "tabu_search",
                      "sim_anneal", "memetic", "nsga2", "moea_d", "spea2",
                      "knn_reg", "kernel_ridge", "gaussian_proc", "tpr_forest",
                      "xgboost", "lightgbm", "catboost", "adaboost",
                      "logit_boost", "grad_boost", "iso_forest", "ocsvm",
                      "svdd", "lpd", "mkd", "prototype", "lvq",
                      "artmap", "fuzzy_art", "boosting_rt", "bagging_rt",
                      "stacking_rt", "voting_rt", "mlp_rt", "cnn_rt",
                      "rnn_rt", "lstm_rt", "gru_rt", "transformer_rt",
                      "autoencoder_rt", "vae_rt", "gan_rt", "diffusion_rt"],
        "agent_kit": ["goal_stack", "belief_state", "desire_model", "intention_plan",
                      "bdi_agent", "react_agent", "hybrid_agent", "learning_agent",
                      "mobile_agent", "holonic_agent", "org_agent", "norm_agent",
                      "emotion_model", "personality", "social_sim", "crowd_sim",
                      "traffic_sim", "epidemic_sim", "economic_sim", "climate_sim",
                      "game_sim", "physics_sim", "chemistry_sim", "biology_sim",
                      "robotics_sim", "uav_control", "auto_drive", "path_follow",
                      "obstacle_avoid", "slam_basic", "slam_graph", "slam_particle",
                      "motion_plan", "task_alloc", "resource_alloc", "schedule_opt",
                      "workflow_eng", "state_machine", "petri_net", "temporal_logic",
                      "model_check", "theorem_prove", "sat_solver", "smt_solver",
                      "constraint_sat", "optim_sat", "planning_htn", "planning_causal"],
        "dataobject": ["graph_store", "tree_store", "kv_store", "doc_store",
                       "time_store", "spatial_store", "tensor_store", "series_store",
                       "matrix_store", "frame_store", "table_store", "column_store",
                       "row_store", "block_store", "seg_store", "part_store",
                       "index_btree", "index_hash", "index_lsm", "index_rtree",
                       "index_bitmap", "index_invert", "index_gpu", "index_vector",
                       "compress_lz4", "compress_zstd", "compress_snappy", "compress_brotli",
                       "encode_avro", "encode_protobuf", "encode_thrift", "encode_msgpack",
                       "encode_json", "encode_xml", "encode_yaml", "encode_toml",
                       "encode_csv", "encode_parquet", "encode_orc", "encode_arrow"],
        "datatemporal": ["window_tumble", "window_slide", "window_session",
                         "window_global", "window_count", "window_time",
                         "trigger_count", "trigger_time", "trigger_watermark",
                         "trigger_early", "trigger_late", "watermark_periodic",
                         "watermark_punct", "checkpoint_sync", "checkpoint_async",
                         "savepoint", "restore_op", "backpressure", "load_shed",
                         "circuit_break", "retry_op", "timeout_op", "bulkhead",
                         "rate_limit", "throttle", "queue_buf", "pipe_buf"],
    }

    total_lines = 0
    pkg_count = 0
    sprint_idx = 1

    for category, packages in categories.items():
        for pkg_name in packages:
            prefix = pkg_name
            desc = f"{category}/{pkg_name}"
            sprint = f"S13.{sprint_idx}"
            sprint_idx += 1

            try:
                lines = generate_package(base_dir, category, pkg_name, prefix, desc, sprint)
                total_lines += lines
                pkg_count += 1
            except Exception as e:
                print(f"ERROR generating {category}/{pkg_name}: {e}")

    print(f"Generated {pkg_count} packages, ~{total_lines} lines")

if __name__ == "__main__":
    main()