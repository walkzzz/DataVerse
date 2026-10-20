///===
/// extcore/crypto_hash_sha1

pub(all) struct Cryptohashsha1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha1_make_point(x : Double, y : Double) -> Cryptohashsha1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha1_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha1Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha1Point::x(self : Cryptohashsha1Point) -> Double { self.x }

pub fn Cryptohashsha1Point::y(self : Cryptohashsha1Point) -> Double { self.y }

pub fn Cryptohashsha1Point::z(self : Cryptohashsha1Point) -> Double { self.z }

pub fn Cryptohashsha1Point::label(self : Cryptohashsha1Point) -> Int { self.label }

pub fn Cryptohashsha1Point::dist(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha1Point::add(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha1Point::sub(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha1Point::scale(self : Cryptohashsha1Point, s : Double) -> Cryptohashsha1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha1Point::dot(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha1Point::cross(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha1Point::norm(self : Cryptohashsha1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha1Point::normalize(self : Cryptohashsha1Point) -> Cryptohashsha1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha1Point::negate(self : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha1Point::mid(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha1Point::lerp(self : Cryptohashsha1Point, other : Cryptohashsha1Point, t : Double) -> Cryptohashsha1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha1Point::to_string(self : Cryptohashsha1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha1_make_series(vals : Array[Double], name : String) -> Cryptohashsha1Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha1Series::len(self : Cryptohashsha1Series) -> Int { self.vals.length() }

pub fn Cryptohashsha1Series::sum(self : Cryptohashsha1Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha1Series::mean(self : Cryptohashsha1Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha1Series::min(self : Cryptohashsha1Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha1Series::max(self : Cryptohashsha1Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha1Series::range(self : Cryptohashsha1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha1Series::variance(self : Cryptohashsha1Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha1Series::std(self : Cryptohashsha1Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha1Series::median(self : Cryptohashsha1Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha1Series::scale(self : Cryptohashsha1Series, f : Double) -> Cryptohashsha1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::add(self : Cryptohashsha1Series, other : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::sub(self : Cryptohashsha1Series, other : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::normalize(self : Cryptohashsha1Series) -> Cryptohashsha1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha1Series::cumsum(self : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha1Series::to_string(self : Cryptohashsha1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha1_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha1_matrix_identity(n : Int) -> Cryptohashsha1Matrix {
  let m = crypto_hash_sha1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha1Matrix::get(self : Cryptohashsha1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha1Matrix::transpose(self : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha1Matrix::add(self : Cryptohashsha1Matrix, other : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha1Matrix::scale(self : Cryptohashsha1Matrix, s : Double) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha1Matrix::multiply(self : Cryptohashsha1Matrix, other : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if self.cols != other.rows { return crypto_hash_sha1_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashsha1Matrix::trace(self : Cryptohashsha1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha1Matrix::det(self : Cryptohashsha1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha1Matrix::norm(self : Cryptohashsha1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha1Matrix::to_string(self : Cryptohashsha1Matrix) -> String {
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

pub(all) struct Cryptohashsha1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha1_make_vector(comps : Array[Double]) -> Cryptohashsha1Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha1_vector_zero(dim : Int) -> Cryptohashsha1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha1Vector::add(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha1Vector::sub(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha1Vector::scale(self : Cryptohashsha1Vector, s : Double) -> Cryptohashsha1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha1Vector::dot(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha1Vector::norm(self : Cryptohashsha1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha1Vector::normalize(self : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha1Vector::dist(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha1Vector::to_string(self : Cryptohashsha1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha1_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha1_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha1_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha1_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha1_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha1_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha1_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha1_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha1_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha1_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha1_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha1_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha1_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha1_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha1_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha1_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha1_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha1_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha1_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha1_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha1_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha1_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha1_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_frame_make(size : Int) -> Cryptohashsha1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_frame_len(s : Cryptohashsha1Frame) -> Int { s.size }

pub fn crypto_hash_sha1_frame_get(s : Cryptohashsha1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_frame_set(s : Cryptohashsha1Frame, i : Int, v : Double) -> Cryptohashsha1Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_frame_sum(s : Cryptohashsha1Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_frame_mean(s : Cryptohashsha1Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_frame_scale(s : Cryptohashsha1Frame, f : Double) -> Cryptohashsha1Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_frame_add(a : Cryptohashsha1Frame, b : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_frame_copy(s : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_frame_fill(s : Cryptohashsha1Frame, v : Double) -> Cryptohashsha1Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_frame_min(s : Cryptohashsha1Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_frame_max(s : Cryptohashsha1Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_frame_to_string(s : Cryptohashsha1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_table_make(size : Int) -> Cryptohashsha1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_table_len(s : Cryptohashsha1Table) -> Int { s.size }

pub fn crypto_hash_sha1_table_get(s : Cryptohashsha1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_table_set(s : Cryptohashsha1Table, i : Int, v : Double) -> Cryptohashsha1Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_table_sum(s : Cryptohashsha1Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_table_mean(s : Cryptohashsha1Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_table_scale(s : Cryptohashsha1Table, f : Double) -> Cryptohashsha1Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_table_add(a : Cryptohashsha1Table, b : Cryptohashsha1Table) -> Cryptohashsha1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_table_copy(s : Cryptohashsha1Table) -> Cryptohashsha1Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_table_fill(s : Cryptohashsha1Table, v : Double) -> Cryptohashsha1Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_table_min(s : Cryptohashsha1Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_table_max(s : Cryptohashsha1Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_table_to_string(s : Cryptohashsha1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_graphn_make(size : Int) -> Cryptohashsha1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_graphn_len(s : Cryptohashsha1GraphN) -> Int { s.size }

pub fn crypto_hash_sha1_graphn_get(s : Cryptohashsha1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_graphn_set(s : Cryptohashsha1GraphN, i : Int, v : Double) -> Cryptohashsha1GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_graphn_sum(s : Cryptohashsha1GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_graphn_mean(s : Cryptohashsha1GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_graphn_scale(s : Cryptohashsha1GraphN, f : Double) -> Cryptohashsha1GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_graphn_add(a : Cryptohashsha1GraphN, b : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_graphn_copy(s : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_graphn_fill(s : Cryptohashsha1GraphN, v : Double) -> Cryptohashsha1GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_graphn_min(s : Cryptohashsha1GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_graphn_max(s : Cryptohashsha1GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_graphn_to_string(s : Cryptohashsha1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_node_make(size : Int) -> Cryptohashsha1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_node_len(s : Cryptohashsha1Node) -> Int { s.size }

pub fn crypto_hash_sha1_node_get(s : Cryptohashsha1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_node_set(s : Cryptohashsha1Node, i : Int, v : Double) -> Cryptohashsha1Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_node_sum(s : Cryptohashsha1Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_node_mean(s : Cryptohashsha1Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_node_scale(s : Cryptohashsha1Node, f : Double) -> Cryptohashsha1Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_node_add(a : Cryptohashsha1Node, b : Cryptohashsha1Node) -> Cryptohashsha1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_node_copy(s : Cryptohashsha1Node) -> Cryptohashsha1Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_node_fill(s : Cryptohashsha1Node, v : Double) -> Cryptohashsha1Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_node_min(s : Cryptohashsha1Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_node_max(s : Cryptohashsha1Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_node_to_string(s : Cryptohashsha1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_edge_make(size : Int) -> Cryptohashsha1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_edge_len(s : Cryptohashsha1Edge) -> Int { s.size }

pub fn crypto_hash_sha1_edge_get(s : Cryptohashsha1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_edge_set(s : Cryptohashsha1Edge, i : Int, v : Double) -> Cryptohashsha1Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_edge_sum(s : Cryptohashsha1Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_edge_mean(s : Cryptohashsha1Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_edge_scale(s : Cryptohashsha1Edge, f : Double) -> Cryptohashsha1Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_edge_add(a : Cryptohashsha1Edge, b : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_edge_copy(s : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_edge_fill(s : Cryptohashsha1Edge, v : Double) -> Cryptohashsha1Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_edge_min(s : Cryptohashsha1Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_edge_max(s : Cryptohashsha1Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_edge_to_string(s : Cryptohashsha1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_path_make(size : Int) -> Cryptohashsha1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_path_len(s : Cryptohashsha1Path) -> Int { s.size }

pub fn crypto_hash_sha1_path_get(s : Cryptohashsha1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_path_set(s : Cryptohashsha1Path, i : Int, v : Double) -> Cryptohashsha1Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_path_sum(s : Cryptohashsha1Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_path_mean(s : Cryptohashsha1Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_path_scale(s : Cryptohashsha1Path, f : Double) -> Cryptohashsha1Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_path_add(a : Cryptohashsha1Path, b : Cryptohashsha1Path) -> Cryptohashsha1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_path_copy(s : Cryptohashsha1Path) -> Cryptohashsha1Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_path_fill(s : Cryptohashsha1Path, v : Double) -> Cryptohashsha1Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_path_min(s : Cryptohashsha1Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_path_max(s : Cryptohashsha1Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_path_to_string(s : Cryptohashsha1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cluster_make(size : Int) -> Cryptohashsha1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_cluster_len(s : Cryptohashsha1Cluster) -> Int { s.size }

pub fn crypto_hash_sha1_cluster_get(s : Cryptohashsha1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_cluster_set(s : Cryptohashsha1Cluster, i : Int, v : Double) -> Cryptohashsha1Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cluster_sum(s : Cryptohashsha1Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_cluster_mean(s : Cryptohashsha1Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_cluster_scale(s : Cryptohashsha1Cluster, f : Double) -> Cryptohashsha1Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cluster_add(a : Cryptohashsha1Cluster, b : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_cluster_copy(s : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cluster_fill(s : Cryptohashsha1Cluster, v : Double) -> Cryptohashsha1Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cluster_min(s : Cryptohashsha1Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_cluster_max(s : Cryptohashsha1Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_cluster_to_string(s : Cryptohashsha1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_model_make(size : Int) -> Cryptohashsha1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_model_len(s : Cryptohashsha1Model) -> Int { s.size }

pub fn crypto_hash_sha1_model_get(s : Cryptohashsha1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_model_set(s : Cryptohashsha1Model, i : Int, v : Double) -> Cryptohashsha1Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_model_sum(s : Cryptohashsha1Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_model_mean(s : Cryptohashsha1Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_model_scale(s : Cryptohashsha1Model, f : Double) -> Cryptohashsha1Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_model_add(a : Cryptohashsha1Model, b : Cryptohashsha1Model) -> Cryptohashsha1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_model_copy(s : Cryptohashsha1Model) -> Cryptohashsha1Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_model_fill(s : Cryptohashsha1Model, v : Double) -> Cryptohashsha1Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_model_min(s : Cryptohashsha1Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_model_max(s : Cryptohashsha1Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_model_to_string(s : Cryptohashsha1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_layer_make(size : Int) -> Cryptohashsha1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_layer_len(s : Cryptohashsha1Layer) -> Int { s.size }

pub fn crypto_hash_sha1_layer_get(s : Cryptohashsha1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_layer_set(s : Cryptohashsha1Layer, i : Int, v : Double) -> Cryptohashsha1Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_layer_sum(s : Cryptohashsha1Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_layer_mean(s : Cryptohashsha1Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_layer_scale(s : Cryptohashsha1Layer, f : Double) -> Cryptohashsha1Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_layer_add(a : Cryptohashsha1Layer, b : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_layer_copy(s : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_layer_fill(s : Cryptohashsha1Layer, v : Double) -> Cryptohashsha1Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_layer_min(s : Cryptohashsha1Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_layer_max(s : Cryptohashsha1Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_layer_to_string(s : Cryptohashsha1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_buffer_make(size : Int) -> Cryptohashsha1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_buffer_len(s : Cryptohashsha1Buffer) -> Int { s.size }

pub fn crypto_hash_sha1_buffer_get(s : Cryptohashsha1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_buffer_set(s : Cryptohashsha1Buffer, i : Int, v : Double) -> Cryptohashsha1Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_buffer_sum(s : Cryptohashsha1Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_buffer_mean(s : Cryptohashsha1Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_buffer_scale(s : Cryptohashsha1Buffer, f : Double) -> Cryptohashsha1Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_buffer_add(a : Cryptohashsha1Buffer, b : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_buffer_copy(s : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_buffer_fill(s : Cryptohashsha1Buffer, v : Double) -> Cryptohashsha1Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_buffer_min(s : Cryptohashsha1Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_buffer_max(s : Cryptohashsha1Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_buffer_to_string(s : Cryptohashsha1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cursor_make(size : Int) -> Cryptohashsha1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_cursor_len(s : Cryptohashsha1Cursor) -> Int { s.size }

pub fn crypto_hash_sha1_cursor_get(s : Cryptohashsha1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_cursor_set(s : Cryptohashsha1Cursor, i : Int, v : Double) -> Cryptohashsha1Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cursor_sum(s : Cryptohashsha1Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_cursor_mean(s : Cryptohashsha1Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_cursor_scale(s : Cryptohashsha1Cursor, f : Double) -> Cryptohashsha1Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cursor_add(a : Cryptohashsha1Cursor, b : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_cursor_copy(s : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cursor_fill(s : Cryptohashsha1Cursor, v : Double) -> Cryptohashsha1Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_cursor_min(s : Cryptohashsha1Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_cursor_max(s : Cryptohashsha1Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_cursor_to_string(s : Cryptohashsha1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_view_make(size : Int) -> Cryptohashsha1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_view_len(s : Cryptohashsha1View) -> Int { s.size }

pub fn crypto_hash_sha1_view_get(s : Cryptohashsha1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_view_set(s : Cryptohashsha1View, i : Int, v : Double) -> Cryptohashsha1View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_view_sum(s : Cryptohashsha1View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_view_mean(s : Cryptohashsha1View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_view_scale(s : Cryptohashsha1View, f : Double) -> Cryptohashsha1View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_view_add(a : Cryptohashsha1View, b : Cryptohashsha1View) -> Cryptohashsha1View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_view_copy(s : Cryptohashsha1View) -> Cryptohashsha1View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_view_fill(s : Cryptohashsha1View, v : Double) -> Cryptohashsha1View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_view_min(s : Cryptohashsha1View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_view_max(s : Cryptohashsha1View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_view_to_string(s : Cryptohashsha1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_range_make(size : Int) -> Cryptohashsha1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_range_len(s : Cryptohashsha1Range) -> Int { s.size }

pub fn crypto_hash_sha1_range_get(s : Cryptohashsha1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_range_set(s : Cryptohashsha1Range, i : Int, v : Double) -> Cryptohashsha1Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_range_sum(s : Cryptohashsha1Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_range_mean(s : Cryptohashsha1Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_range_scale(s : Cryptohashsha1Range, f : Double) -> Cryptohashsha1Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_range_add(a : Cryptohashsha1Range, b : Cryptohashsha1Range) -> Cryptohashsha1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_range_copy(s : Cryptohashsha1Range) -> Cryptohashsha1Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_range_fill(s : Cryptohashsha1Range, v : Double) -> Cryptohashsha1Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_range_min(s : Cryptohashsha1Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_range_max(s : Cryptohashsha1Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_range_to_string(s : Cryptohashsha1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_slice_make(size : Int) -> Cryptohashsha1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_slice_len(s : Cryptohashsha1Slice) -> Int { s.size }

pub fn crypto_hash_sha1_slice_get(s : Cryptohashsha1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_slice_set(s : Cryptohashsha1Slice, i : Int, v : Double) -> Cryptohashsha1Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_slice_sum(s : Cryptohashsha1Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha1_slice_mean(s : Cryptohashsha1Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha1_slice_scale(s : Cryptohashsha1Slice, f : Double) -> Cryptohashsha1Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_slice_add(a : Cryptohashsha1Slice, b : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha1_slice_copy(s : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_slice_fill(s : Cryptohashsha1Slice, v : Double) -> Cryptohashsha1Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha1_slice_min(s : Cryptohashsha1Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha1_slice_max(s : Cryptohashsha1Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha1_slice_to_string(s : Cryptohashsha1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

