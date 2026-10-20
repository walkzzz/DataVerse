#!/usr/bin/env python3
"""生成有语义包名的 MoonBit 包，按领域×子领域组织。"""
import os

def gen_code(p, desc):
    """生成包代码，p是前缀（包名），desc是描述。"""
    P = p[0].upper() + p[1:].replace("_", "")
    L = []
    w = L.append

    w("///===")
    w(f"/// {desc}")
    w("")

    # === Struct 1: Point ===
    w(f"pub(all) struct {P}Point {{")
    w("  x : Double")
    w("  y : Double")
    w("  z : Double")
    w("  label : Int")
    w("}")
    w("")
    w(f"pub fn {p}_make_point(x : Double, y : Double) -> {P}Point {{")
    w("  { x, y, z: 0.0, label: 0 }")
    w("}")
    w("")
    w(f"pub fn {p}_make_point3(x : Double, y : Double, z : Double) -> {P}Point {{")
    w("  { x, y, z, label: 0 }")
    w("}")
    w("")
    w(f"pub fn {P}Point::x(self : {P}Point) -> Double {{ self.x }}")
    w("")
    w(f"pub fn {P}Point::y(self : {P}Point) -> Double {{ self.y }}")
    w("")
    w(f"pub fn {P}Point::z(self : {P}Point) -> Double {{ self.z }}")
    w("")
    w(f"pub fn {P}Point::label(self : {P}Point) -> Int {{ self.label }}")
    w("")
    w(f"pub fn {P}Point::dist(self : {P}Point, other : {P}Point) -> Double {{")
    w("  let dx = self.x - other.x")
    w("  let dy = self.y - other.y")
    w("  let dz = self.z - other.z")
    w(f"  @_common.sqrt(dx * dx + dy * dy + dz * dz)")
    w("}")
    w("")
    w(f"pub fn {P}Point::add(self : {P}Point, other : {P}Point) -> {P}Point {{")
    w("  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::sub(self : {P}Point, other : {P}Point) -> {P}Point {{")
    w("  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::scale(self : {P}Point, s : Double) -> {P}Point {{")
    w("  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::dot(self : {P}Point, other : {P}Point) -> Double {{")
    w("  self.x * other.x + self.y * other.y + self.z * other.z")
    w("}")
    w("")
    w(f"pub fn {P}Point::cross(self : {P}Point, other : {P}Point) -> {P}Point {{")
    w("  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }")
    w("}")
    w("")
    w(f"pub fn {P}Point::norm(self : {P}Point) -> Double {{")
    w(f"  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)")
    w("}")
    w("")
    w(f"pub fn {P}Point::normalize(self : {P}Point) -> {P}Point {{")
    w("  let n = self.norm()")
    w("  if n < 0.0000001 { self } else { self.scale(1.0 / n) }")
    w("}")
    w("")
    w(f"pub fn {P}Point::negate(self : {P}Point) -> {P}Point {{")
    w("  { x: -self.x, y: -self.y, z: -self.z, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::mid(self : {P}Point, other : {P}Point) -> {P}Point {{")
    w("  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::lerp(self : {P}Point, other : {P}Point, t : Double) -> {P}Point {{")
    w("  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }")
    w("}")
    w("")
    w(f"pub fn {P}Point::to_string(self : {P}Point) -> String {{")
    w(f"  \"(\" + @_common.dbl(self.x) + \", \" + @_common.dbl(self.y) + \", \" + @_common.dbl(self.z) + \")[\" + self.label.to_string() + \"]\"")
    w("}")
    w("")

    # === Struct 2: Series ===
    w(f"pub(all) struct {P}Series {{")
    w("  vals : Array[Double]")
    w("  name : String")
    w("  meta : Int")
    w("}")
    w("")
    w(f"pub fn {p}_make_series(vals : Array[Double], name : String) -> {P}Series {{")
    w("  { vals, name, meta: 0 }")
    w("}")
    w("")
    w(f"pub fn {P}Series::len(self : {P}Series) -> Int {{ self.vals.length() }}")
    w("")
    w(f"pub fn {P}Series::sum(self : {P}Series) -> Double {{ @_common.sum(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::mean(self : {P}Series) -> Double {{ @_common.mean(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::min(self : {P}Series) -> Double {{ @_common.min(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::max(self : {P}Series) -> Double {{ @_common.max(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::range(self : {P}Series) -> Double {{")
    w(f"  @_common.max(self.vals) - @_common.min(self.vals)")
    w("}")
    w("")
    w(f"pub fn {P}Series::variance(self : {P}Series) -> Double {{ @_common.variance(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::std(self : {P}Series) -> Double {{ @_common.std(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::median(self : {P}Series) -> Double {{ @_common.median(self.vals) }}")
    w("")
    w(f"pub fn {P}Series::scale(self : {P}Series, f : Double) -> {P}Series {{")
    w("  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }")
    w("}")
    w("")
    w(f"pub fn {P}Series::add(self : {P}Series, other : {P}Series) -> {P}Series {{")
    w("  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + \"+\" + other.name, meta: self.meta }")
    w("}")
    w("")
    w(f"pub fn {P}Series::sub(self : {P}Series, other : {P}Series) -> {P}Series {{")
    w("  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + \"-\" + other.name, meta: self.meta }")
    w("}")
    w("")
    w(f"pub fn {P}Series::normalize(self : {P}Series) -> {P}Series {{")
    w("  let mn = self.min()")
    w("  let mx = self.max()")
    w("  let r = mx - mn")
    w(f"  if r < 0.0000001 {{ self }} else {{")
    w("    let result = []")
    w(f"    for i in 0..<self.vals.length() {{ result.push((self.vals[i] - mn) / r) }}")
    w("    { vals: result, name: self.name, meta: self.meta }")
    w("  }")
    w("}")
    w("")
    w(f"pub fn {P}Series::cumsum(self : {P}Series) -> {P}Series {{")
    w("  { vals: @_common.cumsum(self.vals), name: self.name + \"_cumsum\", meta: self.meta }")
    w("}")
    w("")
    w(f"pub fn {P}Series::to_string(self : {P}Series) -> String {{")
    w("  let mut result = self.name + \"[\"")
    w("  let n = self.vals.length()")
    w("  let lim = if n < 10 { n } else { 10 }")
    w(f"  for i in 0..<lim {{ if i > 0 {{ result = result + \", \" }}; result = result + @_common.dbl(self.vals[i]) }}")
    w("  if n > 10 { result + \"...]\" } else { result + \"]\" }")
    w("}")
    w("")

    # === Struct 3: Matrix ===
    w(f"pub(all) struct {P}Matrix {{")
    w("  data : Array[Array[Double]]")
    w("  rows : Int")
    w("  cols : Int")
    w("}")
    w("")
    w(f"pub fn {p}_make_matrix(rows : Int, cols : Int, val : Double) -> {P}Matrix {{")
    w("  let data = Array::make(rows, Array::make(cols, val))")
    w("  for i in 0..<rows { data[i] = Array::make(cols, val) }")
    w("  { data, rows, cols }")
    w("}")
    w("")
    w(f"pub fn {p}_matrix_identity(n : Int) -> {P}Matrix {{")
    w(f"  let m = {p}_make_matrix(n, n, 0.0)")
    w("  for i in 0..<n { m.data[i][i] = 1.0 }")
    w("  m")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::get(self : {P}Matrix, i : Int, j : Int) -> Double {{")
    w("  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::transpose(self : {P}Matrix) -> {P}Matrix {{")
    w(f"  let result = {p}_make_matrix(self.cols, self.rows, 0.0)")
    w("  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }")
    w("  result")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::add(self : {P}Matrix, other : {P}Matrix) -> {P}Matrix {{")
    w("  if self.rows != other.rows || self.cols != other.cols { return self }")
    w(f"  let result = {p}_make_matrix(self.rows, self.cols, 0.0)")
    w("  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }")
    w("  result")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::scale(self : {P}Matrix, s : Double) -> {P}Matrix {{")
    w(f"  let result = {p}_make_matrix(self.rows, self.cols, 0.0)")
    w("  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }")
    w("  result")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::multiply(self : {P}Matrix, other : {P}Matrix) -> {P}Matrix {{")
    w(f"  if self.cols != other.rows {{ return {p}_make_matrix(self.rows, other.cols, 0.0) }}")
    w(f"  let result = {p}_make_matrix(self.rows, other.cols, 0.0)")
    w("  for i in 0..<self.rows {")
    w("    for j in 0..<other.cols {")
    w("      let mut sum = 0.0")
    w("      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }")
    w("      result.data[i][j] = sum")
    w("    }")
    w("  }")
    w("  result")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::trace(self : {P}Matrix) -> Double {{")
    w("  let n = if self.rows < self.cols { self.rows } else { self.cols }")
    w("  let mut sum = 0.0")
    w("  for i in 0..<n { sum = sum + self.data[i][i] }")
    w("  sum")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::det(self : {P}Matrix) -> Double {{")
    w("  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {")
    w("    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]")
    w("  } else if self.rows == 3 {")
    w("    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])")
    w("    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])")
    w("    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])")
    w("    a - b + c")
    w("  } else { 0.0 }")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::norm(self : {P}Matrix) -> Double {{")
    w("  let mut sum = 0.0")
    w("  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }")
    w(f"  @_common.sqrt(sum)")
    w("}")
    w("")
    w(f"pub fn {P}Matrix::to_string(self : {P}Matrix) -> String {{")
    w("  let mut result = \"Mat(\" + self.rows.to_string() + \"x\" + self.cols.to_string() + \")\\n\"")
    w("  let rl = if self.rows < 5 { self.rows } else { 5 }")
    w("  let cl = if self.cols < 5 { self.cols } else { 5 }")
    w("  for i in 0..<rl {")
    w("    result = result + \"  [\"")
    w(f"    for j in 0..<cl {{ if j > 0 {{ result = result + \", \" }}; result = result + @_common.dbl(self.data[i][j]) }}")
    w("    result = result + \"]\\n\"")
    w("  }")
    w("  result")
    w("}")
    w("")

    # === Struct 4: Vector ===
    w(f"pub(all) struct {P}Vector {{")
    w("  comps : Array[Double]")
    w("  dim : Int")
    w("}")
    w("")
    w(f"pub fn {p}_make_vector(comps : Array[Double]) -> {P}Vector {{")
    w("  { comps, dim: comps.length() }")
    w("}")
    w("")
    w(f"pub fn {p}_vector_zero(dim : Int) -> {P}Vector {{")
    w("  { comps: Array::make(dim, 0.0), dim }")
    w("}")
    w("")
    w(f"pub fn {P}Vector::add(self : {P}Vector, other : {P}Vector) -> {P}Vector {{")
    w("  let n = if self.dim < other.dim { self.dim } else { other.dim }")
    w("  { comps: @_common.add_arr(self.comps, other.comps), dim: n }")
    w("}")
    w("")
    w(f"pub fn {P}Vector::sub(self : {P}Vector, other : {P}Vector) -> {P}Vector {{")
    w("  let n = if self.dim < other.dim { self.dim } else { other.dim }")
    w("  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }")
    w("}")
    w("")
    w(f"pub fn {P}Vector::scale(self : {P}Vector, s : Double) -> {P}Vector {{")
    w("  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }")
    w("}")
    w("")
    w(f"pub fn {P}Vector::dot(self : {P}Vector, other : {P}Vector) -> Double {{")
    w("  let n = if self.dim < other.dim { self.dim } else { other.dim }")
    w("  let mut sum = 0.0")
    w("  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }")
    w("  sum")
    w("}")
    w("")
    w(f"pub fn {P}Vector::norm(self : {P}Vector) -> Double {{ self.dot(self) |> @_common.sqrt }}")
    w("")
    w(f"pub fn {P}Vector::normalize(self : {P}Vector) -> {P}Vector {{")
    w("  let n = self.norm()")
    w("  if n < 0.0000001 { self } else { self.scale(1.0 / n) }")
    w("}")
    w("")
    w(f"pub fn {P}Vector::dist(self : {P}Vector, other : {P}Vector) -> Double {{")
    w("  self.sub(other).norm()")
    w("}")
    w("")
    w(f"pub fn {P}Vector::to_string(self : {P}Vector) -> String {{")
    w("  let mut result = \"[\"")
    w("  let lim = if self.dim < 10 { self.dim } else { 10 }")
    w(f"  for i in 0..<lim {{ if i > 0 {{ result = result + \", \" }}; result = result + @_common.dbl(self.comps[i]) }}")
    w("  if self.dim > 10 { result + \"...]\" } else { result + \"]\" }")
    w("}")
    w("")

    # === 通用函数：委托 @_common ===
    w(f"pub fn {p}_mean(data : Array[Double]) -> Double {{ @_common.mean(data) }}")
    w("")
    w(f"pub fn {p}_var(data : Array[Double]) -> Double {{ @_common.variance(data) }}")
    w("")
    w(f"pub fn {p}_std(data : Array[Double]) -> Double {{ @_common.std(data) }}")
    w("")
    w(f"pub fn {p}_cov(a : Array[Double], b : Array[Double]) -> Double {{ @_common.cov(a, b) }}")
    w("")
    w(f"pub fn {p}_corr(a : Array[Double], b : Array[Double]) -> Double {{ @_common.corr(a, b) }}")
    w("")
    w(f"pub fn {p}_median(data : Array[Double]) -> Double {{ @_common.median(data) }}")
    w("")
    w(f"pub fn {p}_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {{ @_common.accuracy(pred, labels) }}")
    w("")
    w(f"pub fn {p}_mse(pred : Array[Double], labels : Array[Double]) -> Double {{ @_common.mse(pred, labels) }}")
    w("")
    w(f"pub fn {p}_rmse(pred : Array[Double], labels : Array[Double]) -> Double {{ @_common.rmse(pred, labels) }}")
    w("")
    w(f"pub fn {p}_mae(pred : Array[Double], labels : Array[Double]) -> Double {{ @_common.mae(pred, labels) }}")
    w("")
    w(f"pub fn {p}_r2(pred : Array[Double], labels : Array[Double]) -> Double {{ @_common.r2(pred, labels) }}")
    w("")
    w(f"pub fn {p}_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{ @_common.precision(pred, labels, pos) }}")
    w("")
    w(f"pub fn {p}_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{ @_common.recall(pred, labels, pos) }}")
    w("")
    w(f"pub fn {p}_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {{ @_common.f1(pred, labels, pos) }}")
    w("")
    w(f"pub fn {p}_sort(arr : Array[Double]) -> Array[Double] {{ @_common.sort(arr) }}")
    w("")
    w(f"pub fn {p}_sort_desc(arr : Array[Double]) -> Array[Double] {{ @_common.sort_desc(arr) }}")
    w("")
    w(f"pub fn {p}_factorial(n : Int) -> Double {{ @_common.factorial(n) }}")
    w("")
    w(f"pub fn {p}_gcd(a : Int, b : Int) -> Int {{ @_common.gcd(a, b) }}")
    w("")
    w(f"pub fn {p}_lcm(a : Int, b : Int) -> Int {{ @_common.lcm(a, b) }}")
    w("")
    w(f"pub fn {p}_is_prime(n : Int) -> Bool {{ @_common.is_prime(n) }}")
    w("")
    w(f"pub fn {p}_fibonacci(n : Int) -> Int {{ @_common.fibonacci(n) }}")
    w("")
    w(f"pub fn {p}_normalize(data : Array[Double]) -> Array[Double] {{ @_common.normalize(data) }}")
    w("")
    w(f"pub fn {p}_standardize(data : Array[Double]) -> Array[Double] {{ @_common.standardize(data) }}")
    w("")
    w(f"pub fn {p}_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {{ @_common.clip(data, lo, hi) }}")
    w("")
    w(f"pub fn {p}_min(data : Array[Double]) -> Double {{ @_common.min(data) }}")
    w("")
    w(f"pub fn {p}_max(data : Array[Double]) -> Double {{ @_common.max(data) }}")
    w("")
    w(f"pub fn {p}_cumsum(data : Array[Double]) -> Array[Double] {{ @_common.cumsum(data) }}")
    w("")
    w(f"pub fn {p}_reverse(data : Array[Double]) -> Array[Double] {{ @_common.reverse(data) }}")
    w("")
    w(f"pub fn {p}_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {{ @_common.concat(a, b) }}")
    w("")

    extra_structs = ["Frame", "Table", "GraphN", "Node", "Edge", "Path",
                     "Cluster", "Model", "Layer", "Buffer", "Cursor", "View",
                     "Range", "Slice"]
    for sname in extra_structs:
        sl = sname.lower()
        w(f"pub(all) struct {P}{sname} {{")
        w("  data : Array[Double]")
        w("  size : Int")
        w("  tag : Int")
        w("}")
        w("")
        w(f"pub fn {p}_{sl}_make(size : Int) -> {P}{sname} {{")
        w("  { data: Array::make(size, 0.0), size, tag: 0 }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::len(self : {P}{sname}) -> Int {{ self.size }}")
        w("")
        w(f"pub fn {P}{sname}::get(self : {P}{sname}, i : Int) -> Double {{")
        w("  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::set(self : {P}{sname}, i : Int, v : Double) -> {P}{sname} {{")
        w("  let data = @_common.copy_arr(self.data)")
        w("  if i >= 0 && i < self.size { data[i] = v }")
        w("  { data, size: self.size, tag: self.tag }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::sum(self : {P}{sname}) -> Double {{ @_common.sum(self.data) }}")
        w("")
        w(f"pub fn {P}{sname}::mean(self : {P}{sname}) -> Double {{ @_common.mean(self.data) }}")
        w("")
        w(f"pub fn {P}{sname}::scale(self : {P}{sname}, f : Double) -> {P}{sname} {{")
        w("  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::add(self : {P}{sname}, other : {P}{sname}) -> {P}{sname} {{")
        w("  let n = if self.size < other.size { self.size } else { other.size }")
        w("  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::copy(self : {P}{sname}) -> {P}{sname} {{")
        w("  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }")
        w("}")
        w("")
        w(f"pub fn {P}{sname}::fill(self : {P}{sname}, v : Double) -> {P}{sname} {{")
        w("  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }")
        w("}")
        w("")

        w(f"pub fn {P}{sname}::min(self : {P}{sname}) -> Double {{ @_common.min(self.data) }}")
        w("")
        w(f"pub fn {P}{sname}::max(self : {P}{sname}) -> Double {{ @_common.max(self.data) }}")
        w("")
        w(f"pub fn {P}{sname}::to_string(self : {P}{sname}) -> String {{")
        w(f"  \"{sname}[\" + self.size.to_string() + \",tag=\" + self.tag.to_string() + \"]\"")
        w("}")
        w("")


    return '\n'.join(L) + '\n'


# === 包名定义：领域×子领域 ===
PACKAGES = {
    "math": [
        "linear_algebra", "matrix_decomp", "eigenvalue", "lu_decomp", "qr_decomp",
        "cholesky", "svd", "sparse_matrix", "tensor_calc", "quaternion",
        "numerical_integ", "numerical_diff", "ode_solver", "pde_solver", "boundary_value",
        "initial_value", "finite_diff", "finite_element", "spectral_method", " galerkin",
        "opt_convex", "opt_nonconvex", "linear_prog", "quadratic_prog", "integer_prog",
        "nonlinear_prog", "stochastic_prog", "complementarity", "kkt_conditions", "simplex",
        "special_gamma", "special_beta", "special_bessel", "special_legendre", "special_hermite",
        "special_laguerre", "special_chebyshev", "special_hypergeo", "special_elliptic", "special_zeta",
        "approx_poly", "approx_rational", "approx_pade", "approx_chebyshev", "approx_fourier",
        "approx_wavelet", "approx_spline", "approx_least_sq", "approx_minimax", "approx_interp",
    ],
    "stats": [
        "desc_univariate", "desc_bivariate", "desc_multivariate", "desc_robust", "desc_order",
        "infer_param", "infer_nonparam", "infer_bayesian", "infer_hypothesis", "infer_confidence",
        "test_t", "test_chi_sq", "test_f", "test_ks", "test_anderson",
        "test_shapiro", "test_normality", "test_homogeneity", "test_independence", "test_goodness",
        "model_linear", "model_glm", "model_mixed", "model_gam", "model_nonlinear",
        "dist_normal", "dist_student", "dist_chi_sq", "dist_f", "dist_exponential",
        "dist_gamma", "dist_beta", "dist_weibull", "dist_lognormal", "dist_poisson",
        "dist_binomial", "dist_neg_binomial", "dist_hypergeo", "dist_multinomial", "dist_dirichlet",
        "dist_wishart", "dist_inverse_gamma", "dist_pareto", "dist_cauchy", "dist_laplace",
    ],
    "ml": [
        "cluster_kmeans", "cluster_hierarchical", "cluster_dbscan", "cluster_optics", "cluster_mean_shift",
        "cluster_spectral", "cluster_affinity", "cluster_birch", "cluster_gmm", "cluster_agglomerative",
        "classify_knn", "classify_svm", "classify_tree", "classify_forest", "classify_naive_bayes",
        "classify_logistic", "classify_probit", "classify_lda", "classify_qda", "classify_perceptron",
        "regress_linear", "regress_poly", "regress_ridge", "regress_lasso", "regress_elastic",
        "regress_logistic", "regress_poisson", "regress_cox", "regress_isotonic", "regress_quantile",
        "feature_pca", "feature_lda", "feature_ica", "feature_nmf", "feature_tsne",
        "feature_umap", "feature_svd", "feature_pls", "feature_factor", "feature_selection",
        "neural_mlp", "neural_cnn", "neural_rnn", "neural_lstm", "neural_gru",
        "neural_transformer", "neural_attention", "neural_autoencoder", "neural_vae", "neural_gan",
        "ensemble_bagging", "ensemble_boosting", "ensemble_stacking", "ensemble_voting", "ensemble_adaboost",
        "ensemble_xgboost", "ensemble_lightgbm", "ensemble_catboost", "ensemble_rf", "ensemble_gbm",
        "rl_qlearning", "rl_sarsa", "rl_dqn", "rl_policy_grad", "rl_actor_critic",
        "rl_a3c", "rl_ppo", "rl_trpo", "rl_ddpg", "rl_sac",
        "metric_classify", "metric_regress", "metric_ranking", "metric_clustering", "metric_roc",
        "metric_pr", "metric_confusion", "metric_calibration", "metric_fairness", "metric_interpret",
    ],
    "graph": [
        "search_bfs", "search_dfs", "search_iddfs", "search_bds", "search_astar",
        "search_dijkstra", "search_bellman", "search_floyd", "search_johnson", "search_bidirectional",
        "flow_maxflow", "flow_mincut", "flow_mcmf", "flow_circulation", "flow_bipartite",
        "flow_matching", "flow_stable_marriage", "flow_assignment", "flow_transport", "flow_evacuation",
        "tree_mst", "tree_mst_kruskal", "tree_mst_prim", "tree_mst_boruvka", "tree_spanning",
        "tree_arborescence", "tree_center", "tree_diameter", "tree_isomorphism", "tree_encoding",
        "color_greedy", "color_dsatur", "color_welsh", "color_backtrack", "color_lawler",
        "color_edge", "color_list", "color_exact", "color_approx", "color_fractional",
        "connect_strong", "connect_weak", "connect_biconnect", "connect_bridge", "connect_articulation",
        "connect_components", "connect_paths", "connect_circuit", "connect_euler", "connect_hamilton",
    ],
    "ds": [
        "tree_binary", "tree_bst", "tree_avl", "tree_redblack", "tree_btree",
        "tree_trie", "tree_suffix", "tree_segment", "tree_fenwick", "tree_lct",
        "heap_binary", "heap_binomial", "heap_fibonacci", "heap_pairing", "heap_leftist",
        "heap_skew", "heap_d_ary", "heap_interval", "heap_lazy", "heap_mergeable",
        "hash_open", "hash_closed", "hash_cuckoo", "hash_hopscotch", "hash_robin",
        "hash_linear", "hash_quadratic", "hash_double", "hash_perfect", "hash_universal",
        "list_singly", "list_doubly", "list_circular", "list_skip", "list_unrolled",
        "list_xor", "list_persistent", "list_lockfree", "list_block", "list_chunked",
        "graph_adj_list", "graph_adj_matrix", "graph_edge_list", "graph_compact", "graph_dynamic",
        "graph_labeled", "graph_weighted", "graph_directed", "graph_multi", "graph_hyper",
    ],
    "sort": [
        "compare_bubble", "compare_selection", "compare_insertion", "compare_merge", "compare_quick",
        "compare_heap", "compare_tim", "compare_intro", "compare_patience", "compare_cycle",
        "dist_counting", "dist_bucket", "dist_radix", "dist_pigeonhole", "dist_flash",
        "dist_proxmap", "dist_lsd", "dist_msd", "dist_inplace", "dist_parallel",
        "exchange_gnome", "exchange_stooge", "exchange_bogo", "exchange_cocktail", "exchange_odd_even",
        "exchange_comb", "exchange_smooth", "exchange_strand", "exchange_pancake", "exchange_j",
        "hybrid_introsort", "hybrid_timsort", "hybrid_powersort", "hybrid_quadsort", "hybrid_blitsort",
        "hybrid_wikisort", "hybrid_grailsort", "hybrid_blocksort", "hybrid_dropsort", "hybrid_splaysort",
    ],
    "signal": [
        "filter_fir", "filter_iir", "filter_butterworth", "filter_chebyshev1", "filter_chebyshev2",
        "filter_elliptic", "filter_bessel", "filter_median", "filter_wiener", "filter_kalman",
        "transform_fft", "transform_dct", "transform_dst", "transform_dwt", "transform_stft",
        "transform_wigner", "transform_radar", "transform_chirp", "transform_hilbert", "transform_gabor",
        "window_rect", "window_hann", "window_hamming", "window_blackman", "window_kaiser",
        "window_bartlett", "window_flattop", "window_gaussian", "window_tukey", "window_planck",
        "spec_periodogram", "spec_welch", "spec_bartlett", "spec_daniell", "spec_multitaper",
        "spec_yule_walker", "spec_burg", "spec_covariance", "spec_modified", "spec_min_norm",
    ],
    "image": [
        "filter_gaussian", "filter_bilateral", "filter_median", "filter_mean", "filter_box",
        "filter_laplacian", "filter_sobel", "filter_prewitt", "filter_canny", "filter_gabor",
        "morph_dilate", "morph_erode", "morph_open", "morph_close", "morph_gradient",
        "morph_tophat", "morph_bothat", "morph_hit_miss", "morph_thinning", "morph_thickening",
        "transform_affine", "transform_perspective", "transform_rotate", "transform_scale", "transform_translate",
        "transform_shear", "transform_warp", "transform_remap", "transform_flip", "transform_transpose",
        "feature_harris", "feature_sift", "feature_surf", "feature_orb", "feature_fast",
        "feature_brief", "feature_akaze", "feature_kaze", "feature_mser", "feature_blob",
    ],
    "crypto": [
        "sym_aes", "sym_des", "sym_blowfish", "sym_twofish", "sym_camellia",
        "sym_cast", "sym_idea", "sym_rc4", "sym_chacha", "sym_salsa",
        "asym_rsa", "asym_dsa", "asym_ecc", "asym_dh", "asym_elgamal",
        "asym_ecdsa", "asym_eddsa", "asym_ecies", "asym_sm2", "asym_sm9",
        "hash_md5", "hash_sha1", "hash_sha256", "hash_sha512", "hash_sha3",
        "hash_blake2", "hash_blake3", "hash_ripemd", "hash_whirlpool", "hash_groestl",
        "sign_rsa_pss", "sign_rsa_pkcs", "sign_ecdsa", "sign_eddsa", "sign_dsa",
        "sign_schnorr", "sign_bls", "sign_ring", "sign_group", "sign_threshold",
    ],
    "timeseries": [
        "arima", "sarima", "var", "arch", "garch",
        "exponential", "holt", "winters", "tbats", "prophet",
        "decomp_classical", "decomp_stl", "decomp_x11", "decomp_seats", "decomp_moving",
        "decomp_hp", "decomp_beveridge", "decomp_wavelet", "decomp_emd", "decomp_vmd",
        "anomaly_zscore", "anomaly_iqr", "anomaly_dbscan", "anomaly_isolation", "anomaly_lof",
        "anomaly_ocsvm", "anomaly_autoencoder", "anomaly_lstm", "anomaly_prophet", "anomaly_twitter",
        "forecast_naive", "forecast_drift", "forecast_seasonal", "forecast_theta", "forecast_comb",
        "forecast_ensemble", "forecast_bagging", "forecast_stacking", "forecast_nbeats", "forecast_deepar",
    ],
    "nlp": [
        "tokenize_word", "tokenize_sentence", "tokenize_subword", "tokenize_bpe", "tokenize_wordpiece",
        "tokenize_unigram", "tokenize_morph", "tokenize_syllable", "tokenize_char", "tokenize_regex",
        "pos_hmm", "pos_crf", "pos_perceptron", "pos_bilstm", "pos_transformer",
        "pos_brill", "pos_tn", "pos_maxent", "pos_svm", "pos_averaged",
        "parse_cfg", "parse_dependency", "parse_constituency", "parse_shift_reduce", "parse_arc_eager",
        "parse_arc_standard", "parse_malt", "parse_span", "parse_early", "parse_cky",
        "embed_word2vec", "embed_glove", "embed_fasttext", "embed_elmo", "embed_bert",
        "embed_gpt", "embed_doc2vec", "embed_sent2vec", "embed_universal", "embed_contrastive",
    ],
    "geo": [
        "proj_utm", "proj_mercator", "proj_lambert", "proj_albers", "proj_stereographic",
        "proj_orthographic", "proj_gnomonic", "proj_azimuthal", "proj_conic", "proj_cylindrical",
        "dist_haversine", "dist_vincenty", "dist_euclidean", "dist_manhattan", "dist_geodesic",
        "dist_great_circle", "dist_rhumb", "dist_projected", "dist_ellipsoidal", "dist_spherical",
        "intersect_point", "intersect_line", "intersect_polygon", "intersect_circle", "intersect_bbox",
        "intersect_ray", "intersect_segment", "intersect_triangle", "intersect_rect", "intersect_ellipse",
        "buffer_point", "buffer_line", "buffer_polygon", "buffer_circle", "buffer_bbox",
        "buffer_segment", "buffer_triangle", "buffer_ellipse", "buffer_multi", "buffer_collection",
    ],
    "opt": [
        "grad_sgd", "grad_momentum", "grad_nesterov", "grad_adagrad", "grad_rmsprop",
        "grad_adam", "grad_adamax", "grad_nadam", "grad_amsgrad", "grad_adabound",
        "convex_gd", "convex_newton", "convex_quasi_newton", "convex_conjugate", "convex_bfgs",
        "convex_l_bfgs", "convex_dfp", "convex_sr1", "convex_trust_region", "convex_line_search",
        "meta_sa", "meta_ga", "meta_pso", "meta_aco", "meta_de",
        "meta_bayes", "meta_cmaes", "meta_nelder", "meta_differential", "meta_evolution",
    ],
    "db": [
        "index_btree", "index_hash", "index_lsm", "index_rtree", "index_bitmap",
        "index_invert", "index_gpu", "index_vector", "index_brin", "index_gist",
        "store_kv", "store_doc", "store_col", "store_row", "store_graph",
        "store_time", "store_spatial", "store_tensor", "store_series", "store_matrix",
        "query_select", "query_join", "query_aggregate", "query_filter", "query_sort",
        "query_group", "query_window", "query_recursive", "query_distributed", "query_parallel",
        "tx_acid", "tx_mvcc", "tx_2pc", "tx_3pc", "tx_saga",
        "tx_compensating", "tx_lock", "tx_timestamp", "tx_optimistic", "tx_pessimistic",
    ],
    "net": [
        "proto_tcp", "proto_udp", "proto_http", "proto_https", "proto_ws",
        "proto_grpc", "proto_quic", "proto_http2", "proto_http3", "proto_mqtt",
        "route_dijkstra", "route_bellman", "route_ospf", "route_bgp", "route_rip",
        "route_isis", "route_eigrp", "route_static", "route_policy", "route_multipath",
        "flow_congestion", "flow_rate", "flow_shaping", "flow_policing", "flow_scheduling",
        "flow_fairness", "flow_admission", "flow_backpressure", "flow_window", "flow_bufferbloat",
        "sec_tls", "sec_ssl", "sec_ipsec", "sec_firewall", "sec_ids",
        "sec_ips", "sec_waf", "sec_ddos", "sec_rate_limit", "sec_auth",
    ],
    "physics": [
        "mechanics_kinematic", "mechanics_dynamic", "mechanics_static", "mechanics_rigid", "mechanics_soft",
        "mechanics_collision", "mechanics_constraint", "mechanics_joint", "mechanics_force", "mechanics_energy",
        "fluid_euler", "fluid_navier", "fluid_stokes", "fluid_lattice", "fluid_smoothed",
        "fluid_volume", "fluid_level_set", "fluid_vortex", "fluid_turbulence", "fluid_compressible",
        "heat_conduction", "heat_convection", "heat_radiation", "heat_phase", "heat_steady",
        "heat_transient", "heat_source", "heat_boundary", "heat_insulation", "heat_diffusion",
        "em_electrostatic", "em_magnetostatic", "em_eddy", "em_wave", "em_maxwell",
        "em_fDTD", "em_mom", "em_fem", "em_bem", "em_high_freq",
    ],
    "bio": [
        "seq_align_global", "seq_align_local", "seq_align_semi", "seq_align_multiple", "seq_align_profile",
        "seq_align_iterative", "seq_align_progressive", "seq_align_consistency", "seq_align_structural", "seq_align_pairwise",
        "seq_assembly_greedy", "seq_assembly_overlap", "seq_assembly_de_bruijn", "seq_assembly_string", "seq_assembly_scaffold",
        "seq_assembly_gap", "seq_assembly_polish", "seq_assembly_validate", "seq_assembly_hybrid", "seq_assembly_metagenome",
        "phylo_neighbor", "phylo_upgma", "phylo_maximum", "phylo_bayesian", "phylo_parsimony",
        "phylo_bootstrap", "phylo_consensus", "phylo_distance", "phylo_tree_split", "phylo_reconcile",
        "struct_secondary", "struct_tertiary", "struct_contact", "struct_distance", "struct_angle",
        "struct_surface", "struct_volume", "struct_symmetry", "struct_domain", "struct_motif",
    ],
    "chem": [
        "mol_repr_smiles", "mol_repr_inchi", "mol_repr_molfile", "mol_repr_sdf", "mol_repr_pdb",
        "mol_repr_cif", "mol_repr_xyz", "mol_repr_graph", "mol_repr_canonical", "mol_repr_aromatic",
        "mol_props_mw", "mol_props_logp", "mol_props_tpsa", "mol_props_hbd", "mol_props_hba",
        "mol_props_rotatable", "mol_props_rings", "mol_props_aromatic", "mol_props_stereo", "mol_props_charge",
        "rxn_balance", "rxn_type", "rxn_mechanism", "rxn_kinetics", "rxn_thermo",
        "rxn_catalyst", "rxn_selectivity", "rxn_yield", "rxn_optimize", "rxn_retro",
        "desc_topological", "desc_geometric", "desc_electronic", "desc_hybrid", "desc_fingerprint",
        "desc_maccs", "desc_ecfp", "desc_fcfp", "desc_rdkit", "desc_atompair",
    ],
    "finance": [
        "pricing_black_scholes", "pricing_binomial", "pricing_monte_carlo", "pricing_finite_diff", "pricing_asian",
        "pricing_barrier", "pricing_lookback", "pricing_basket", "pricing_american", "pricing_european",
        "risk_var", "risk_cvar", "risk_es", "risk_stress", "risk_scenario",
        "risk_marginal", "risk_incremental", "risk_component", "risk_coherent", "risk_spectral",
        "portfolio_markowitz", "portfolio_capm", "portfolio_apt", "portfolio_black_litterman", "portfolio_risk_parity",
        "portfolio_factor", "portfolio_hierarchical", "portfolio_robust", "portfolio_rebalancing", "portfolio_black",
        "time_garch", "time_egarch", "time_tgarch", "time_figarch", "time_igarch",
        "time_mgarch", "time_copula", "time_extreme", "time_crisis", "time_regime",
    ],
}


def main():
    base = r"D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse"
    total_lines = 0
    pkg_count = 0

    for category, sub_pkgs in PACKAGES.items():
        for sub in sub_pkgs:
            sub = sub.strip()
            if not sub:
                continue
            pkg_name = f"{category}_{sub}"
            dir_path = os.path.join(base, "src", "extcore", pkg_name)
            os.makedirs(dir_path, exist_ok=True)

            with open(os.path.join(dir_path, "moon.pkg"), "w", encoding="utf-8") as f:
                f.write(f"// extcore/{pkg_name}\nimport {{\n  \"dataverse/extcore/_common\",\n}}\n")

            code = gen_code(pkg_name, f"extcore/{pkg_name}")
            with open(os.path.join(dir_path, f"{pkg_name}.mbt"), "w", encoding="utf-8") as f:
                f.write(code)

            total_lines += len(code.split('\n'))
            pkg_count += 1

    print(f"Generated {pkg_count} packages, ~{total_lines} lines")


if __name__ == "__main__":
    main()