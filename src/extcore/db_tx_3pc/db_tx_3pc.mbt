///===
/// extcore/db_tx_3pc

pub(all) struct Dbtx3pcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_3pc_make_point(x : Double, y : Double) -> Dbtx3pcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_3pc_make_point3(x : Double, y : Double, z : Double) -> Dbtx3pcPoint {
  { x, y, z, label: 0 }
}

pub fn Dbtx3pcPoint::x(self : Dbtx3pcPoint) -> Double { self.x }

pub fn Dbtx3pcPoint::y(self : Dbtx3pcPoint) -> Double { self.y }

pub fn Dbtx3pcPoint::z(self : Dbtx3pcPoint) -> Double { self.z }

pub fn Dbtx3pcPoint::label(self : Dbtx3pcPoint) -> Int { self.label }

pub fn Dbtx3pcPoint::dist(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Dbtx3pcPoint::add(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Dbtx3pcPoint::sub(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Dbtx3pcPoint::scale(self : Dbtx3pcPoint, s : Double) -> Dbtx3pcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Dbtx3pcPoint::dot(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Dbtx3pcPoint::cross(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Dbtx3pcPoint::norm(self : Dbtx3pcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Dbtx3pcPoint::normalize(self : Dbtx3pcPoint) -> Dbtx3pcPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Dbtx3pcPoint::negate(self : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Dbtx3pcPoint::mid(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Dbtx3pcPoint::lerp(self : Dbtx3pcPoint, other : Dbtx3pcPoint, t : Double) -> Dbtx3pcPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Dbtx3pcPoint::to_string(self : Dbtx3pcPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Dbtx3pcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_3pc_make_series(vals : Array[Double], name : String) -> Dbtx3pcSeries {
  { vals, name, meta: 0 }
}

pub fn Dbtx3pcSeries::len(self : Dbtx3pcSeries) -> Int { self.vals.length() }

pub fn Dbtx3pcSeries::sum(self : Dbtx3pcSeries) -> Double { @_common.sum(self.vals) }

pub fn Dbtx3pcSeries::mean(self : Dbtx3pcSeries) -> Double { @_common.mean(self.vals) }

pub fn Dbtx3pcSeries::min(self : Dbtx3pcSeries) -> Double { @_common.min(self.vals) }

pub fn Dbtx3pcSeries::max(self : Dbtx3pcSeries) -> Double { @_common.max(self.vals) }

pub fn Dbtx3pcSeries::range(self : Dbtx3pcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Dbtx3pcSeries::variance(self : Dbtx3pcSeries) -> Double { @_common.variance(self.vals) }

pub fn Dbtx3pcSeries::std(self : Dbtx3pcSeries) -> Double { @_common.std(self.vals) }

pub fn Dbtx3pcSeries::median(self : Dbtx3pcSeries) -> Double { @_common.median(self.vals) }

pub fn Dbtx3pcSeries::scale(self : Dbtx3pcSeries, f : Double) -> Dbtx3pcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::add(self : Dbtx3pcSeries, other : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::sub(self : Dbtx3pcSeries, other : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::normalize(self : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Dbtx3pcSeries::cumsum(self : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Dbtx3pcSeries::to_string(self : Dbtx3pcSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Dbtx3pcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_3pc_make_matrix(rows : Int, cols : Int, val : Double) -> Dbtx3pcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_3pc_matrix_identity(n : Int) -> Dbtx3pcMatrix {
  let m = db_tx_3pc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Dbtx3pcMatrix::get(self : Dbtx3pcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Dbtx3pcMatrix::transpose(self : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Dbtx3pcMatrix::add(self : Dbtx3pcMatrix, other : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_3pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Dbtx3pcMatrix::scale(self : Dbtx3pcMatrix, s : Double) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Dbtx3pcMatrix::multiply(self : Dbtx3pcMatrix, other : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if self.cols != other.rows { return db_tx_3pc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_3pc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Dbtx3pcMatrix::trace(self : Dbtx3pcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Dbtx3pcMatrix::det(self : Dbtx3pcMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Dbtx3pcMatrix::norm(self : Dbtx3pcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Dbtx3pcMatrix::to_string(self : Dbtx3pcMatrix) -> String {
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

pub(all) struct Dbtx3pcVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_3pc_make_vector(comps : Array[Double]) -> Dbtx3pcVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_3pc_vector_zero(dim : Int) -> Dbtx3pcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Dbtx3pcVector::add(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Dbtx3pcVector::sub(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Dbtx3pcVector::scale(self : Dbtx3pcVector, s : Double) -> Dbtx3pcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Dbtx3pcVector::dot(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Dbtx3pcVector::norm(self : Dbtx3pcVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Dbtx3pcVector::normalize(self : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Dbtx3pcVector::dist(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Double {
  self.sub(other).norm()
}

pub fn Dbtx3pcVector::to_string(self : Dbtx3pcVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_3pc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_3pc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_3pc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_3pc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_3pc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_3pc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_3pc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_3pc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_3pc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_3pc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_3pc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_3pc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_3pc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_3pc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_3pc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_3pc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_3pc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_3pc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_3pc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_3pc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_3pc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_3pc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_3pc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_3pc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_3pc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_3pc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_3pc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_3pc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_3pc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Dbtx3pcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_frame_make(size : Int) -> Dbtx3pcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_frame_len(s : Dbtx3pcFrame) -> Int { s.size }

pub fn db_tx_3pc_frame_get(s : Dbtx3pcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_frame_set(s : Dbtx3pcFrame, i : Int, v : Double) -> Dbtx3pcFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_frame_sum(s : Dbtx3pcFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_frame_mean(s : Dbtx3pcFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_frame_scale(s : Dbtx3pcFrame, f : Double) -> Dbtx3pcFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_frame_add(a : Dbtx3pcFrame, b : Dbtx3pcFrame) -> Dbtx3pcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_frame_copy(s : Dbtx3pcFrame) -> Dbtx3pcFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_frame_fill(s : Dbtx3pcFrame, v : Double) -> Dbtx3pcFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_frame_min(s : Dbtx3pcFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_frame_max(s : Dbtx3pcFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_frame_to_string(s : Dbtx3pcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_table_make(size : Int) -> Dbtx3pcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_table_len(s : Dbtx3pcTable) -> Int { s.size }

pub fn db_tx_3pc_table_get(s : Dbtx3pcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_table_set(s : Dbtx3pcTable, i : Int, v : Double) -> Dbtx3pcTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_table_sum(s : Dbtx3pcTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_table_mean(s : Dbtx3pcTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_table_scale(s : Dbtx3pcTable, f : Double) -> Dbtx3pcTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_table_add(a : Dbtx3pcTable, b : Dbtx3pcTable) -> Dbtx3pcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_table_copy(s : Dbtx3pcTable) -> Dbtx3pcTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_table_fill(s : Dbtx3pcTable, v : Double) -> Dbtx3pcTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_table_min(s : Dbtx3pcTable) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_table_max(s : Dbtx3pcTable) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_table_to_string(s : Dbtx3pcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_graphn_make(size : Int) -> Dbtx3pcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_graphn_len(s : Dbtx3pcGraphN) -> Int { s.size }

pub fn db_tx_3pc_graphn_get(s : Dbtx3pcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_graphn_set(s : Dbtx3pcGraphN, i : Int, v : Double) -> Dbtx3pcGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_graphn_sum(s : Dbtx3pcGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_graphn_mean(s : Dbtx3pcGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_graphn_scale(s : Dbtx3pcGraphN, f : Double) -> Dbtx3pcGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_graphn_add(a : Dbtx3pcGraphN, b : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_graphn_copy(s : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_graphn_fill(s : Dbtx3pcGraphN, v : Double) -> Dbtx3pcGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_graphn_min(s : Dbtx3pcGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_graphn_max(s : Dbtx3pcGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_graphn_to_string(s : Dbtx3pcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_node_make(size : Int) -> Dbtx3pcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_node_len(s : Dbtx3pcNode) -> Int { s.size }

pub fn db_tx_3pc_node_get(s : Dbtx3pcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_node_set(s : Dbtx3pcNode, i : Int, v : Double) -> Dbtx3pcNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_node_sum(s : Dbtx3pcNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_node_mean(s : Dbtx3pcNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_node_scale(s : Dbtx3pcNode, f : Double) -> Dbtx3pcNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_node_add(a : Dbtx3pcNode, b : Dbtx3pcNode) -> Dbtx3pcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_node_copy(s : Dbtx3pcNode) -> Dbtx3pcNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_node_fill(s : Dbtx3pcNode, v : Double) -> Dbtx3pcNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_node_min(s : Dbtx3pcNode) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_node_max(s : Dbtx3pcNode) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_node_to_string(s : Dbtx3pcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_edge_make(size : Int) -> Dbtx3pcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_edge_len(s : Dbtx3pcEdge) -> Int { s.size }

pub fn db_tx_3pc_edge_get(s : Dbtx3pcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_edge_set(s : Dbtx3pcEdge, i : Int, v : Double) -> Dbtx3pcEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_edge_sum(s : Dbtx3pcEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_edge_mean(s : Dbtx3pcEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_edge_scale(s : Dbtx3pcEdge, f : Double) -> Dbtx3pcEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_edge_add(a : Dbtx3pcEdge, b : Dbtx3pcEdge) -> Dbtx3pcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_edge_copy(s : Dbtx3pcEdge) -> Dbtx3pcEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_edge_fill(s : Dbtx3pcEdge, v : Double) -> Dbtx3pcEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_edge_min(s : Dbtx3pcEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_edge_max(s : Dbtx3pcEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_edge_to_string(s : Dbtx3pcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_path_make(size : Int) -> Dbtx3pcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_path_len(s : Dbtx3pcPath) -> Int { s.size }

pub fn db_tx_3pc_path_get(s : Dbtx3pcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_path_set(s : Dbtx3pcPath, i : Int, v : Double) -> Dbtx3pcPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_path_sum(s : Dbtx3pcPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_path_mean(s : Dbtx3pcPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_path_scale(s : Dbtx3pcPath, f : Double) -> Dbtx3pcPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_path_add(a : Dbtx3pcPath, b : Dbtx3pcPath) -> Dbtx3pcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_path_copy(s : Dbtx3pcPath) -> Dbtx3pcPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_path_fill(s : Dbtx3pcPath, v : Double) -> Dbtx3pcPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_path_min(s : Dbtx3pcPath) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_path_max(s : Dbtx3pcPath) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_path_to_string(s : Dbtx3pcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cluster_make(size : Int) -> Dbtx3pcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_cluster_len(s : Dbtx3pcCluster) -> Int { s.size }

pub fn db_tx_3pc_cluster_get(s : Dbtx3pcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_cluster_set(s : Dbtx3pcCluster, i : Int, v : Double) -> Dbtx3pcCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cluster_sum(s : Dbtx3pcCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_cluster_mean(s : Dbtx3pcCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_cluster_scale(s : Dbtx3pcCluster, f : Double) -> Dbtx3pcCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cluster_add(a : Dbtx3pcCluster, b : Dbtx3pcCluster) -> Dbtx3pcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_cluster_copy(s : Dbtx3pcCluster) -> Dbtx3pcCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cluster_fill(s : Dbtx3pcCluster, v : Double) -> Dbtx3pcCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cluster_min(s : Dbtx3pcCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_cluster_max(s : Dbtx3pcCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_cluster_to_string(s : Dbtx3pcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_model_make(size : Int) -> Dbtx3pcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_model_len(s : Dbtx3pcModel) -> Int { s.size }

pub fn db_tx_3pc_model_get(s : Dbtx3pcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_model_set(s : Dbtx3pcModel, i : Int, v : Double) -> Dbtx3pcModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_model_sum(s : Dbtx3pcModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_model_mean(s : Dbtx3pcModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_model_scale(s : Dbtx3pcModel, f : Double) -> Dbtx3pcModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_model_add(a : Dbtx3pcModel, b : Dbtx3pcModel) -> Dbtx3pcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_model_copy(s : Dbtx3pcModel) -> Dbtx3pcModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_model_fill(s : Dbtx3pcModel, v : Double) -> Dbtx3pcModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_model_min(s : Dbtx3pcModel) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_model_max(s : Dbtx3pcModel) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_model_to_string(s : Dbtx3pcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_layer_make(size : Int) -> Dbtx3pcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_layer_len(s : Dbtx3pcLayer) -> Int { s.size }

pub fn db_tx_3pc_layer_get(s : Dbtx3pcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_layer_set(s : Dbtx3pcLayer, i : Int, v : Double) -> Dbtx3pcLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_layer_sum(s : Dbtx3pcLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_layer_mean(s : Dbtx3pcLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_layer_scale(s : Dbtx3pcLayer, f : Double) -> Dbtx3pcLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_layer_add(a : Dbtx3pcLayer, b : Dbtx3pcLayer) -> Dbtx3pcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_layer_copy(s : Dbtx3pcLayer) -> Dbtx3pcLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_layer_fill(s : Dbtx3pcLayer, v : Double) -> Dbtx3pcLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_layer_min(s : Dbtx3pcLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_layer_max(s : Dbtx3pcLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_layer_to_string(s : Dbtx3pcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_buffer_make(size : Int) -> Dbtx3pcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_buffer_len(s : Dbtx3pcBuffer) -> Int { s.size }

pub fn db_tx_3pc_buffer_get(s : Dbtx3pcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_buffer_set(s : Dbtx3pcBuffer, i : Int, v : Double) -> Dbtx3pcBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_buffer_sum(s : Dbtx3pcBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_buffer_mean(s : Dbtx3pcBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_buffer_scale(s : Dbtx3pcBuffer, f : Double) -> Dbtx3pcBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_buffer_add(a : Dbtx3pcBuffer, b : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_buffer_copy(s : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_buffer_fill(s : Dbtx3pcBuffer, v : Double) -> Dbtx3pcBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_buffer_min(s : Dbtx3pcBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_buffer_max(s : Dbtx3pcBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_buffer_to_string(s : Dbtx3pcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cursor_make(size : Int) -> Dbtx3pcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_cursor_len(s : Dbtx3pcCursor) -> Int { s.size }

pub fn db_tx_3pc_cursor_get(s : Dbtx3pcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_cursor_set(s : Dbtx3pcCursor, i : Int, v : Double) -> Dbtx3pcCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cursor_sum(s : Dbtx3pcCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_cursor_mean(s : Dbtx3pcCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_cursor_scale(s : Dbtx3pcCursor, f : Double) -> Dbtx3pcCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cursor_add(a : Dbtx3pcCursor, b : Dbtx3pcCursor) -> Dbtx3pcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_cursor_copy(s : Dbtx3pcCursor) -> Dbtx3pcCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cursor_fill(s : Dbtx3pcCursor, v : Double) -> Dbtx3pcCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_cursor_min(s : Dbtx3pcCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_cursor_max(s : Dbtx3pcCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_cursor_to_string(s : Dbtx3pcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_view_make(size : Int) -> Dbtx3pcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_view_len(s : Dbtx3pcView) -> Int { s.size }

pub fn db_tx_3pc_view_get(s : Dbtx3pcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_view_set(s : Dbtx3pcView, i : Int, v : Double) -> Dbtx3pcView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_view_sum(s : Dbtx3pcView) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_view_mean(s : Dbtx3pcView) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_view_scale(s : Dbtx3pcView, f : Double) -> Dbtx3pcView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_view_add(a : Dbtx3pcView, b : Dbtx3pcView) -> Dbtx3pcView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_view_copy(s : Dbtx3pcView) -> Dbtx3pcView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_view_fill(s : Dbtx3pcView, v : Double) -> Dbtx3pcView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_view_min(s : Dbtx3pcView) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_view_max(s : Dbtx3pcView) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_view_to_string(s : Dbtx3pcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_range_make(size : Int) -> Dbtx3pcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_range_len(s : Dbtx3pcRange) -> Int { s.size }

pub fn db_tx_3pc_range_get(s : Dbtx3pcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_range_set(s : Dbtx3pcRange, i : Int, v : Double) -> Dbtx3pcRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_range_sum(s : Dbtx3pcRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_range_mean(s : Dbtx3pcRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_range_scale(s : Dbtx3pcRange, f : Double) -> Dbtx3pcRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_range_add(a : Dbtx3pcRange, b : Dbtx3pcRange) -> Dbtx3pcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_range_copy(s : Dbtx3pcRange) -> Dbtx3pcRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_range_fill(s : Dbtx3pcRange, v : Double) -> Dbtx3pcRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_range_min(s : Dbtx3pcRange) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_range_max(s : Dbtx3pcRange) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_range_to_string(s : Dbtx3pcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_slice_make(size : Int) -> Dbtx3pcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_slice_len(s : Dbtx3pcSlice) -> Int { s.size }

pub fn db_tx_3pc_slice_get(s : Dbtx3pcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_slice_set(s : Dbtx3pcSlice, i : Int, v : Double) -> Dbtx3pcSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_slice_sum(s : Dbtx3pcSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_3pc_slice_mean(s : Dbtx3pcSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_3pc_slice_scale(s : Dbtx3pcSlice, f : Double) -> Dbtx3pcSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_slice_add(a : Dbtx3pcSlice, b : Dbtx3pcSlice) -> Dbtx3pcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_3pc_slice_copy(s : Dbtx3pcSlice) -> Dbtx3pcSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_slice_fill(s : Dbtx3pcSlice, v : Double) -> Dbtx3pcSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_3pc_slice_min(s : Dbtx3pcSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_3pc_slice_max(s : Dbtx3pcSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_3pc_slice_to_string(s : Dbtx3pcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

