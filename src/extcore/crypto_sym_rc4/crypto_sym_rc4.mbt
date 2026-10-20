///===
/// extcore/crypto_sym_rc4

pub(all) struct Cryptosymrc4Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_rc4_make_point(x : Double, y : Double) -> Cryptosymrc4Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_rc4_make_point3(x : Double, y : Double, z : Double) -> Cryptosymrc4Point {
  { x, y, z, label: 0 }
}

pub fn Cryptosymrc4Point::x(self : Cryptosymrc4Point) -> Double { self.x }

pub fn Cryptosymrc4Point::y(self : Cryptosymrc4Point) -> Double { self.y }

pub fn Cryptosymrc4Point::z(self : Cryptosymrc4Point) -> Double { self.z }

pub fn Cryptosymrc4Point::label(self : Cryptosymrc4Point) -> Int { self.label }

pub fn Cryptosymrc4Point::dist(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptosymrc4Point::add(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptosymrc4Point::sub(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptosymrc4Point::scale(self : Cryptosymrc4Point, s : Double) -> Cryptosymrc4Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptosymrc4Point::dot(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptosymrc4Point::cross(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptosymrc4Point::norm(self : Cryptosymrc4Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptosymrc4Point::normalize(self : Cryptosymrc4Point) -> Cryptosymrc4Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptosymrc4Point::negate(self : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptosymrc4Point::mid(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptosymrc4Point::lerp(self : Cryptosymrc4Point, other : Cryptosymrc4Point, t : Double) -> Cryptosymrc4Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptosymrc4Point::to_string(self : Cryptosymrc4Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptosymrc4Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_rc4_make_series(vals : Array[Double], name : String) -> Cryptosymrc4Series {
  { vals, name, meta: 0 }
}

pub fn Cryptosymrc4Series::len(self : Cryptosymrc4Series) -> Int { self.vals.length() }

pub fn Cryptosymrc4Series::sum(self : Cryptosymrc4Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptosymrc4Series::mean(self : Cryptosymrc4Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptosymrc4Series::min(self : Cryptosymrc4Series) -> Double { @_common.min(self.vals) }

pub fn Cryptosymrc4Series::max(self : Cryptosymrc4Series) -> Double { @_common.max(self.vals) }

pub fn Cryptosymrc4Series::range(self : Cryptosymrc4Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptosymrc4Series::variance(self : Cryptosymrc4Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptosymrc4Series::std(self : Cryptosymrc4Series) -> Double { @_common.std(self.vals) }

pub fn Cryptosymrc4Series::median(self : Cryptosymrc4Series) -> Double { @_common.median(self.vals) }

pub fn Cryptosymrc4Series::scale(self : Cryptosymrc4Series, f : Double) -> Cryptosymrc4Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::add(self : Cryptosymrc4Series, other : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::sub(self : Cryptosymrc4Series, other : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::normalize(self : Cryptosymrc4Series) -> Cryptosymrc4Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptosymrc4Series::cumsum(self : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptosymrc4Series::to_string(self : Cryptosymrc4Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptosymrc4Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_rc4_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptosymrc4Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_rc4_matrix_identity(n : Int) -> Cryptosymrc4Matrix {
  let m = crypto_sym_rc4_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptosymrc4Matrix::get(self : Cryptosymrc4Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptosymrc4Matrix::transpose(self : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptosymrc4Matrix::add(self : Cryptosymrc4Matrix, other : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_rc4_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptosymrc4Matrix::scale(self : Cryptosymrc4Matrix, s : Double) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptosymrc4Matrix::multiply(self : Cryptosymrc4Matrix, other : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if self.cols != other.rows { return crypto_sym_rc4_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_rc4_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptosymrc4Matrix::trace(self : Cryptosymrc4Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptosymrc4Matrix::det(self : Cryptosymrc4Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptosymrc4Matrix::norm(self : Cryptosymrc4Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptosymrc4Matrix::to_string(self : Cryptosymrc4Matrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Cryptosymrc4Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_rc4_make_vector(comps : Array[Double]) -> Cryptosymrc4Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_rc4_vector_zero(dim : Int) -> Cryptosymrc4Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptosymrc4Vector::add(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptosymrc4Vector::sub(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptosymrc4Vector::scale(self : Cryptosymrc4Vector, s : Double) -> Cryptosymrc4Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptosymrc4Vector::dot(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptosymrc4Vector::norm(self : Cryptosymrc4Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptosymrc4Vector::normalize(self : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptosymrc4Vector::dist(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptosymrc4Vector::to_string(self : Cryptosymrc4Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_rc4_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_rc4_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_rc4_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_rc4_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_rc4_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_rc4_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_rc4_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_rc4_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_rc4_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_rc4_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_rc4_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_rc4_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_rc4_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_rc4_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_rc4_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_rc4_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_rc4_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_rc4_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_rc4_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_rc4_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_rc4_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_rc4_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_rc4_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_rc4_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_rc4_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_rc4_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_rc4_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_rc4_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_rc4_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptosymrc4Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_frame_make(size : Int) -> Cryptosymrc4Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_frame_len(s : Cryptosymrc4Frame) -> Int { s.size }

pub fn crypto_sym_rc4_frame_get(s : Cryptosymrc4Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_frame_set(s : Cryptosymrc4Frame, i : Int, v : Double) -> Cryptosymrc4Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_frame_sum(s : Cryptosymrc4Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_frame_mean(s : Cryptosymrc4Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_frame_scale(s : Cryptosymrc4Frame, f : Double) -> Cryptosymrc4Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_frame_add(a : Cryptosymrc4Frame, b : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_frame_copy(s : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_frame_fill(s : Cryptosymrc4Frame, v : Double) -> Cryptosymrc4Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_frame_min(s : Cryptosymrc4Frame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_frame_max(s : Cryptosymrc4Frame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_frame_to_string(s : Cryptosymrc4Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_table_make(size : Int) -> Cryptosymrc4Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_table_len(s : Cryptosymrc4Table) -> Int { s.size }

pub fn crypto_sym_rc4_table_get(s : Cryptosymrc4Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_table_set(s : Cryptosymrc4Table, i : Int, v : Double) -> Cryptosymrc4Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_table_sum(s : Cryptosymrc4Table) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_table_mean(s : Cryptosymrc4Table) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_table_scale(s : Cryptosymrc4Table, f : Double) -> Cryptosymrc4Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_table_add(a : Cryptosymrc4Table, b : Cryptosymrc4Table) -> Cryptosymrc4Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_table_copy(s : Cryptosymrc4Table) -> Cryptosymrc4Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_table_fill(s : Cryptosymrc4Table, v : Double) -> Cryptosymrc4Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_table_min(s : Cryptosymrc4Table) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_table_max(s : Cryptosymrc4Table) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_table_to_string(s : Cryptosymrc4Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_graphn_make(size : Int) -> Cryptosymrc4GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_graphn_len(s : Cryptosymrc4GraphN) -> Int { s.size }

pub fn crypto_sym_rc4_graphn_get(s : Cryptosymrc4GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_graphn_set(s : Cryptosymrc4GraphN, i : Int, v : Double) -> Cryptosymrc4GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_graphn_sum(s : Cryptosymrc4GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_graphn_mean(s : Cryptosymrc4GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_graphn_scale(s : Cryptosymrc4GraphN, f : Double) -> Cryptosymrc4GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_graphn_add(a : Cryptosymrc4GraphN, b : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_graphn_copy(s : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_graphn_fill(s : Cryptosymrc4GraphN, v : Double) -> Cryptosymrc4GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_graphn_min(s : Cryptosymrc4GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_graphn_max(s : Cryptosymrc4GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_graphn_to_string(s : Cryptosymrc4GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_node_make(size : Int) -> Cryptosymrc4Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_node_len(s : Cryptosymrc4Node) -> Int { s.size }

pub fn crypto_sym_rc4_node_get(s : Cryptosymrc4Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_node_set(s : Cryptosymrc4Node, i : Int, v : Double) -> Cryptosymrc4Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_node_sum(s : Cryptosymrc4Node) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_node_mean(s : Cryptosymrc4Node) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_node_scale(s : Cryptosymrc4Node, f : Double) -> Cryptosymrc4Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_node_add(a : Cryptosymrc4Node, b : Cryptosymrc4Node) -> Cryptosymrc4Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_node_copy(s : Cryptosymrc4Node) -> Cryptosymrc4Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_node_fill(s : Cryptosymrc4Node, v : Double) -> Cryptosymrc4Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_node_min(s : Cryptosymrc4Node) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_node_max(s : Cryptosymrc4Node) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_node_to_string(s : Cryptosymrc4Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_edge_make(size : Int) -> Cryptosymrc4Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_edge_len(s : Cryptosymrc4Edge) -> Int { s.size }

pub fn crypto_sym_rc4_edge_get(s : Cryptosymrc4Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_edge_set(s : Cryptosymrc4Edge, i : Int, v : Double) -> Cryptosymrc4Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_edge_sum(s : Cryptosymrc4Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_edge_mean(s : Cryptosymrc4Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_edge_scale(s : Cryptosymrc4Edge, f : Double) -> Cryptosymrc4Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_edge_add(a : Cryptosymrc4Edge, b : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_edge_copy(s : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_edge_fill(s : Cryptosymrc4Edge, v : Double) -> Cryptosymrc4Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_edge_min(s : Cryptosymrc4Edge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_edge_max(s : Cryptosymrc4Edge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_edge_to_string(s : Cryptosymrc4Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_path_make(size : Int) -> Cryptosymrc4Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_path_len(s : Cryptosymrc4Path) -> Int { s.size }

pub fn crypto_sym_rc4_path_get(s : Cryptosymrc4Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_path_set(s : Cryptosymrc4Path, i : Int, v : Double) -> Cryptosymrc4Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_path_sum(s : Cryptosymrc4Path) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_path_mean(s : Cryptosymrc4Path) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_path_scale(s : Cryptosymrc4Path, f : Double) -> Cryptosymrc4Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_path_add(a : Cryptosymrc4Path, b : Cryptosymrc4Path) -> Cryptosymrc4Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_path_copy(s : Cryptosymrc4Path) -> Cryptosymrc4Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_path_fill(s : Cryptosymrc4Path, v : Double) -> Cryptosymrc4Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_path_min(s : Cryptosymrc4Path) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_path_max(s : Cryptosymrc4Path) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_path_to_string(s : Cryptosymrc4Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cluster_make(size : Int) -> Cryptosymrc4Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_cluster_len(s : Cryptosymrc4Cluster) -> Int { s.size }

pub fn crypto_sym_rc4_cluster_get(s : Cryptosymrc4Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_cluster_set(s : Cryptosymrc4Cluster, i : Int, v : Double) -> Cryptosymrc4Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cluster_sum(s : Cryptosymrc4Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_cluster_mean(s : Cryptosymrc4Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_cluster_scale(s : Cryptosymrc4Cluster, f : Double) -> Cryptosymrc4Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cluster_add(a : Cryptosymrc4Cluster, b : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_cluster_copy(s : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cluster_fill(s : Cryptosymrc4Cluster, v : Double) -> Cryptosymrc4Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cluster_min(s : Cryptosymrc4Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_cluster_max(s : Cryptosymrc4Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_cluster_to_string(s : Cryptosymrc4Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_model_make(size : Int) -> Cryptosymrc4Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_model_len(s : Cryptosymrc4Model) -> Int { s.size }

pub fn crypto_sym_rc4_model_get(s : Cryptosymrc4Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_model_set(s : Cryptosymrc4Model, i : Int, v : Double) -> Cryptosymrc4Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_model_sum(s : Cryptosymrc4Model) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_model_mean(s : Cryptosymrc4Model) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_model_scale(s : Cryptosymrc4Model, f : Double) -> Cryptosymrc4Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_model_add(a : Cryptosymrc4Model, b : Cryptosymrc4Model) -> Cryptosymrc4Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_model_copy(s : Cryptosymrc4Model) -> Cryptosymrc4Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_model_fill(s : Cryptosymrc4Model, v : Double) -> Cryptosymrc4Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_model_min(s : Cryptosymrc4Model) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_model_max(s : Cryptosymrc4Model) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_model_to_string(s : Cryptosymrc4Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_layer_make(size : Int) -> Cryptosymrc4Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_layer_len(s : Cryptosymrc4Layer) -> Int { s.size }

pub fn crypto_sym_rc4_layer_get(s : Cryptosymrc4Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_layer_set(s : Cryptosymrc4Layer, i : Int, v : Double) -> Cryptosymrc4Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_layer_sum(s : Cryptosymrc4Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_layer_mean(s : Cryptosymrc4Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_layer_scale(s : Cryptosymrc4Layer, f : Double) -> Cryptosymrc4Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_layer_add(a : Cryptosymrc4Layer, b : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_layer_copy(s : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_layer_fill(s : Cryptosymrc4Layer, v : Double) -> Cryptosymrc4Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_layer_min(s : Cryptosymrc4Layer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_layer_max(s : Cryptosymrc4Layer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_layer_to_string(s : Cryptosymrc4Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_buffer_make(size : Int) -> Cryptosymrc4Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_buffer_len(s : Cryptosymrc4Buffer) -> Int { s.size }

pub fn crypto_sym_rc4_buffer_get(s : Cryptosymrc4Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_buffer_set(s : Cryptosymrc4Buffer, i : Int, v : Double) -> Cryptosymrc4Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_buffer_sum(s : Cryptosymrc4Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_buffer_mean(s : Cryptosymrc4Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_buffer_scale(s : Cryptosymrc4Buffer, f : Double) -> Cryptosymrc4Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_buffer_add(a : Cryptosymrc4Buffer, b : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_buffer_copy(s : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_buffer_fill(s : Cryptosymrc4Buffer, v : Double) -> Cryptosymrc4Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_buffer_min(s : Cryptosymrc4Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_buffer_max(s : Cryptosymrc4Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_buffer_to_string(s : Cryptosymrc4Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cursor_make(size : Int) -> Cryptosymrc4Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_cursor_len(s : Cryptosymrc4Cursor) -> Int { s.size }

pub fn crypto_sym_rc4_cursor_get(s : Cryptosymrc4Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_cursor_set(s : Cryptosymrc4Cursor, i : Int, v : Double) -> Cryptosymrc4Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cursor_sum(s : Cryptosymrc4Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_cursor_mean(s : Cryptosymrc4Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_cursor_scale(s : Cryptosymrc4Cursor, f : Double) -> Cryptosymrc4Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cursor_add(a : Cryptosymrc4Cursor, b : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_cursor_copy(s : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cursor_fill(s : Cryptosymrc4Cursor, v : Double) -> Cryptosymrc4Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_cursor_min(s : Cryptosymrc4Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_cursor_max(s : Cryptosymrc4Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_cursor_to_string(s : Cryptosymrc4Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_view_make(size : Int) -> Cryptosymrc4View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_view_len(s : Cryptosymrc4View) -> Int { s.size }

pub fn crypto_sym_rc4_view_get(s : Cryptosymrc4View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_view_set(s : Cryptosymrc4View, i : Int, v : Double) -> Cryptosymrc4View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_view_sum(s : Cryptosymrc4View) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_view_mean(s : Cryptosymrc4View) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_view_scale(s : Cryptosymrc4View, f : Double) -> Cryptosymrc4View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_view_add(a : Cryptosymrc4View, b : Cryptosymrc4View) -> Cryptosymrc4View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_view_copy(s : Cryptosymrc4View) -> Cryptosymrc4View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_view_fill(s : Cryptosymrc4View, v : Double) -> Cryptosymrc4View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_view_min(s : Cryptosymrc4View) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_view_max(s : Cryptosymrc4View) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_view_to_string(s : Cryptosymrc4View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_range_make(size : Int) -> Cryptosymrc4Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_range_len(s : Cryptosymrc4Range) -> Int { s.size }

pub fn crypto_sym_rc4_range_get(s : Cryptosymrc4Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_range_set(s : Cryptosymrc4Range, i : Int, v : Double) -> Cryptosymrc4Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_range_sum(s : Cryptosymrc4Range) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_range_mean(s : Cryptosymrc4Range) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_range_scale(s : Cryptosymrc4Range, f : Double) -> Cryptosymrc4Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_range_add(a : Cryptosymrc4Range, b : Cryptosymrc4Range) -> Cryptosymrc4Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_range_copy(s : Cryptosymrc4Range) -> Cryptosymrc4Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_range_fill(s : Cryptosymrc4Range, v : Double) -> Cryptosymrc4Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_range_min(s : Cryptosymrc4Range) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_range_max(s : Cryptosymrc4Range) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_range_to_string(s : Cryptosymrc4Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_slice_make(size : Int) -> Cryptosymrc4Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_slice_len(s : Cryptosymrc4Slice) -> Int { s.size }

pub fn crypto_sym_rc4_slice_get(s : Cryptosymrc4Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_slice_set(s : Cryptosymrc4Slice, i : Int, v : Double) -> Cryptosymrc4Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_slice_sum(s : Cryptosymrc4Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_rc4_slice_mean(s : Cryptosymrc4Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_rc4_slice_scale(s : Cryptosymrc4Slice, f : Double) -> Cryptosymrc4Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_slice_add(a : Cryptosymrc4Slice, b : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_rc4_slice_copy(s : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_slice_fill(s : Cryptosymrc4Slice, v : Double) -> Cryptosymrc4Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_rc4_slice_min(s : Cryptosymrc4Slice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_rc4_slice_max(s : Cryptosymrc4Slice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_rc4_slice_to_string(s : Cryptosymrc4Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

