///===
/// extcore/crypto_hash_sha512

pub(all) struct Cryptohashsha512Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha512_make_point(x : Double, y : Double) -> Cryptohashsha512Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha512_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha512Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha512Point::x(self : Cryptohashsha512Point) -> Double { self.x }

pub fn Cryptohashsha512Point::y(self : Cryptohashsha512Point) -> Double { self.y }

pub fn Cryptohashsha512Point::z(self : Cryptohashsha512Point) -> Double { self.z }

pub fn Cryptohashsha512Point::label(self : Cryptohashsha512Point) -> Int { self.label }

pub fn Cryptohashsha512Point::dist(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha512Point::add(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha512Point::sub(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha512Point::scale(self : Cryptohashsha512Point, s : Double) -> Cryptohashsha512Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha512Point::dot(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha512Point::cross(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha512Point::norm(self : Cryptohashsha512Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha512Point::normalize(self : Cryptohashsha512Point) -> Cryptohashsha512Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha512Point::negate(self : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha512Point::mid(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha512Point::lerp(self : Cryptohashsha512Point, other : Cryptohashsha512Point, t : Double) -> Cryptohashsha512Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha512Point::to_string(self : Cryptohashsha512Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha512Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha512_make_series(vals : Array[Double], name : String) -> Cryptohashsha512Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha512Series::len(self : Cryptohashsha512Series) -> Int { self.vals.length() }

pub fn Cryptohashsha512Series::sum(self : Cryptohashsha512Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha512Series::mean(self : Cryptohashsha512Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha512Series::min(self : Cryptohashsha512Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha512Series::max(self : Cryptohashsha512Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha512Series::range(self : Cryptohashsha512Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha512Series::variance(self : Cryptohashsha512Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha512Series::std(self : Cryptohashsha512Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha512Series::median(self : Cryptohashsha512Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha512Series::scale(self : Cryptohashsha512Series, f : Double) -> Cryptohashsha512Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::add(self : Cryptohashsha512Series, other : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::sub(self : Cryptohashsha512Series, other : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::normalize(self : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha512Series::cumsum(self : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha512Series::to_string(self : Cryptohashsha512Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha512Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha512_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha512Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha512_matrix_identity(n : Int) -> Cryptohashsha512Matrix {
  let m = crypto_hash_sha512_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha512Matrix::get(self : Cryptohashsha512Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha512Matrix::transpose(self : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha512Matrix::add(self : Cryptohashsha512Matrix, other : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha512_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha512Matrix::scale(self : Cryptohashsha512Matrix, s : Double) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha512Matrix::multiply(self : Cryptohashsha512Matrix, other : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if self.cols != other.rows { return crypto_hash_sha512_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha512_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashsha512Matrix::trace(self : Cryptohashsha512Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha512Matrix::det(self : Cryptohashsha512Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha512Matrix::norm(self : Cryptohashsha512Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha512Matrix::to_string(self : Cryptohashsha512Matrix) -> String {
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

pub(all) struct Cryptohashsha512Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha512_make_vector(comps : Array[Double]) -> Cryptohashsha512Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha512_vector_zero(dim : Int) -> Cryptohashsha512Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha512Vector::add(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha512Vector::sub(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha512Vector::scale(self : Cryptohashsha512Vector, s : Double) -> Cryptohashsha512Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha512Vector::dot(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha512Vector::norm(self : Cryptohashsha512Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha512Vector::normalize(self : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha512Vector::dist(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha512Vector::to_string(self : Cryptohashsha512Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha512_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha512_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha512_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha512_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha512_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha512_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha512_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha512_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha512_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha512_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha512_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha512_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha512_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha512_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha512_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha512_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha512_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha512_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha512_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha512_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha512_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha512_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha512_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha512_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha512_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha512_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha512_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha512_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha512_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha512Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_frame_make(size : Int) -> Cryptohashsha512Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_frame_len(s : Cryptohashsha512Frame) -> Int { s.size }

pub fn crypto_hash_sha512_frame_get(s : Cryptohashsha512Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_frame_set(s : Cryptohashsha512Frame, i : Int, v : Double) -> Cryptohashsha512Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_frame_sum(s : Cryptohashsha512Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_frame_mean(s : Cryptohashsha512Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_frame_scale(s : Cryptohashsha512Frame, f : Double) -> Cryptohashsha512Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_frame_add(a : Cryptohashsha512Frame, b : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_frame_copy(s : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_frame_fill(s : Cryptohashsha512Frame, v : Double) -> Cryptohashsha512Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_frame_min(s : Cryptohashsha512Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_frame_max(s : Cryptohashsha512Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_frame_to_string(s : Cryptohashsha512Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_table_make(size : Int) -> Cryptohashsha512Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_table_len(s : Cryptohashsha512Table) -> Int { s.size }

pub fn crypto_hash_sha512_table_get(s : Cryptohashsha512Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_table_set(s : Cryptohashsha512Table, i : Int, v : Double) -> Cryptohashsha512Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_table_sum(s : Cryptohashsha512Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_table_mean(s : Cryptohashsha512Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_table_scale(s : Cryptohashsha512Table, f : Double) -> Cryptohashsha512Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_table_add(a : Cryptohashsha512Table, b : Cryptohashsha512Table) -> Cryptohashsha512Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_table_copy(s : Cryptohashsha512Table) -> Cryptohashsha512Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_table_fill(s : Cryptohashsha512Table, v : Double) -> Cryptohashsha512Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_table_min(s : Cryptohashsha512Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_table_max(s : Cryptohashsha512Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_table_to_string(s : Cryptohashsha512Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_graphn_make(size : Int) -> Cryptohashsha512GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_graphn_len(s : Cryptohashsha512GraphN) -> Int { s.size }

pub fn crypto_hash_sha512_graphn_get(s : Cryptohashsha512GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_graphn_set(s : Cryptohashsha512GraphN, i : Int, v : Double) -> Cryptohashsha512GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_graphn_sum(s : Cryptohashsha512GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_graphn_mean(s : Cryptohashsha512GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_graphn_scale(s : Cryptohashsha512GraphN, f : Double) -> Cryptohashsha512GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_graphn_add(a : Cryptohashsha512GraphN, b : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_graphn_copy(s : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_graphn_fill(s : Cryptohashsha512GraphN, v : Double) -> Cryptohashsha512GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_graphn_min(s : Cryptohashsha512GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_graphn_max(s : Cryptohashsha512GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_graphn_to_string(s : Cryptohashsha512GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_node_make(size : Int) -> Cryptohashsha512Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_node_len(s : Cryptohashsha512Node) -> Int { s.size }

pub fn crypto_hash_sha512_node_get(s : Cryptohashsha512Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_node_set(s : Cryptohashsha512Node, i : Int, v : Double) -> Cryptohashsha512Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_node_sum(s : Cryptohashsha512Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_node_mean(s : Cryptohashsha512Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_node_scale(s : Cryptohashsha512Node, f : Double) -> Cryptohashsha512Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_node_add(a : Cryptohashsha512Node, b : Cryptohashsha512Node) -> Cryptohashsha512Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_node_copy(s : Cryptohashsha512Node) -> Cryptohashsha512Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_node_fill(s : Cryptohashsha512Node, v : Double) -> Cryptohashsha512Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_node_min(s : Cryptohashsha512Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_node_max(s : Cryptohashsha512Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_node_to_string(s : Cryptohashsha512Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_edge_make(size : Int) -> Cryptohashsha512Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_edge_len(s : Cryptohashsha512Edge) -> Int { s.size }

pub fn crypto_hash_sha512_edge_get(s : Cryptohashsha512Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_edge_set(s : Cryptohashsha512Edge, i : Int, v : Double) -> Cryptohashsha512Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_edge_sum(s : Cryptohashsha512Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_edge_mean(s : Cryptohashsha512Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_edge_scale(s : Cryptohashsha512Edge, f : Double) -> Cryptohashsha512Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_edge_add(a : Cryptohashsha512Edge, b : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_edge_copy(s : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_edge_fill(s : Cryptohashsha512Edge, v : Double) -> Cryptohashsha512Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_edge_min(s : Cryptohashsha512Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_edge_max(s : Cryptohashsha512Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_edge_to_string(s : Cryptohashsha512Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_path_make(size : Int) -> Cryptohashsha512Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_path_len(s : Cryptohashsha512Path) -> Int { s.size }

pub fn crypto_hash_sha512_path_get(s : Cryptohashsha512Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_path_set(s : Cryptohashsha512Path, i : Int, v : Double) -> Cryptohashsha512Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_path_sum(s : Cryptohashsha512Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_path_mean(s : Cryptohashsha512Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_path_scale(s : Cryptohashsha512Path, f : Double) -> Cryptohashsha512Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_path_add(a : Cryptohashsha512Path, b : Cryptohashsha512Path) -> Cryptohashsha512Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_path_copy(s : Cryptohashsha512Path) -> Cryptohashsha512Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_path_fill(s : Cryptohashsha512Path, v : Double) -> Cryptohashsha512Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_path_min(s : Cryptohashsha512Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_path_max(s : Cryptohashsha512Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_path_to_string(s : Cryptohashsha512Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cluster_make(size : Int) -> Cryptohashsha512Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_cluster_len(s : Cryptohashsha512Cluster) -> Int { s.size }

pub fn crypto_hash_sha512_cluster_get(s : Cryptohashsha512Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_cluster_set(s : Cryptohashsha512Cluster, i : Int, v : Double) -> Cryptohashsha512Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cluster_sum(s : Cryptohashsha512Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_cluster_mean(s : Cryptohashsha512Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_cluster_scale(s : Cryptohashsha512Cluster, f : Double) -> Cryptohashsha512Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cluster_add(a : Cryptohashsha512Cluster, b : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_cluster_copy(s : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cluster_fill(s : Cryptohashsha512Cluster, v : Double) -> Cryptohashsha512Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cluster_min(s : Cryptohashsha512Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_cluster_max(s : Cryptohashsha512Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_cluster_to_string(s : Cryptohashsha512Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_model_make(size : Int) -> Cryptohashsha512Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_model_len(s : Cryptohashsha512Model) -> Int { s.size }

pub fn crypto_hash_sha512_model_get(s : Cryptohashsha512Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_model_set(s : Cryptohashsha512Model, i : Int, v : Double) -> Cryptohashsha512Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_model_sum(s : Cryptohashsha512Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_model_mean(s : Cryptohashsha512Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_model_scale(s : Cryptohashsha512Model, f : Double) -> Cryptohashsha512Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_model_add(a : Cryptohashsha512Model, b : Cryptohashsha512Model) -> Cryptohashsha512Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_model_copy(s : Cryptohashsha512Model) -> Cryptohashsha512Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_model_fill(s : Cryptohashsha512Model, v : Double) -> Cryptohashsha512Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_model_min(s : Cryptohashsha512Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_model_max(s : Cryptohashsha512Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_model_to_string(s : Cryptohashsha512Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_layer_make(size : Int) -> Cryptohashsha512Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_layer_len(s : Cryptohashsha512Layer) -> Int { s.size }

pub fn crypto_hash_sha512_layer_get(s : Cryptohashsha512Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_layer_set(s : Cryptohashsha512Layer, i : Int, v : Double) -> Cryptohashsha512Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_layer_sum(s : Cryptohashsha512Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_layer_mean(s : Cryptohashsha512Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_layer_scale(s : Cryptohashsha512Layer, f : Double) -> Cryptohashsha512Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_layer_add(a : Cryptohashsha512Layer, b : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_layer_copy(s : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_layer_fill(s : Cryptohashsha512Layer, v : Double) -> Cryptohashsha512Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_layer_min(s : Cryptohashsha512Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_layer_max(s : Cryptohashsha512Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_layer_to_string(s : Cryptohashsha512Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_buffer_make(size : Int) -> Cryptohashsha512Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_buffer_len(s : Cryptohashsha512Buffer) -> Int { s.size }

pub fn crypto_hash_sha512_buffer_get(s : Cryptohashsha512Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_buffer_set(s : Cryptohashsha512Buffer, i : Int, v : Double) -> Cryptohashsha512Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_buffer_sum(s : Cryptohashsha512Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_buffer_mean(s : Cryptohashsha512Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_buffer_scale(s : Cryptohashsha512Buffer, f : Double) -> Cryptohashsha512Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_buffer_add(a : Cryptohashsha512Buffer, b : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_buffer_copy(s : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_buffer_fill(s : Cryptohashsha512Buffer, v : Double) -> Cryptohashsha512Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_buffer_min(s : Cryptohashsha512Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_buffer_max(s : Cryptohashsha512Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_buffer_to_string(s : Cryptohashsha512Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cursor_make(size : Int) -> Cryptohashsha512Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_cursor_len(s : Cryptohashsha512Cursor) -> Int { s.size }

pub fn crypto_hash_sha512_cursor_get(s : Cryptohashsha512Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_cursor_set(s : Cryptohashsha512Cursor, i : Int, v : Double) -> Cryptohashsha512Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cursor_sum(s : Cryptohashsha512Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_cursor_mean(s : Cryptohashsha512Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_cursor_scale(s : Cryptohashsha512Cursor, f : Double) -> Cryptohashsha512Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cursor_add(a : Cryptohashsha512Cursor, b : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_cursor_copy(s : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cursor_fill(s : Cryptohashsha512Cursor, v : Double) -> Cryptohashsha512Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_cursor_min(s : Cryptohashsha512Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_cursor_max(s : Cryptohashsha512Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_cursor_to_string(s : Cryptohashsha512Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_view_make(size : Int) -> Cryptohashsha512View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_view_len(s : Cryptohashsha512View) -> Int { s.size }

pub fn crypto_hash_sha512_view_get(s : Cryptohashsha512View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_view_set(s : Cryptohashsha512View, i : Int, v : Double) -> Cryptohashsha512View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_view_sum(s : Cryptohashsha512View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_view_mean(s : Cryptohashsha512View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_view_scale(s : Cryptohashsha512View, f : Double) -> Cryptohashsha512View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_view_add(a : Cryptohashsha512View, b : Cryptohashsha512View) -> Cryptohashsha512View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_view_copy(s : Cryptohashsha512View) -> Cryptohashsha512View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_view_fill(s : Cryptohashsha512View, v : Double) -> Cryptohashsha512View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_view_min(s : Cryptohashsha512View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_view_max(s : Cryptohashsha512View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_view_to_string(s : Cryptohashsha512View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_range_make(size : Int) -> Cryptohashsha512Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_range_len(s : Cryptohashsha512Range) -> Int { s.size }

pub fn crypto_hash_sha512_range_get(s : Cryptohashsha512Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_range_set(s : Cryptohashsha512Range, i : Int, v : Double) -> Cryptohashsha512Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_range_sum(s : Cryptohashsha512Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_range_mean(s : Cryptohashsha512Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_range_scale(s : Cryptohashsha512Range, f : Double) -> Cryptohashsha512Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_range_add(a : Cryptohashsha512Range, b : Cryptohashsha512Range) -> Cryptohashsha512Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_range_copy(s : Cryptohashsha512Range) -> Cryptohashsha512Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_range_fill(s : Cryptohashsha512Range, v : Double) -> Cryptohashsha512Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_range_min(s : Cryptohashsha512Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_range_max(s : Cryptohashsha512Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_range_to_string(s : Cryptohashsha512Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_slice_make(size : Int) -> Cryptohashsha512Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_slice_len(s : Cryptohashsha512Slice) -> Int { s.size }

pub fn crypto_hash_sha512_slice_get(s : Cryptohashsha512Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_slice_set(s : Cryptohashsha512Slice, i : Int, v : Double) -> Cryptohashsha512Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_slice_sum(s : Cryptohashsha512Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha512_slice_mean(s : Cryptohashsha512Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha512_slice_scale(s : Cryptohashsha512Slice, f : Double) -> Cryptohashsha512Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_slice_add(a : Cryptohashsha512Slice, b : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha512_slice_copy(s : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_slice_fill(s : Cryptohashsha512Slice, v : Double) -> Cryptohashsha512Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha512_slice_min(s : Cryptohashsha512Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha512_slice_max(s : Cryptohashsha512Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha512_slice_to_string(s : Cryptohashsha512Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

