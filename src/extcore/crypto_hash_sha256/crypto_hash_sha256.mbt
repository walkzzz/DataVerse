///===
/// extcore/crypto_hash_sha256

pub(all) struct Cryptohashsha256Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha256_make_point(x : Double, y : Double) -> Cryptohashsha256Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha256_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha256Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha256Point::x(self : Cryptohashsha256Point) -> Double { self.x }

pub fn Cryptohashsha256Point::y(self : Cryptohashsha256Point) -> Double { self.y }

pub fn Cryptohashsha256Point::z(self : Cryptohashsha256Point) -> Double { self.z }

pub fn Cryptohashsha256Point::label(self : Cryptohashsha256Point) -> Int { self.label }

pub fn Cryptohashsha256Point::dist(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha256Point::add(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha256Point::sub(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha256Point::scale(self : Cryptohashsha256Point, s : Double) -> Cryptohashsha256Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha256Point::dot(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha256Point::cross(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha256Point::norm(self : Cryptohashsha256Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha256Point::normalize(self : Cryptohashsha256Point) -> Cryptohashsha256Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha256Point::negate(self : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha256Point::mid(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha256Point::lerp(self : Cryptohashsha256Point, other : Cryptohashsha256Point, t : Double) -> Cryptohashsha256Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha256Point::to_string(self : Cryptohashsha256Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha256Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha256_make_series(vals : Array[Double], name : String) -> Cryptohashsha256Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha256Series::len(self : Cryptohashsha256Series) -> Int { self.vals.length() }

pub fn Cryptohashsha256Series::sum(self : Cryptohashsha256Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha256Series::mean(self : Cryptohashsha256Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha256Series::min(self : Cryptohashsha256Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha256Series::max(self : Cryptohashsha256Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha256Series::range(self : Cryptohashsha256Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha256Series::variance(self : Cryptohashsha256Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha256Series::std(self : Cryptohashsha256Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha256Series::median(self : Cryptohashsha256Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha256Series::scale(self : Cryptohashsha256Series, f : Double) -> Cryptohashsha256Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::add(self : Cryptohashsha256Series, other : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::sub(self : Cryptohashsha256Series, other : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::normalize(self : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha256Series::cumsum(self : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha256Series::to_string(self : Cryptohashsha256Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha256Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha256_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha256Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha256_matrix_identity(n : Int) -> Cryptohashsha256Matrix {
  let m = crypto_hash_sha256_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha256Matrix::get(self : Cryptohashsha256Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha256Matrix::transpose(self : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha256Matrix::add(self : Cryptohashsha256Matrix, other : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha256_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha256Matrix::scale(self : Cryptohashsha256Matrix, s : Double) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha256Matrix::multiply(self : Cryptohashsha256Matrix, other : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if self.cols != other.rows { return crypto_hash_sha256_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha256_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashsha256Matrix::trace(self : Cryptohashsha256Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha256Matrix::det(self : Cryptohashsha256Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha256Matrix::norm(self : Cryptohashsha256Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha256Matrix::to_string(self : Cryptohashsha256Matrix) -> String {
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

pub(all) struct Cryptohashsha256Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha256_make_vector(comps : Array[Double]) -> Cryptohashsha256Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha256_vector_zero(dim : Int) -> Cryptohashsha256Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha256Vector::add(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha256Vector::sub(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha256Vector::scale(self : Cryptohashsha256Vector, s : Double) -> Cryptohashsha256Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha256Vector::dot(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha256Vector::norm(self : Cryptohashsha256Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha256Vector::normalize(self : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha256Vector::dist(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha256Vector::to_string(self : Cryptohashsha256Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha256_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha256_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha256_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha256_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha256_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha256_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha256_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha256_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha256_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha256_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha256_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha256_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha256_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha256_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha256_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha256_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha256_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha256_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha256_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha256_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha256_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha256_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha256_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha256_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha256_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha256_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha256_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha256_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha256_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha256Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_frame_make(size : Int) -> Cryptohashsha256Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_frame_len(s : Cryptohashsha256Frame) -> Int { s.size }

pub fn crypto_hash_sha256_frame_get(s : Cryptohashsha256Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_frame_set(s : Cryptohashsha256Frame, i : Int, v : Double) -> Cryptohashsha256Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_frame_sum(s : Cryptohashsha256Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_frame_mean(s : Cryptohashsha256Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_frame_scale(s : Cryptohashsha256Frame, f : Double) -> Cryptohashsha256Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_frame_add(a : Cryptohashsha256Frame, b : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_frame_copy(s : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_frame_fill(s : Cryptohashsha256Frame, v : Double) -> Cryptohashsha256Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_frame_min(s : Cryptohashsha256Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_frame_max(s : Cryptohashsha256Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_frame_to_string(s : Cryptohashsha256Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_table_make(size : Int) -> Cryptohashsha256Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_table_len(s : Cryptohashsha256Table) -> Int { s.size }

pub fn crypto_hash_sha256_table_get(s : Cryptohashsha256Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_table_set(s : Cryptohashsha256Table, i : Int, v : Double) -> Cryptohashsha256Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_table_sum(s : Cryptohashsha256Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_table_mean(s : Cryptohashsha256Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_table_scale(s : Cryptohashsha256Table, f : Double) -> Cryptohashsha256Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_table_add(a : Cryptohashsha256Table, b : Cryptohashsha256Table) -> Cryptohashsha256Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_table_copy(s : Cryptohashsha256Table) -> Cryptohashsha256Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_table_fill(s : Cryptohashsha256Table, v : Double) -> Cryptohashsha256Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_table_min(s : Cryptohashsha256Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_table_max(s : Cryptohashsha256Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_table_to_string(s : Cryptohashsha256Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_graphn_make(size : Int) -> Cryptohashsha256GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_graphn_len(s : Cryptohashsha256GraphN) -> Int { s.size }

pub fn crypto_hash_sha256_graphn_get(s : Cryptohashsha256GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_graphn_set(s : Cryptohashsha256GraphN, i : Int, v : Double) -> Cryptohashsha256GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_graphn_sum(s : Cryptohashsha256GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_graphn_mean(s : Cryptohashsha256GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_graphn_scale(s : Cryptohashsha256GraphN, f : Double) -> Cryptohashsha256GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_graphn_add(a : Cryptohashsha256GraphN, b : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_graphn_copy(s : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_graphn_fill(s : Cryptohashsha256GraphN, v : Double) -> Cryptohashsha256GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_graphn_min(s : Cryptohashsha256GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_graphn_max(s : Cryptohashsha256GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_graphn_to_string(s : Cryptohashsha256GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_node_make(size : Int) -> Cryptohashsha256Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_node_len(s : Cryptohashsha256Node) -> Int { s.size }

pub fn crypto_hash_sha256_node_get(s : Cryptohashsha256Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_node_set(s : Cryptohashsha256Node, i : Int, v : Double) -> Cryptohashsha256Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_node_sum(s : Cryptohashsha256Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_node_mean(s : Cryptohashsha256Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_node_scale(s : Cryptohashsha256Node, f : Double) -> Cryptohashsha256Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_node_add(a : Cryptohashsha256Node, b : Cryptohashsha256Node) -> Cryptohashsha256Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_node_copy(s : Cryptohashsha256Node) -> Cryptohashsha256Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_node_fill(s : Cryptohashsha256Node, v : Double) -> Cryptohashsha256Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_node_min(s : Cryptohashsha256Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_node_max(s : Cryptohashsha256Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_node_to_string(s : Cryptohashsha256Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_edge_make(size : Int) -> Cryptohashsha256Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_edge_len(s : Cryptohashsha256Edge) -> Int { s.size }

pub fn crypto_hash_sha256_edge_get(s : Cryptohashsha256Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_edge_set(s : Cryptohashsha256Edge, i : Int, v : Double) -> Cryptohashsha256Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_edge_sum(s : Cryptohashsha256Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_edge_mean(s : Cryptohashsha256Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_edge_scale(s : Cryptohashsha256Edge, f : Double) -> Cryptohashsha256Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_edge_add(a : Cryptohashsha256Edge, b : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_edge_copy(s : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_edge_fill(s : Cryptohashsha256Edge, v : Double) -> Cryptohashsha256Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_edge_min(s : Cryptohashsha256Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_edge_max(s : Cryptohashsha256Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_edge_to_string(s : Cryptohashsha256Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_path_make(size : Int) -> Cryptohashsha256Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_path_len(s : Cryptohashsha256Path) -> Int { s.size }

pub fn crypto_hash_sha256_path_get(s : Cryptohashsha256Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_path_set(s : Cryptohashsha256Path, i : Int, v : Double) -> Cryptohashsha256Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_path_sum(s : Cryptohashsha256Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_path_mean(s : Cryptohashsha256Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_path_scale(s : Cryptohashsha256Path, f : Double) -> Cryptohashsha256Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_path_add(a : Cryptohashsha256Path, b : Cryptohashsha256Path) -> Cryptohashsha256Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_path_copy(s : Cryptohashsha256Path) -> Cryptohashsha256Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_path_fill(s : Cryptohashsha256Path, v : Double) -> Cryptohashsha256Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_path_min(s : Cryptohashsha256Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_path_max(s : Cryptohashsha256Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_path_to_string(s : Cryptohashsha256Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cluster_make(size : Int) -> Cryptohashsha256Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_cluster_len(s : Cryptohashsha256Cluster) -> Int { s.size }

pub fn crypto_hash_sha256_cluster_get(s : Cryptohashsha256Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_cluster_set(s : Cryptohashsha256Cluster, i : Int, v : Double) -> Cryptohashsha256Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cluster_sum(s : Cryptohashsha256Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_cluster_mean(s : Cryptohashsha256Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_cluster_scale(s : Cryptohashsha256Cluster, f : Double) -> Cryptohashsha256Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cluster_add(a : Cryptohashsha256Cluster, b : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_cluster_copy(s : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cluster_fill(s : Cryptohashsha256Cluster, v : Double) -> Cryptohashsha256Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cluster_min(s : Cryptohashsha256Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_cluster_max(s : Cryptohashsha256Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_cluster_to_string(s : Cryptohashsha256Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_model_make(size : Int) -> Cryptohashsha256Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_model_len(s : Cryptohashsha256Model) -> Int { s.size }

pub fn crypto_hash_sha256_model_get(s : Cryptohashsha256Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_model_set(s : Cryptohashsha256Model, i : Int, v : Double) -> Cryptohashsha256Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_model_sum(s : Cryptohashsha256Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_model_mean(s : Cryptohashsha256Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_model_scale(s : Cryptohashsha256Model, f : Double) -> Cryptohashsha256Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_model_add(a : Cryptohashsha256Model, b : Cryptohashsha256Model) -> Cryptohashsha256Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_model_copy(s : Cryptohashsha256Model) -> Cryptohashsha256Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_model_fill(s : Cryptohashsha256Model, v : Double) -> Cryptohashsha256Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_model_min(s : Cryptohashsha256Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_model_max(s : Cryptohashsha256Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_model_to_string(s : Cryptohashsha256Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_layer_make(size : Int) -> Cryptohashsha256Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_layer_len(s : Cryptohashsha256Layer) -> Int { s.size }

pub fn crypto_hash_sha256_layer_get(s : Cryptohashsha256Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_layer_set(s : Cryptohashsha256Layer, i : Int, v : Double) -> Cryptohashsha256Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_layer_sum(s : Cryptohashsha256Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_layer_mean(s : Cryptohashsha256Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_layer_scale(s : Cryptohashsha256Layer, f : Double) -> Cryptohashsha256Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_layer_add(a : Cryptohashsha256Layer, b : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_layer_copy(s : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_layer_fill(s : Cryptohashsha256Layer, v : Double) -> Cryptohashsha256Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_layer_min(s : Cryptohashsha256Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_layer_max(s : Cryptohashsha256Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_layer_to_string(s : Cryptohashsha256Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_buffer_make(size : Int) -> Cryptohashsha256Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_buffer_len(s : Cryptohashsha256Buffer) -> Int { s.size }

pub fn crypto_hash_sha256_buffer_get(s : Cryptohashsha256Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_buffer_set(s : Cryptohashsha256Buffer, i : Int, v : Double) -> Cryptohashsha256Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_buffer_sum(s : Cryptohashsha256Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_buffer_mean(s : Cryptohashsha256Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_buffer_scale(s : Cryptohashsha256Buffer, f : Double) -> Cryptohashsha256Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_buffer_add(a : Cryptohashsha256Buffer, b : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_buffer_copy(s : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_buffer_fill(s : Cryptohashsha256Buffer, v : Double) -> Cryptohashsha256Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_buffer_min(s : Cryptohashsha256Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_buffer_max(s : Cryptohashsha256Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_buffer_to_string(s : Cryptohashsha256Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cursor_make(size : Int) -> Cryptohashsha256Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_cursor_len(s : Cryptohashsha256Cursor) -> Int { s.size }

pub fn crypto_hash_sha256_cursor_get(s : Cryptohashsha256Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_cursor_set(s : Cryptohashsha256Cursor, i : Int, v : Double) -> Cryptohashsha256Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cursor_sum(s : Cryptohashsha256Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_cursor_mean(s : Cryptohashsha256Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_cursor_scale(s : Cryptohashsha256Cursor, f : Double) -> Cryptohashsha256Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cursor_add(a : Cryptohashsha256Cursor, b : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_cursor_copy(s : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cursor_fill(s : Cryptohashsha256Cursor, v : Double) -> Cryptohashsha256Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_cursor_min(s : Cryptohashsha256Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_cursor_max(s : Cryptohashsha256Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_cursor_to_string(s : Cryptohashsha256Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_view_make(size : Int) -> Cryptohashsha256View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_view_len(s : Cryptohashsha256View) -> Int { s.size }

pub fn crypto_hash_sha256_view_get(s : Cryptohashsha256View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_view_set(s : Cryptohashsha256View, i : Int, v : Double) -> Cryptohashsha256View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_view_sum(s : Cryptohashsha256View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_view_mean(s : Cryptohashsha256View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_view_scale(s : Cryptohashsha256View, f : Double) -> Cryptohashsha256View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_view_add(a : Cryptohashsha256View, b : Cryptohashsha256View) -> Cryptohashsha256View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_view_copy(s : Cryptohashsha256View) -> Cryptohashsha256View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_view_fill(s : Cryptohashsha256View, v : Double) -> Cryptohashsha256View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_view_min(s : Cryptohashsha256View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_view_max(s : Cryptohashsha256View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_view_to_string(s : Cryptohashsha256View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_range_make(size : Int) -> Cryptohashsha256Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_range_len(s : Cryptohashsha256Range) -> Int { s.size }

pub fn crypto_hash_sha256_range_get(s : Cryptohashsha256Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_range_set(s : Cryptohashsha256Range, i : Int, v : Double) -> Cryptohashsha256Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_range_sum(s : Cryptohashsha256Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_range_mean(s : Cryptohashsha256Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_range_scale(s : Cryptohashsha256Range, f : Double) -> Cryptohashsha256Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_range_add(a : Cryptohashsha256Range, b : Cryptohashsha256Range) -> Cryptohashsha256Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_range_copy(s : Cryptohashsha256Range) -> Cryptohashsha256Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_range_fill(s : Cryptohashsha256Range, v : Double) -> Cryptohashsha256Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_range_min(s : Cryptohashsha256Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_range_max(s : Cryptohashsha256Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_range_to_string(s : Cryptohashsha256Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_slice_make(size : Int) -> Cryptohashsha256Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_slice_len(s : Cryptohashsha256Slice) -> Int { s.size }

pub fn crypto_hash_sha256_slice_get(s : Cryptohashsha256Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_slice_set(s : Cryptohashsha256Slice, i : Int, v : Double) -> Cryptohashsha256Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_slice_sum(s : Cryptohashsha256Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha256_slice_mean(s : Cryptohashsha256Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha256_slice_scale(s : Cryptohashsha256Slice, f : Double) -> Cryptohashsha256Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_slice_add(a : Cryptohashsha256Slice, b : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha256_slice_copy(s : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_slice_fill(s : Cryptohashsha256Slice, v : Double) -> Cryptohashsha256Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha256_slice_min(s : Cryptohashsha256Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha256_slice_max(s : Cryptohashsha256Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha256_slice_to_string(s : Cryptohashsha256Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

