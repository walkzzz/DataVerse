///===
/// extcore/crypto_hash_sha3

pub(all) struct Cryptohashsha3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha3_make_point(x : Double, y : Double) -> Cryptohashsha3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha3Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha3Point::x(self : Cryptohashsha3Point) -> Double { self.x }

pub fn Cryptohashsha3Point::y(self : Cryptohashsha3Point) -> Double { self.y }

pub fn Cryptohashsha3Point::z(self : Cryptohashsha3Point) -> Double { self.z }

pub fn Cryptohashsha3Point::label(self : Cryptohashsha3Point) -> Int { self.label }

pub fn Cryptohashsha3Point::dist(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha3Point::add(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha3Point::sub(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha3Point::scale(self : Cryptohashsha3Point, s : Double) -> Cryptohashsha3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha3Point::dot(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha3Point::cross(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha3Point::norm(self : Cryptohashsha3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha3Point::normalize(self : Cryptohashsha3Point) -> Cryptohashsha3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha3Point::negate(self : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha3Point::mid(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha3Point::lerp(self : Cryptohashsha3Point, other : Cryptohashsha3Point, t : Double) -> Cryptohashsha3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha3Point::to_string(self : Cryptohashsha3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha3_make_series(vals : Array[Double], name : String) -> Cryptohashsha3Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha3Series::len(self : Cryptohashsha3Series) -> Int { self.vals.length() }

pub fn Cryptohashsha3Series::sum(self : Cryptohashsha3Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha3Series::mean(self : Cryptohashsha3Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha3Series::min(self : Cryptohashsha3Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha3Series::max(self : Cryptohashsha3Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha3Series::range(self : Cryptohashsha3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha3Series::variance(self : Cryptohashsha3Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha3Series::std(self : Cryptohashsha3Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha3Series::median(self : Cryptohashsha3Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha3Series::scale(self : Cryptohashsha3Series, f : Double) -> Cryptohashsha3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::add(self : Cryptohashsha3Series, other : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::sub(self : Cryptohashsha3Series, other : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::normalize(self : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha3Series::cumsum(self : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha3Series::to_string(self : Cryptohashsha3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha3_matrix_identity(n : Int) -> Cryptohashsha3Matrix {
  let m = crypto_hash_sha3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha3Matrix::get(self : Cryptohashsha3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha3Matrix::transpose(self : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha3Matrix::add(self : Cryptohashsha3Matrix, other : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha3Matrix::scale(self : Cryptohashsha3Matrix, s : Double) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha3Matrix::multiply(self : Cryptohashsha3Matrix, other : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if self.cols != other.rows { return crypto_hash_sha3_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashsha3Matrix::trace(self : Cryptohashsha3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha3Matrix::det(self : Cryptohashsha3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha3Matrix::norm(self : Cryptohashsha3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha3Matrix::to_string(self : Cryptohashsha3Matrix) -> String {
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

pub(all) struct Cryptohashsha3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha3_make_vector(comps : Array[Double]) -> Cryptohashsha3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha3_vector_zero(dim : Int) -> Cryptohashsha3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha3Vector::add(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha3Vector::sub(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha3Vector::scale(self : Cryptohashsha3Vector, s : Double) -> Cryptohashsha3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha3Vector::dot(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha3Vector::norm(self : Cryptohashsha3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha3Vector::normalize(self : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha3Vector::dist(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha3Vector::to_string(self : Cryptohashsha3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha3_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha3_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha3_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha3_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha3_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha3_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha3_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha3_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha3_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha3_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha3_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha3_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha3_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha3_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha3_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha3_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha3_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha3_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha3_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha3_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha3_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha3_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha3_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha3_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha3_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha3_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha3_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha3_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha3_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_frame_make(size : Int) -> Cryptohashsha3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_frame_len(s : Cryptohashsha3Frame) -> Int { s.size }

pub fn crypto_hash_sha3_frame_get(s : Cryptohashsha3Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_frame_set(s : Cryptohashsha3Frame, i : Int, v : Double) -> Cryptohashsha3Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_frame_sum(s : Cryptohashsha3Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_frame_mean(s : Cryptohashsha3Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_frame_scale(s : Cryptohashsha3Frame, f : Double) -> Cryptohashsha3Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_frame_add(a : Cryptohashsha3Frame, b : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_frame_copy(s : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_frame_fill(s : Cryptohashsha3Frame, v : Double) -> Cryptohashsha3Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_frame_min(s : Cryptohashsha3Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_frame_max(s : Cryptohashsha3Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_frame_to_string(s : Cryptohashsha3Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_table_make(size : Int) -> Cryptohashsha3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_table_len(s : Cryptohashsha3Table) -> Int { s.size }

pub fn crypto_hash_sha3_table_get(s : Cryptohashsha3Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_table_set(s : Cryptohashsha3Table, i : Int, v : Double) -> Cryptohashsha3Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_table_sum(s : Cryptohashsha3Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_table_mean(s : Cryptohashsha3Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_table_scale(s : Cryptohashsha3Table, f : Double) -> Cryptohashsha3Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_table_add(a : Cryptohashsha3Table, b : Cryptohashsha3Table) -> Cryptohashsha3Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_table_copy(s : Cryptohashsha3Table) -> Cryptohashsha3Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_table_fill(s : Cryptohashsha3Table, v : Double) -> Cryptohashsha3Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_table_min(s : Cryptohashsha3Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_table_max(s : Cryptohashsha3Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_table_to_string(s : Cryptohashsha3Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_graphn_make(size : Int) -> Cryptohashsha3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_graphn_len(s : Cryptohashsha3GraphN) -> Int { s.size }

pub fn crypto_hash_sha3_graphn_get(s : Cryptohashsha3GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_graphn_set(s : Cryptohashsha3GraphN, i : Int, v : Double) -> Cryptohashsha3GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_graphn_sum(s : Cryptohashsha3GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_graphn_mean(s : Cryptohashsha3GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_graphn_scale(s : Cryptohashsha3GraphN, f : Double) -> Cryptohashsha3GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_graphn_add(a : Cryptohashsha3GraphN, b : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_graphn_copy(s : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_graphn_fill(s : Cryptohashsha3GraphN, v : Double) -> Cryptohashsha3GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_graphn_min(s : Cryptohashsha3GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_graphn_max(s : Cryptohashsha3GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_graphn_to_string(s : Cryptohashsha3GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_node_make(size : Int) -> Cryptohashsha3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_node_len(s : Cryptohashsha3Node) -> Int { s.size }

pub fn crypto_hash_sha3_node_get(s : Cryptohashsha3Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_node_set(s : Cryptohashsha3Node, i : Int, v : Double) -> Cryptohashsha3Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_node_sum(s : Cryptohashsha3Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_node_mean(s : Cryptohashsha3Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_node_scale(s : Cryptohashsha3Node, f : Double) -> Cryptohashsha3Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_node_add(a : Cryptohashsha3Node, b : Cryptohashsha3Node) -> Cryptohashsha3Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_node_copy(s : Cryptohashsha3Node) -> Cryptohashsha3Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_node_fill(s : Cryptohashsha3Node, v : Double) -> Cryptohashsha3Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_node_min(s : Cryptohashsha3Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_node_max(s : Cryptohashsha3Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_node_to_string(s : Cryptohashsha3Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_edge_make(size : Int) -> Cryptohashsha3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_edge_len(s : Cryptohashsha3Edge) -> Int { s.size }

pub fn crypto_hash_sha3_edge_get(s : Cryptohashsha3Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_edge_set(s : Cryptohashsha3Edge, i : Int, v : Double) -> Cryptohashsha3Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_edge_sum(s : Cryptohashsha3Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_edge_mean(s : Cryptohashsha3Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_edge_scale(s : Cryptohashsha3Edge, f : Double) -> Cryptohashsha3Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_edge_add(a : Cryptohashsha3Edge, b : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_edge_copy(s : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_edge_fill(s : Cryptohashsha3Edge, v : Double) -> Cryptohashsha3Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_edge_min(s : Cryptohashsha3Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_edge_max(s : Cryptohashsha3Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_edge_to_string(s : Cryptohashsha3Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_path_make(size : Int) -> Cryptohashsha3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_path_len(s : Cryptohashsha3Path) -> Int { s.size }

pub fn crypto_hash_sha3_path_get(s : Cryptohashsha3Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_path_set(s : Cryptohashsha3Path, i : Int, v : Double) -> Cryptohashsha3Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_path_sum(s : Cryptohashsha3Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_path_mean(s : Cryptohashsha3Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_path_scale(s : Cryptohashsha3Path, f : Double) -> Cryptohashsha3Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_path_add(a : Cryptohashsha3Path, b : Cryptohashsha3Path) -> Cryptohashsha3Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_path_copy(s : Cryptohashsha3Path) -> Cryptohashsha3Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_path_fill(s : Cryptohashsha3Path, v : Double) -> Cryptohashsha3Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_path_min(s : Cryptohashsha3Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_path_max(s : Cryptohashsha3Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_path_to_string(s : Cryptohashsha3Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cluster_make(size : Int) -> Cryptohashsha3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_cluster_len(s : Cryptohashsha3Cluster) -> Int { s.size }

pub fn crypto_hash_sha3_cluster_get(s : Cryptohashsha3Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_cluster_set(s : Cryptohashsha3Cluster, i : Int, v : Double) -> Cryptohashsha3Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cluster_sum(s : Cryptohashsha3Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_cluster_mean(s : Cryptohashsha3Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_cluster_scale(s : Cryptohashsha3Cluster, f : Double) -> Cryptohashsha3Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cluster_add(a : Cryptohashsha3Cluster, b : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_cluster_copy(s : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cluster_fill(s : Cryptohashsha3Cluster, v : Double) -> Cryptohashsha3Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cluster_min(s : Cryptohashsha3Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_cluster_max(s : Cryptohashsha3Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_cluster_to_string(s : Cryptohashsha3Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_model_make(size : Int) -> Cryptohashsha3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_model_len(s : Cryptohashsha3Model) -> Int { s.size }

pub fn crypto_hash_sha3_model_get(s : Cryptohashsha3Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_model_set(s : Cryptohashsha3Model, i : Int, v : Double) -> Cryptohashsha3Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_model_sum(s : Cryptohashsha3Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_model_mean(s : Cryptohashsha3Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_model_scale(s : Cryptohashsha3Model, f : Double) -> Cryptohashsha3Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_model_add(a : Cryptohashsha3Model, b : Cryptohashsha3Model) -> Cryptohashsha3Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_model_copy(s : Cryptohashsha3Model) -> Cryptohashsha3Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_model_fill(s : Cryptohashsha3Model, v : Double) -> Cryptohashsha3Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_model_min(s : Cryptohashsha3Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_model_max(s : Cryptohashsha3Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_model_to_string(s : Cryptohashsha3Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_layer_make(size : Int) -> Cryptohashsha3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_layer_len(s : Cryptohashsha3Layer) -> Int { s.size }

pub fn crypto_hash_sha3_layer_get(s : Cryptohashsha3Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_layer_set(s : Cryptohashsha3Layer, i : Int, v : Double) -> Cryptohashsha3Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_layer_sum(s : Cryptohashsha3Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_layer_mean(s : Cryptohashsha3Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_layer_scale(s : Cryptohashsha3Layer, f : Double) -> Cryptohashsha3Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_layer_add(a : Cryptohashsha3Layer, b : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_layer_copy(s : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_layer_fill(s : Cryptohashsha3Layer, v : Double) -> Cryptohashsha3Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_layer_min(s : Cryptohashsha3Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_layer_max(s : Cryptohashsha3Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_layer_to_string(s : Cryptohashsha3Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_buffer_make(size : Int) -> Cryptohashsha3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_buffer_len(s : Cryptohashsha3Buffer) -> Int { s.size }

pub fn crypto_hash_sha3_buffer_get(s : Cryptohashsha3Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_buffer_set(s : Cryptohashsha3Buffer, i : Int, v : Double) -> Cryptohashsha3Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_buffer_sum(s : Cryptohashsha3Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_buffer_mean(s : Cryptohashsha3Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_buffer_scale(s : Cryptohashsha3Buffer, f : Double) -> Cryptohashsha3Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_buffer_add(a : Cryptohashsha3Buffer, b : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_buffer_copy(s : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_buffer_fill(s : Cryptohashsha3Buffer, v : Double) -> Cryptohashsha3Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_buffer_min(s : Cryptohashsha3Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_buffer_max(s : Cryptohashsha3Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_buffer_to_string(s : Cryptohashsha3Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cursor_make(size : Int) -> Cryptohashsha3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_cursor_len(s : Cryptohashsha3Cursor) -> Int { s.size }

pub fn crypto_hash_sha3_cursor_get(s : Cryptohashsha3Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_cursor_set(s : Cryptohashsha3Cursor, i : Int, v : Double) -> Cryptohashsha3Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cursor_sum(s : Cryptohashsha3Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_cursor_mean(s : Cryptohashsha3Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_cursor_scale(s : Cryptohashsha3Cursor, f : Double) -> Cryptohashsha3Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cursor_add(a : Cryptohashsha3Cursor, b : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_cursor_copy(s : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cursor_fill(s : Cryptohashsha3Cursor, v : Double) -> Cryptohashsha3Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_cursor_min(s : Cryptohashsha3Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_cursor_max(s : Cryptohashsha3Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_cursor_to_string(s : Cryptohashsha3Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_view_make(size : Int) -> Cryptohashsha3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_view_len(s : Cryptohashsha3View) -> Int { s.size }

pub fn crypto_hash_sha3_view_get(s : Cryptohashsha3View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_view_set(s : Cryptohashsha3View, i : Int, v : Double) -> Cryptohashsha3View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_view_sum(s : Cryptohashsha3View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_view_mean(s : Cryptohashsha3View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_view_scale(s : Cryptohashsha3View, f : Double) -> Cryptohashsha3View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_view_add(a : Cryptohashsha3View, b : Cryptohashsha3View) -> Cryptohashsha3View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_view_copy(s : Cryptohashsha3View) -> Cryptohashsha3View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_view_fill(s : Cryptohashsha3View, v : Double) -> Cryptohashsha3View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_view_min(s : Cryptohashsha3View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_view_max(s : Cryptohashsha3View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_view_to_string(s : Cryptohashsha3View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_range_make(size : Int) -> Cryptohashsha3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_range_len(s : Cryptohashsha3Range) -> Int { s.size }

pub fn crypto_hash_sha3_range_get(s : Cryptohashsha3Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_range_set(s : Cryptohashsha3Range, i : Int, v : Double) -> Cryptohashsha3Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_range_sum(s : Cryptohashsha3Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_range_mean(s : Cryptohashsha3Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_range_scale(s : Cryptohashsha3Range, f : Double) -> Cryptohashsha3Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_range_add(a : Cryptohashsha3Range, b : Cryptohashsha3Range) -> Cryptohashsha3Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_range_copy(s : Cryptohashsha3Range) -> Cryptohashsha3Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_range_fill(s : Cryptohashsha3Range, v : Double) -> Cryptohashsha3Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_range_min(s : Cryptohashsha3Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_range_max(s : Cryptohashsha3Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_range_to_string(s : Cryptohashsha3Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_slice_make(size : Int) -> Cryptohashsha3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_slice_len(s : Cryptohashsha3Slice) -> Int { s.size }

pub fn crypto_hash_sha3_slice_get(s : Cryptohashsha3Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_slice_set(s : Cryptohashsha3Slice, i : Int, v : Double) -> Cryptohashsha3Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_slice_sum(s : Cryptohashsha3Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_sha3_slice_mean(s : Cryptohashsha3Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_sha3_slice_scale(s : Cryptohashsha3Slice, f : Double) -> Cryptohashsha3Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_slice_add(a : Cryptohashsha3Slice, b : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_sha3_slice_copy(s : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_slice_fill(s : Cryptohashsha3Slice, v : Double) -> Cryptohashsha3Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_sha3_slice_min(s : Cryptohashsha3Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_sha3_slice_max(s : Cryptohashsha3Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_sha3_slice_to_string(s : Cryptohashsha3Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

